package com.alexjr.stock_control_api.dto;

import java.math.BigDecimal;

public record ProductSuggestionDTO(
        Long productId,
        String productName,
        String productCode,
        Integer quantityToProduce,
        BigDecimal unitPrice,
        BigDecimal subtotal
) {}