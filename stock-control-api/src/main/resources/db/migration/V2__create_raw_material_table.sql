CREATE TABLE raw_material (
    id BIGSERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(120) NOT NULL,
    quantity INTEGER NOT NULL,
    CONSTRAINT uk_raw_material_code UNIQUE (code)
);