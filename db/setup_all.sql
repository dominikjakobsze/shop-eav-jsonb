\i db/schema/01_categories.sql
\i db/schema/02_products.sql
\i db/schema/03_attributes.sql
\i db/schema/04_products_flat.sql
\i db/schema/05_values_text.sql
\i db/schema/06_values_integer.sql
\i db/schema/07_values_decimal.sql
\i db/schema/08_values_boolean.sql
\i db/schema/09_values_date.sql

\i db/triggers/sync_eav_to_flat_table.sql

\i db/seeds/01_categories.sql
\i db/seeds/02_attributes.sql
\i db/seeds/03_products.sql
\i db/seeds/04_product_values.sql

SELECT 'DATABASE SETUP COMPLETED SUCCESSFULLY!' as status;
