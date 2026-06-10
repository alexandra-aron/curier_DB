-- =========================
-- FUNCTION 1: TOTAL INCASARI
-- =========================

CREATE OR REPLACE FUNCTION total_incasari()
RETURNS NUMERIC AS
$$
DECLARE
    total NUMERIC;
BEGIN
    SELECT COALESCE(SUM(suma), 0)
    INTO total
    FROM plati;

    RETURN total;
END;
$$ LANGUAGE plpgsql;


-- =========================
-- FUNCTION 2: NUMAR LIVRARI CURIER
-- =========================

CREATE OR REPLACE FUNCTION numar_livrari_curier(
    p_id_curier INT
)
RETURNS INT AS
$$
DECLARE
    nr INT;
BEGIN
    SELECT COUNT(*)
    INTO nr
    FROM livrari
    WHERE id_curier = p_id_curier;

    RETURN nr;
END;
$$ LANGUAGE plpgsql;


-- =========================
-- FUNCTION 3: VENIT CURIER
-- =========================

CREATE OR REPLACE FUNCTION venit_curier(
    p_id_curier INT
)
RETURNS NUMERIC AS
$$
DECLARE
    total NUMERIC;
BEGIN
    SELECT COALESCE(SUM(p.suma), 0)
    INTO total
    FROM plati p
    JOIN colete c ON p.id_colet = c.id_colet
    JOIN livrari l ON c.id_colet = l.id_colet
    WHERE l.id_curier = p_id_curier;

    RETURN total;
END;
$$ LANGUAGE plpgsql;


-- =========================
-- FUNCTION 4: CATEGORIE GREUTATE
-- =========================

CREATE OR REPLACE FUNCTION categorie_greutate(
    p_greutate NUMERIC
)
RETURNS VARCHAR AS
$$
BEGIN
    IF p_greutate < 1 THEN
        RETURN 'USOR';
    ELSIF p_greutate <= 5 THEN
        RETURN 'MEDIU';
    ELSE
        RETURN 'GREU';
    END IF;
END;
$$ LANGUAGE plpgsql;