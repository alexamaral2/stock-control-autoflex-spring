package com.alexjr.stock_control_api.controller;

import com.alexjr.stock_control_api.dto.ProductDTO;
import com.alexjr.stock_control_api.dto.ProductResponseDTO;
import com.alexjr.stock_control_api.dto.ProductionSuggestionResponseDTO;
import com.alexjr.stock_control_api.service.ProductService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/products")
public class ProductController {

    private final ProductService service;

    public ProductController(ProductService service) {
        this.service = service;
    }

    @GetMapping
    public List<ProductResponseDTO> list() {
        return service.findAll();
    }

    @GetMapping("/{id}")
    public ProductResponseDTO get(@PathVariable("id") Long id) {
        return service.findById(id)
                .orElseThrow(() -> new org.springframework.web.server.ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Product not found"
                ));
    }

    @PostMapping
    public ResponseEntity<ProductResponseDTO> create(
            @RequestBody @Valid @NotNull(message = "Request body is required") ProductDTO dto
    ) {
        ProductResponseDTO created = service.create(dto);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}")
    public ProductResponseDTO update(
            @PathVariable("id") Long id,
            @RequestBody @Valid @NotNull(message = "Request body is required") ProductDTO dto
    ) {
        return service.update(id, dto);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable("id") Long id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/production-suggestions")
    public ProductionSuggestionResponseDTO getProductionSuggestions() {
        return service.calculateProductionSuggestion();
    }
}