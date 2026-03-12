CREATE TABLE product_attribute_values_boolean
(
    product_id   INT REFERENCES products (id),
    attribute_id INT REFERENCES attributes (id),
    value        BOOLEAN,
    PRIMARY KEY (product_id, attribute_id)
);
