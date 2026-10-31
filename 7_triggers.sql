-- =========================
-- AUDIT TABLE (istoric status colete)
-- =========================

CREATE TABLE istoric_status_colete (
    id_istoric INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_colet INT NOT NULL,
    status_vechi VARCHAR(30),
    status_nou VARCHAR(30),
    data_modificare TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- TRIGGER 1: AUDIT STATUS COLET
-- =========================

CREATE OR REPLACE FUNCTION trg_audit_status()
RETURNS TRIGGER AS
$$
BEGIN
    IF OLD.status IS DISTINCT FROM NEW.status THEN
        INSERT INTO istoric_status_colete (
            id_colet,
            status_vechi,
            status_nou
        )
        VALUES (
            NEW.id_colet,
            OLD.status,
            NEW.status
        );
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER audit_status_trigger
AFTER UPDATE ON colete
FOR EACH ROW
EXECUTE FUNCTION trg_audit_status();


-- =========================
-- TRIGGER 2: AUTO STATUS = LIVRAT
-- =========================

CREATE OR REPLACE FUNCTION trg_seteaza_livrat()
RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.data_livrare IS NOT NULL THEN
        NEW.status := 'LIVRAT';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_livrat_trigger
BEFORE INSERT OR UPDATE ON livrari
FOR EACH ROW
EXECUTE FUNCTION trg_seteaza_livrat();


-- =========================
-- TRIGGER 3: VALIDARE STATUS COLET
-- =========================

CREATE OR REPLACE FUNCTION trg_validare_status()
RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.status NOT IN ('INREGISTRAT', 'IN_DEPOZIT', 'IN_TRANZIT', 'LIVRAT') THEN
        RAISE EXCEPTION 'Status invalid pentru colet';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validare_status_trigger
BEFORE INSERT OR UPDATE ON colete
FOR EACH ROW
EXECUTE FUNCTION trg_validare_status();
