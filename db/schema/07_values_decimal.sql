CREATE TABLE product_attribute_values_decimal
(
    product_id   INT REFERENCES products (id),
    attribute_id INT REFERENCES attributes (id),
    value        DECIMAL(10, 4),
    PRIMARY KEY (product_id, attribute_id)
);
