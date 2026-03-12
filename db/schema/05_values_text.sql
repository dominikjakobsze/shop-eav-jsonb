CREATE TABLE product_attribute_values_text
(
    product_id   INT REFERENCES products (id),
    attribute_id INT REFERENCES attributes (id),
    value        TEXT,
    PRIMARY KEY (product_id, attribute_id)
);
