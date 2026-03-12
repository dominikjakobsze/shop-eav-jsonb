CREATE TABLE product_attribute_values_integer
(
    product_id   INT REFERENCES products (id),
    attribute_id INT REFERENCES attributes (id),
    value        INTEGER,
    PRIMARY KEY (product_id, attribute_id)
);
