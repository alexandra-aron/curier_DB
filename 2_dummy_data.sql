
-- ======================
-- CLIENTI (MANUAL)
-- ======================
INSERT INTO clienti (nume, telefon) VALUES
('Andrei Popescu','0723456781'),
('Maria Ionescu','0734567892'),
('Alexandru Stan','0745678903'),
('Ioana Dumitrescu','0756789014'),
('Radu Marinescu','0767890125');


-- ======================
-- ADRESE (MANUAL)
-- ======================
INSERT INTO adrese (strada, oras) VALUES
('Strada Unirii 10','Bucuresti'),
('Strada Memorandumului 5','Cluj-Napoca'),
('Strada Stefan cel Mare 20','Iasi'),
('Bulevardul Mamaia 15','Constanta'),
('Strada Republicii 7','Brasov');


-- ======================
-- CURIERI (MANUAL)
-- ======================
INSERT INTO curieri (nume, telefon) VALUES
('Mihai Ionescu','0741000001'),
('Radu Popa','0741000002'),
('Florin Georgescu','0741000003');


-- ======================
-- VEHICULE (MANUAL)
-- ======================
INSERT INTO vehicule (nr_inmatriculare, tip, id_curier) VALUES
('B100AAA','duba',1),
('B101BBB','camion',2),
('B102CCC','duba',3);

-- ======================
-- COLETE (AUTO)
-- ======================
INSERT INTO colete (
    id_client_expeditor,
    id_client_destinatar,
    adresa_ridicare,
    adresa_livrare,
    greutate_kg,
    status
)
SELECT
    (SELECT id_client FROM clienti ORDER BY random() LIMIT 1),
    (SELECT id_client FROM clienti ORDER BY random() LIMIT 1),
    (SELECT id_adresa FROM adrese ORDER BY random() LIMIT 1),
    (SELECT id_adresa FROM adrese ORDER BY random() LIMIT 1),
    round((random()*9 + 0.5)::numeric, 2),
    (ARRAY['INREGISTRAT','IN_DEPOZIT','IN_TRANZIT','LIVRAT'])[floor(random()*4)+1]
FROM generate_series(1, 50);


-- ======================
-- LIVRARI (AUTO)
-- ======================
INSERT INTO livrari (id_colet, id_curier, data_preluare, data_livrare)
SELECT
    id_colet,
    (SELECT id_curier FROM curieri ORDER BY random() LIMIT 1),
    now() - (random() * interval '5 days'),
    CASE WHEN random() > 0.4 THEN now() ELSE NULL END
FROM colete;
