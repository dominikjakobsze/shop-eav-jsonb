CREATE TABLE products
(
    id          SERIAL PRIMARY KEY,
    sku         VARCHAR(100) UNIQUE NOT NULL,
    name        VARCHAR(255)        NOT NULL,
    price       DECIMAL(10, 2)      NOT NULL,
    category_id INT REFERENCES categories (id),
    created_at  TIMESTAMPTZ DEFAULT NOW()
);
