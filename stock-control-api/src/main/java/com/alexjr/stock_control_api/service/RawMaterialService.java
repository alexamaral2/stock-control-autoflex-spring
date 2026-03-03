package com.alexjr.stock_control_api.service;

import com.alexjr.stock_control_api.dto.RawMaterialDTO;
import com.alexjr.stock_control_api.dto.RawMaterialResponseDTO;
import com.alexjr.stock_control_api.exception.ValidationException;
import com.alexjr.stock_control_api.model.RawMaterial;
import com.alexjr.stock_control_api.repository.ProductRawMaterialRepository;
import com.alexjr.stock_control_api.repository.RawMaterialRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class RawMaterialService {

    private final RawMaterialRepository repository;
    private final ProductRawMaterialRepository productRawMaterialRepository;

    public RawMaterialService(RawMaterialRepository repository,
                              ProductRawMaterialRepository productRawMaterialRepository) {
        this.repository = repository;
        this.productRawMaterialRepository = productRawMaterialRepository;
    }

    @Transactional(readOnly = true)
    public List<RawMaterialResponseDTO> listAll() {
        return repository.findAll()
                .stream()
                .map(this::toResponseDTO)
                .toList();
    }

    @Transactional(readOnly = true)
    public Optional<RawMaterialResponseDTO> findById(Long id) {
        return repository.findById(id)
                .map(this::toResponseDTO);
    }

    @Transactional
    public RawMaterialResponseDTO create(RawMaterialDTO dto) {
        if (repository.existsByCode(dto.code())) {
            throw new ValidationException("Raw material code already exists");
        }

        RawMaterial entity = toEntity(dto);
        RawMaterial saved = repository.save(entity);

        return toResponseDTO(saved);
    }

    @Transactional
    public RawMaterialResponseDTO update(Long id, RawMaterialDTO dto) {
        RawMaterial entity = repository.findById(id)
                .orElseThrow(() -> new ValidationException("RawMaterial not found"));

        if (repository.existsByCodeAndIdNot(dto.code(), id)) {
            throw new ValidationException("Raw material code already exists");
        }

        entity.setCode(dto.code());
        entity.setName(dto.name());
        entity.setQuantity(dto.quantity());

        RawMaterial saved = repository.save(entity);
        return toResponseDTO(saved);
    }

    @Transactional
    public void delete(Long id) {
        RawMaterial entity = repository.findById(id)
                .orElseThrow(() -> new ValidationException("RawMaterial not found"));

        if (productRawMaterialRepository.existsByRawMaterialId(id)) {
            throw new ValidationException("Cannot delete: This raw material is linked to one or more products.");
        }

        repository.delete(entity);
    }

    private RawMaterial toEntity(RawMaterialDTO dto) {
        RawMaterial entity = new RawMaterial();
        entity.setCode(dto.code());
        entity.setName(dto.name());
        entity.setQuantity(dto.quantity());
        return entity;
    }

    private RawMaterialResponseDTO toResponseDTO(RawMaterial entity) {
        return new RawMaterialResponseDTO(
                entity.getId(),
                entity.getCode(),
                entity.getName(),
                entity.getQuantity()
        );
    }
}