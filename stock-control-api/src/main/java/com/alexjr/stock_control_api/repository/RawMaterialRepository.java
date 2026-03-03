package com.alexjr.stock_control_api.repository;

import com.alexjr.stock_control_api.model.RawMaterial;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RawMaterialRepository extends JpaRepository<RawMaterial, Long> {

    boolean existsByCode(String code);

    boolean existsByCodeAndIdNot(String code, Long id);

    List<RawMaterial> findByIdIn(List<Long> ids);
}
