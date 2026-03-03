package com.alexjr.stock_control_api.service;

import com.alexjr.stock_control_api.dto.RawMaterialDTO;
import com.alexjr.stock_control_api.dto.RawMaterialResponseDTO;
import com.alexjr.stock_control_api.exception.ValidationException;
import com.alexjr.stock_control_api.model.Product;
import com.alexjr.stock_control_api.model.ProductRawMaterial;
import com.alexjr.stock_control_api.model.RawMaterial;
import com.alexjr.stock_control_api.repository.ProductRepository;
import com.alexjr.stock_control_api.repository.RawMaterialRepository;
import jakarta.persistence.EntityManager;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Set;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
class RawMaterialServiceTest {

    @Autowired
    private RawMaterialService rawMaterialService;

    @Autowired
    private RawMaterialRepository rawMaterialRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private EntityManager entityManager;

    @BeforeEach
    void setup() {
        productRepository.deleteAll();
        rawMaterialRepository.deleteAll();
        entityManager.flush();
    }

    @Test
    void shouldCreateRawMaterial() {
        RawMaterialDTO dto = new RawMaterialDTO("RM001", "Steel", 100);
        RawMaterialResponseDTO response = rawMaterialService.create(dto);

        assertNotNull(response.id());
        assertEquals("RM001", response.code());
    }

    @Test
    void shouldThrowExceptionWhenCodeExists() {
        RawMaterialDTO dto = new RawMaterialDTO("UNIQUE", "Material", 10);
        rawMaterialService.create(dto);

        assertThrows(ValidationException.class, () -> rawMaterialService.create(dto));
    }

    @Test
    void shouldPreventDeletionWhenLinkedToProduct() {
        RawMaterial rm = new RawMaterial();
        rm.setCode("LINKED-RM");
        rm.setName("Material");
        rm.setQuantity(10);
        rm = rawMaterialRepository.save(rm);

        Product product = Product.builder()
                .code("P1")
                .name("Product")
                .price(BigDecimal.ONE)
                .build();

        ProductRawMaterial association = ProductRawMaterial.builder()
                .product(product)
                .rawMaterial(rm)
                .quantity(1)
                .build();

        product.setMaterials(Set.of(association));
        productRepository.save(product);

        entityManager.flush();
        entityManager.clear();

        final Long materialId = rm.getId();
        ValidationException exception = assertThrows(ValidationException.class, () -> {
            rawMaterialService.delete(materialId);
        });

        assertEquals("Cannot delete: This raw material is linked to one or more products.", exception.getMessage());
    }

    @Test
    void shouldUpdateQuantitySuccessfully() {
        RawMaterialDTO dto = new RawMaterialDTO("RM_UPD", "Name", 10);
        RawMaterialResponseDTO created = rawMaterialService.create(dto);

        RawMaterialDTO updateDto = new RawMaterialDTO("RM_UPD", "New Name", 50);
        RawMaterialResponseDTO updated = rawMaterialService.update(created.id(), updateDto);

        assertEquals(50, updated.quantity());
        assertEquals("New Name", updated.name());
    }

    @Test
    void shouldThrowExceptionWhenDeletingNonExistent() {
        assertThrows(ValidationException.class, () -> rawMaterialService.delete(999L));
    }
}