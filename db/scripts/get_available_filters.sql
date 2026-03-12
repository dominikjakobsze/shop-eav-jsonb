WITH RECURSIVE category_tree_up AS (SELECT id, parent_id, name, 1 AS level
                                    FROM categories
                                    WHERE id = 6
                                    UNION ALL
                                    SELECT c.id, c.parent_id, c.name, ctu.level + 1
                                    FROM categories c
                                             JOIN category_tree_up ctu
                                                  ON c.id = ctu.parent_id)
SELECT a.id        AS attribute_id,
       a.code      AS attribute_code,
       a.label     AS attribute_label,
       a.data_type AS attribute_data_type
FROM category_tree_up ctu
         JOIN attributes a
              ON ctu.id = a.category_id
WHERE is_filterable = TRUE
ORDER BY a.code;
