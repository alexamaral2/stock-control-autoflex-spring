package com.alexjr.stock_control_api.dto;

import java.math.BigDecimal;
import java.util.List;

public record ProductionSuggestionResponseDTO(
        List<ProductSuggestionDTO> suggestions,
        BigDecimal totalEstimatedValue
) {}