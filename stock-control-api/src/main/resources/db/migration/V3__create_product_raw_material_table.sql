CREATE TABLE product_raw_material (
    id BIGSERIAL PRIMARY KEY,

    product_id BIGINT NOT NULL,
    raw_material_id BIGINT NOT NULL,

    quantity INTEGER NOT NULL CHECK (quantity > 0),

    CONSTRAINT fk_prm_product
        FOREIGN KEY (product_id) REFERENCES product(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_prm_raw_material
        FOREIGN KEY (raw_material_id) REFERENCES raw_material(id)
        ON DELETE RESTRICT,

    CONSTRAINT uk_prm_product_raw_material
        UNIQUE (product_id, raw_material_id)
);

CREATE INDEX idx_prm_product_id ON product_raw_material(product_id);
CREATE INDEX idx_prm_raw_material_id ON product_raw_material(raw_material_id);