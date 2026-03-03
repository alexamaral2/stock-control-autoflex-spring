package com.alexjr.stock_control_api.dto;

public record MaterialResponseDTO(
        Long rawMaterialId,
        String code,
        String name,
        Integer quantity
) {}