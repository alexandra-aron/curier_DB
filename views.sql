-- =========================
-- VIEW 1: DETALII LIVRARI
-- =========================

CREATE OR REPLACE VIEW v_detalii_livrari AS
SELECT
    c.id_colet,
    exp.nume AS expeditor,
    dest.nume AS destinatar,
    cu.nume AS curier,
    c.greutate_kg,
    c.status,
    l.data_preluare,
    l.data_livrare
FROM colete c
JOIN clienti exp ON c.id_client_expeditor = exp.id_client
JOIN clienti dest ON c.id_client_destinatar = dest.id_client
JOIN livrari l ON c.id_colet = l.id_colet
JOIN curieri cu ON l.id_curier = cu.id_curier;


-- =========================
-- VIEW 2: STATISTICI CURIERI
-- =========================

CREATE OR REPLACE VIEW v_statistici_curieri AS
SELECT
    cu.id_curier,
    cu.nume,
    COUNT(l.id_livrare) AS numar_livrari,
    COALESCE(SUM(p.suma), 0) AS venit_generat
FROM curieri cu
LEFT JOIN livrari l ON cu.id_curier = l.id_curier
LEFT JOIN plati p ON l.id_colet = p.id_colet
GROUP BY cu.id_curier, cu.nume;


-- =========================
-- VIEW 3: VENITURI COLETE
-- =========================

CREATE OR REPLACE VIEW v_venituri_colete AS
SELECT
    c.id_colet,
    c.status,
    p.suma
FROM colete c
JOIN plati p ON c.id_colet = p.id_colet;