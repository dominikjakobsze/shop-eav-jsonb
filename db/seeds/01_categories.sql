INSERT INTO categories (id, name, parent_id)
VALUES (1, 'Electronics', NULL),
       (2, 'Phones', 1),
       (3, 'TVs', 1),
       (4, 'Computing', 1),
       (5, 'Laptops', 4),
       (6, 'Gaming Laptops', 5);
