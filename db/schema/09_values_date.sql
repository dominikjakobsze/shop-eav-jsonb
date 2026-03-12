CREATE TABLE product_attribute_values_date
(
    product_id   INT REFERENCES products (id),
    attribute_id INT REFERENCES attributes (id),
    value        DATE,
    PRIMARY KEY (product_id, attribute_id)
);
