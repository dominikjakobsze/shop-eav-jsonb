/*
===============================================================================
1. LOGIKA GŁÓWNA
===============================================================================
*/


CREATE OR REPLACE FUNCTION refresh_product_flat_by_id(p_id INTEGER)
    RETURNS VOID AS
$$
DECLARE
    v_category_id INTEGER;
    v_attributes  JSONB;
BEGIN
    -- Pobieramy aktualną kategorię produktu
    SELECT category_id INTO v_category_id FROM products WHERE id = p_id;

    -- Jeśli produkt nie istnieje (został usunięty), czyścimy tabelę płaską
    IF v_category_id IS NULL THEN
        DELETE FROM products_flat WHERE product_id = p_id;
        RETURN;
    END IF;

    -- Agregujemy wszystkie wartości ze wszystkich 5 tabel EAV w jeden JSONB
    WITH all_values AS (SELECT a.code, v.value::TEXT
                        FROM product_attribute_values_text v
                                 JOIN attributes a ON v.attribute_id = a.id
                        WHERE v.product_id = p_id
                        UNION ALL
                        SELECT a.code, v.value::TEXT
                        FROM product_attribute_values_integer v
                                 JOIN attributes a ON v.attribute_id = a.id
                        WHERE v.product_id = p_id
                        UNION ALL
                        SELECT a.code, v.value::TEXT
                        FROM product_attribute_values_decimal v
                                 JOIN attributes a ON v.attribute_id = a.id
                        WHERE v.product_id = p_id
                        UNION ALL
                        SELECT a.code, v.value::TEXT
                        FROM product_attribute_values_boolean v
                                 JOIN attributes a ON v.attribute_id = a.id
                        WHERE v.product_id = p_id
                        UNION ALL
                        SELECT a.code, v.value::TEXT
                        FROM product_attribute_values_date v
                                 JOIN attributes a ON v.attribute_id = a.id
                        WHERE v.product_id = p_id)
    SELECT jsonb_object_agg(code, value)
    INTO v_attributes
    FROM all_values;

    -- UPSERT: Wstawiamy nowy wiersz lub aktualizujemy istniejący
    INSERT INTO products_flat (product_id, category_id, attributes)
    VALUES (p_id, v_category_id, COALESCE(v_attributes, '{}'::jsonb))
    ON CONFLICT (product_id)
        DO UPDATE SET attributes  = EXCLUDED.attributes,
                      category_id = EXCLUDED.category_id;
END;
$$ LANGUAGE plpgsql;


/*
===============================================================================
2. FUNKCJE DLA TRIGGERÓW
===============================================================================
*/


CREATE OR REPLACE FUNCTION refresh_product_flat()
    RETURNS TRIGGER AS
$$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        PERFORM refresh_product_flat_by_id(OLD.product_id);
    ELSE
        PERFORM refresh_product_flat_by_id(NEW.product_id);
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION handle_product_changes()
    RETURNS TRIGGER AS
$$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        DELETE FROM products_flat WHERE product_id = OLD.id;
    ELSE
        PERFORM refresh_product_flat_by_id(NEW.id);
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


/*
===============================================================================
3. REJESTRACJA TRIGGERÓW
===============================================================================
*/


CREATE TRIGGER trg_flat_text
    AFTER INSERT OR UPDATE OR DELETE
    ON product_attribute_values_text
    FOR EACH ROW
EXECUTE FUNCTION refresh_product_flat();

CREATE TRIGGER trg_flat_integer
    AFTER INSERT OR UPDATE OR DELETE
    ON product_attribute_values_integer
    FOR EACH ROW
EXECUTE FUNCTION refresh_product_flat();

CREATE TRIGGER trg_flat_decimal
    AFTER INSERT OR UPDATE OR DELETE
    ON product_attribute_values_decimal
    FOR EACH ROW
EXECUTE FUNCTION refresh_product_flat();

CREATE TRIGGER trg_flat_boolean
    AFTER INSERT OR UPDATE OR DELETE
    ON product_attribute_values_boolean
    FOR EACH ROW
EXECUTE FUNCTION refresh_product_flat();

CREATE TRIGGER trg_flat_date
    AFTER INSERT OR UPDATE OR DELETE
    ON product_attribute_values_date
    FOR EACH ROW
EXECUTE FUNCTION refresh_product_flat();


CREATE TRIGGER trg_product_flat_sync
    AFTER INSERT OR UPDATE OF category_id OR DELETE
    ON products
    FOR EACH ROW
EXECUTE FUNCTION handle_product_changes();
