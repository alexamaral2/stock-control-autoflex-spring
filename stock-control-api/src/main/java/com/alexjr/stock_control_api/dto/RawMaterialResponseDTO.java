package com.alexjr.stock_control_api.dto;

public record RawMaterialResponseDTO(
        Long id,
        String code,
        String name,
        Integer quantity
) {}