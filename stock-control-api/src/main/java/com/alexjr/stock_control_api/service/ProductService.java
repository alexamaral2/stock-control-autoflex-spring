package com.alexjr.stock_control_api.service;

import com.alexjr.stock_control_api.dto.*;
import com.alexjr.stock_control_api.exception.ValidationException;
import com.alexjr.stock_control_api.model.Product;
import com.alexjr.stock_control_api.model.ProductRawMaterial;
import com.alexjr.stock_control_api.model.RawMaterial;
import com.alexjr.stock_control_api.repository.ProductRepository;
import com.alexjr.stock_control_api.repository.RawMaterialRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Transactional
public class ProductService {

    private final ProductRepository productRepository;
    private final RawMaterialRepository rawMaterialRepository;

    public ProductService(ProductRepository productRepository,
                          RawMaterialRepository rawMaterialRepository) {
        this.productRepository = productRepository;
        this.rawMaterialRepository = rawMaterialRepository;
    }

    @Transactional(readOnly = true)
    public List<ProductResponseDTO> findAll() {
        return productRepository.findAll().stream()
                .map(this::toResponseDTO)
                .toList();
    }

    @Transactional(readOnly = true)
    public Optional<ProductResponseDTO> findById(Long id) {
        return productRepository.findById(id)
                .map(this::toResponseDTO);
    }

    public ProductResponseDTO create(ProductDTO dto) {
        if (productRepository.existsByCode(dto.code())) {
            throw new ValidationException("Product code already exists");
        }

        Product product = Product.builder()
                .code(dto.code())
                .name(dto.name())
                .price(dto.price())
                .build();

        updateMaterialsList(product, dto);

        Product saved = productRepository.save(product);
        return toResponseDTO(saved);
    }

    public ProductResponseDTO update(Long id, ProductDTO dto) {
        Product entity = productRepository.findById(id)
                .orElseThrow(() -> new ValidationException("Product not found"));

        if (productRepository.existsByCodeAndIdNot(dto.code(), id)) {
            throw new ValidationException("Product code already exists");
        }

        entity.setCode(dto.code());
        entity.setName(dto.name());
        entity.setPrice(dto.price());

        entity.getMaterials().clear();
        productRepository.saveAndFlush(entity);

        updateMaterialsList(entity, dto);

        return toResponseDTO(productRepository.save(entity));
    }

    public void delete(Long id) {
        if (!productRepository.existsById(id)) {
            throw new ValidationException("Product not found");
        }
        productRepository.deleteById(id);
    }

    private void updateMaterialsList(Product product, ProductDTO dto) {

        if (dto.materials() == null || dto.materials().isEmpty()) {
            return;
        }

        List<Long> materialIds = dto.materials().stream()
                .map(ProductMaterialDTO::rawMaterialId)
                .toList();

        if (materialIds.stream().distinct().count() < materialIds.size()) {
            throw new ValidationException("Duplicate materials found in the list");
        }

        Map<Long, RawMaterial> materialsMap = rawMaterialRepository
                .findByIdIn(materialIds)
                .stream()
                .collect(Collectors.toMap(RawMaterial::getId, m -> m));

        dto.materials().forEach(mDto -> {

            RawMaterial rawMaterial = materialsMap.get(mDto.rawMaterialId());

            if (rawMaterial == null) {
                throw new ValidationException(
                        "Raw Material not found: " + mDto.rawMaterialId()
                );
            }

            ProductRawMaterial association = ProductRawMaterial.builder()
                    .product(product)
                    .rawMaterial(rawMaterial)
                    .quantity(mDto.quantity().intValue())
                    .build();

            product.getMaterials().add(association);
        });
    }

    @Transactional(readOnly = true)
    public ProductionSuggestionResponseDTO calculateProductionSuggestion() {

        List<Product> sortedProducts = productRepository.findAllByOrderByPriceDesc();
        Map<Long, Integer> virtualStock = getInitialVirtualStock();

        List<ProductSuggestionDTO> suggestions = new ArrayList<>();
        BigDecimal totalEstimatedValue = BigDecimal.ZERO;

        for (Product product : sortedProducts) {

            int qtyPossible = calculateMaxPossible(product, virtualStock);

            if (qtyPossible > 0) {

                ProductSuggestionDTO suggestion = createSuggestionDTO(product, qtyPossible);
                suggestions.add(suggestion);

                totalEstimatedValue = totalEstimatedValue.add(suggestion.subtotal());
                updateVirtualStock(product, qtyPossible, virtualStock);
            }
        }

        return new ProductionSuggestionResponseDTO(suggestions, totalEstimatedValue);
    }

    private Map<Long, Integer> getInitialVirtualStock() {
        return rawMaterialRepository.findAll().stream()
                .collect(Collectors.toMap(RawMaterial::getId, RawMaterial::getQuantity));
    }

    private int calculateMaxPossible(Product product, Map<Long, Integer> virtualStock) {

        if (product.getMaterials().isEmpty()) {
            return 0;
        }

        int maxPossible = Integer.MAX_VALUE;

        for (ProductRawMaterial prm : product.getMaterials()) {

            int stockAvailable = virtualStock
                    .getOrDefault(prm.getRawMaterial().getId(), 0);

            int consumptionPerUnit = prm.getQuantity();

            if (consumptionPerUnit == 0) {
                continue;
            }

            int canMakeWithThisMaterial = stockAvailable / consumptionPerUnit;
            maxPossible = Math.min(maxPossible, canMakeWithThisMaterial);
        }

        return maxPossible == Integer.MAX_VALUE ? 0 : maxPossible;
    }

    private void updateVirtualStock(Product product,
                                    int qtyProduced,
                                    Map<Long, Integer> virtualStock) {

        for (ProductRawMaterial prm : product.getMaterials()) {

            Long materialId = prm.getRawMaterial().getId();
            int totalConsumed = qtyProduced * prm.getQuantity();

            virtualStock.computeIfPresent(materialId,
                    (id, current) -> current - totalConsumed);
        }
    }

    private ProductSuggestionDTO createSuggestionDTO(Product product,
                                                     int quantity) {

        BigDecimal subtotal =
                product.getPrice().multiply(BigDecimal.valueOf(quantity));

        return new ProductSuggestionDTO(
                product.getName(),
                product.getCode(),
                quantity,
                product.getPrice(),
                subtotal
        );
    }

    private ProductResponseDTO toResponseDTO(Product product) {

        List<MaterialResponseDTO> materials =
                product.getMaterials().stream()
                        .map(m -> new MaterialResponseDTO(
                                m.getRawMaterial().getId(),
                                m.getRawMaterial().getCode(),
                                m.getRawMaterial().getName(),
                                m.getQuantity()
                        ))
                        .toList();

        return new ProductResponseDTO(
                product.getId(),
                product.getCode(),
                product.getName(),
                product.getPrice(),
                materials
        );
    }
}