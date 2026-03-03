CREATE TABLE product (
    id BIGSERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(120) NOT NULL,
    price NUMERIC(15,2) NOT NULL,
    CONSTRAINT uk_product_code UNIQUE (code)
);