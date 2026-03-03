package com.alexjr.stock_control_api.repository;

import com.alexjr.stock_control_api.model.ProductRawMaterial;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRawMaterialRepository extends JpaRepository<ProductRawMaterial, Long> {

    boolean existsByRawMaterialId(Long rawMaterialId);

}