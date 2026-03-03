package com.alexjr.stock_control_api.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;

public record RawMaterialDTO(
        @NotBlank(message = "Raw material code is required")
        String code,

        @NotBlank(message = "Raw material name is required")
        String name,

        @NotNull(message = "Quantity is required")
        @PositiveOrZero(message = "Quantity cannot be negative")
        Integer quantity
) {}