INSERT INTO attributes (id, code, label, data_type, category_id, is_filterable)
VALUES (1, 'color', 'Color', 'text', 1, TRUE),
       (2, 'screen_size', 'Screen Size', 'decimal', 1, TRUE),
       (3, 'series', 'Series', 'text', 1, TRUE),
       (6, 'brand', 'Brand', 'text', 1, TRUE),
       (7, 'os', 'Operating System', 'text', 1, TRUE);

INSERT INTO attributes (id, code, label, data_type, category_id, is_filterable)
VALUES (4, 'is_waterproof', 'Is Waterproof', 'boolean', 2, TRUE),
       (5, 'has_5g', 'Has 5G', 'boolean', 2, TRUE);


INSERT INTO attributes (id, code, label, data_type, category_id, is_filterable)
VALUES (13, 'speaker_power', 'Speaker Power', 'integer', 3, TRUE);

INSERT INTO attributes (id, code, label, data_type, category_id, is_filterable)
VALUES (14, 'ram_size', 'RAM Size (GB)', 'integer', 5, TRUE),
       (15, 'processor', 'Processor Model', 'text', 5, TRUE);

INSERT INTO attributes (id, code, label, data_type, category_id, is_filterable)
VALUES (16, 'gpu_model', 'Graphics Card', 'text', 6, TRUE),
       (17, 'refresh_rate', 'Refresh Rate (Hz)', 'integer', 6, TRUE);
