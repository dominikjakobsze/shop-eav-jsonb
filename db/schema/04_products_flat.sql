CREATE TABLE products_flat
(
    id          SERIAL PRIMARY KEY,
    product_id  INT UNIQUE REFERENCES products (id),
    category_id INT REFERENCES categories (id),
    attributes  JSONB
);

CREATE INDEX idx_products_flat_attributes ON products_flat USING GIN (attributes);
CREATE INDEX idx_products_flat_category_id ON products_flat (category_id);
