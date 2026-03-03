package com.alexjr.stock_control_api.dto;

import java.math.BigDecimal;
import java.util.List;

public record ProductResponseDTO(
        Long id,
        String code,
        String name,
        BigDecimal price,
        List<MaterialResponseDTO> materials
) {}