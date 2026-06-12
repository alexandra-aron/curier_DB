-- =========================
-- PROCEDURE 1: ACTUALIZARE STATUS COLET
-- =========================

CREATE OR REPLACE PROCEDURE actualizare_status_colet(
    p_id_colet INT,
    p_status VARCHAR
)
LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE colete
    SET status = p_status
    WHERE id_colet = p_id_colet;
END;
$$;


-- =========================
-- PROCEDURE 2: ADAUGA COLET
-- =========================

CREATE OR REPLACE PROCEDURE adauga_colet(
    p_expeditor INT,
    p_destinatar INT,
    p_ridicare INT,
    p_livrare INT,
    p_greutate NUMERIC
)
LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO colete(
        id_client_expeditor,
        id_client_destinatar,
        adresa_ridicare,
        adresa_livrare,
        greutate_kg,
        status
    )
    VALUES(
        p_expeditor,
        p_destinatar,
        p_ridicare,
        p_livrare,
        p_greutate,
        'INREGISTRAT'
    );
END;
$$;
