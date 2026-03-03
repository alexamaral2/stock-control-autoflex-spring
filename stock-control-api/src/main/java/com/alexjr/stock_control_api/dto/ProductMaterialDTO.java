package com.alexjr.stock_control_api.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record ProductMaterialDTO(
        @NotNull(message = "Raw Material ID is required")
        Long rawMaterialId,

        @NotNull(message = "Quantity is required")
        @Positive(message = "Quantity must be greater than zero")
        Double quantity
) {}
