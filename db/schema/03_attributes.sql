CREATE TABLE attributes
(
    id            SERIAL PRIMARY KEY,
    code          VARCHAR(100) NOT NULL UNIQUE,
    label         VARCHAR(255) NOT NULL,
    data_type     VARCHAR(10)  NOT NULL CHECK (data_type IN ('text', 'integer', 'decimal', 'boolean', 'date')),
    category_id   INT REFERENCES categories (id),
    is_filterable BOOLEAN DEFAULT FALSE,
    is_required   BOOLEAN DEFAULT FALSE
);
