package com.alexjr.stock_control_api.service;

import com.alexjr.stock_control_api.dto.ProductDTO;
import com.alexjr.stock_control_api.dto.ProductMaterialDTO;
import com.alexjr.stock_control_api.exception.ValidationException;
import com.alexjr.stock_control_api.model.RawMaterial;
import com.alexjr.stock_control_api.repository.ProductRepository;
import com.alexjr.stock_control_api.repository.RawMaterialRepository;
import jakarta.persistence.EntityManager;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

@SpringBootTest
@Transactional
class ProductServiceValidationTest {

    @Autowired
    private ProductService productService;

    @Autowired
    private RawMaterialRepository rawMaterialRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private EntityManager entityManager;

    private Long materialId;

    @BeforeEach
    void setup() {
        productRepository.deleteAll();
        rawMaterialRepository.deleteAll();

        entityManager.flush();

        RawMaterial rawMaterial = new RawMaterial();
        rawMaterial.setCode("RM_TEST_" + System.currentTimeMillis());
        rawMaterial.setName("Test Material");
        rawMaterial.setQuantity(50);

        rawMaterial = rawMaterialRepository.save(rawMaterial);
        this.materialId = rawMaterial.getId();

        entityManager.flush();
    }

    @Test
    @DisplayName("Should throw exception when duplicate materials are provided")
    void shouldThrowExceptionWhenDuplicateMaterialsAreProvided() {
        ProductMaterialDTO item1 = new ProductMaterialDTO(materialId, 5.0);
        ProductMaterialDTO item2 = new ProductMaterialDTO(materialId, 10.0);

        ProductDTO productDTO = new ProductDTO(
                "P_DUPLICATE",
                "Invalid Product",
                new BigDecimal("10.00"),
                List.of(item1, item2)
        );

        ValidationException exception = assertThrows(ValidationException.class, () -> {
            productService.create(productDTO);
        });

        assertEquals("Duplicate materials found in the list", exception.getMessage());
    }

    @Test
    @DisplayName("Should throw exception when raw material ID does not exist")
    void shouldThrowExceptionWhenRawMaterialDoesNotExist() {
        Long nonExistentId = 999L;
        ProductMaterialDTO item = new ProductMaterialDTO(nonExistentId, 5.0);

        ProductDTO productDTO = new ProductDTO(
                "P_NOT_FOUND",
                "Phantom Product",
                new BigDecimal("10.00"),
                List.of(item)
        );

        ValidationException exception = assertThrows(ValidationException.class, () -> {
            productService.create(productDTO);
        });

        assertEquals("Raw Material not found: " + nonExistentId, exception.getMessage());
    }
}