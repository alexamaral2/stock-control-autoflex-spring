package com.alexjr.stock_control_api.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(
        name = "product_raw_material",
        uniqueConstraints = @UniqueConstraint(
                columnNames = {"product_id", "raw_material_id"}
        )
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class ProductRawMaterial {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "product_id", nullable = false)
    @EqualsAndHashCode.Include
    private Product product;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "raw_material_id", nullable = false)
    @EqualsAndHashCode.Include
    private RawMaterial rawMaterial;

    @Column(nullable = false)
    private Integer quantity;
}