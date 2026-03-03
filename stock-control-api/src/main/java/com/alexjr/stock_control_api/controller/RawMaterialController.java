package com.alexjr.stock_control_api.controller;

import com.alexjr.stock_control_api.dto.RawMaterialDTO;
import com.alexjr.stock_control_api.dto.RawMaterialResponseDTO;
import com.alexjr.stock_control_api.service.RawMaterialService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/raw-materials")
public class RawMaterialController {

    private final RawMaterialService service;

    public RawMaterialController(RawMaterialService service) {
        this.service = service;
    }

    @GetMapping
    public List<RawMaterialResponseDTO> list() {
        return service.listAll();
    }

    @GetMapping("/{id}")
    public RawMaterialResponseDTO get(@PathVariable("id") Long id) {
        return service.findById(id)
                .orElseThrow(() -> new org.springframework.web.server.ResponseStatusException(
                        HttpStatus.NOT_FOUND,
                        "RawMaterial not found"
                ));
    }

    @PostMapping
    public ResponseEntity<RawMaterialResponseDTO> create(
            @RequestBody @Valid @NotNull(message = "Request body is required")
            RawMaterialDTO dto
    ) {
        RawMaterialResponseDTO created = service.create(dto);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}")
    public RawMaterialResponseDTO update(
            @PathVariable("id") Long id,
            @RequestBody @Valid @NotNull(message = "Request body is required")
            RawMaterialDTO dto
    ) {
        return service.update(id, dto);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable("id") Long id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }
}