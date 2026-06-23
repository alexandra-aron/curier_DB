-- =========================================================
-- 1. CLIENȚI (Înregistrăm 6 clienți ficși)
-- =========================================================
INSERT INTO clienti (nume, telefon) VALUES
('Andrei Popescu', '0723456781'),   -- id_client: 1
('Maria Ionescu', '0734567892'),    -- id_client: 2
('Alexandru Stan', '0745678903'),   -- id_client: 3
('Ioana Dumitrescu', '0756789014'), -- id_client: 4
('Radu Marinescu', '0767890125'),   -- id_client: 5
('Elena Vasilescu', '0778901236');  -- id_client: 6

-- =========================================================
-- 2. ADRESE (Înregistrăm adrese din diverse orașe)
-- =========================================================
INSERT INTO adrese (strada, oras) VALUES
('Strada Unirii 10', 'Bucuresti'),         -- id_adresa: 1
('Strada Memorandumului 5', 'Cluj-Napoca'),-- id_adresa: 2
('Strada Stefan cel Mare 20', 'Iasi'),     -- id_adresa: 3
('Bulevardul Mamaia 15', 'Constanta'),     -- id_adresa: 4
('Strada Republicii 7', 'Brasov');         -- id_adresa: 5

-- =========================================================
-- 3. CURIERI 
-- =========================================================
INSERT INTO curieri (nume, telefon) VALUES
('Mihai Ionescu', '0741000001'),    -- id_curier: 1 (Va conduce Duba 1)
('Radu Popa', '0741000002'),        -- id_curier: 2 (Va conduce Camionul)
('Florin Georgescu', '0741000003'); -- id_curier: 3 (Va conduce Duba 2)

-- =========================================================
-- 4. VEHICULE
-- =========================================================
INSERT INTO vehicule (nr_inmatriculare, tip, id_curier) VALUES
('B100AAA', 'duba', 1),   -- Alocat lui Mihai
('B101BBB', 'camion', 2), -- Alocat lui Radu
('B102CCC', 'duba', 3);   -- Alocat lui Florin

-- =========================================================
-- 5. COLETE (15 înregistrări explicite, cu statusuri diferite)
-- =========================================================
-- Parametri: id_client_expeditor, id_client_destinatar, adresa_ridicare, adresa_livrare, greutate_kg, status
INSERT INTO colete (id_colet, id_client_expeditor, id_client_destinatar, adresa_ridicare, adresa_livrare, greutate_kg, status) OVERRIDING SYSTEM VALUE VALUES
(1,  1, 2, 1, 2, 2.50,  'LIVRAT'),
(2,  3, 4, 2, 3, 140.00, 'LIVRAT'), -- Greu (potrivit de camion)
(3,  5, 6, 4, 1, 12.80, 'IN_TRANZIT'),
(4,  2, 1, 5, 2, 85.00,  'LIVRAT'), -- Greu (potrivit de camion)
(5,  4, 3, 3, 4, 1.20,  'IN_DEPOZIT'),
(6,  6, 5, 1, 5, 4.50,  'LIVRAT'),
(7,  1, 4, 2, 4, 195.00, 'LIVRAT'), -- Foarte greu (camion)
(8,  2, 6, 3, 1, 6.00,  'IN_TRANZIT'),
(9,  3, 5, 5, 3, 15.00, 'LIVRAT'),
(10, 5, 1, 4, 2, 110.00, 'LIVRAT'), -- Greu (camion)
(11, 6, 2, 1, 3, 3.10,  'INREGISTRAT'),
(12, 4, 6, 2, 5, 0.80,  'LIVRAT'),
(13, 2, 3, 3, 2, 250.00, 'LIVRAT'), -- Agabaritic (camion)
(14, 1, 5, 5, 1, 9.40,  'IN_TRANZIT'),
(15, 3, 6, 4, 5, 55.00, 'LIVRAT');

-- =========================================================
-- 6. LIVRĂRI (Corelate la secundă cu statusul coletului și tipul de vehicul)
-- =========================================================
-- Curierul 2 (Radu) are CAMIONUL și preia coletele grele (2, 4, 7, 10, 13)
-- Curierii 1 și 3 au DUBE și livrează restul coletelor mai ușoare.
INSERT INTO livrari (id_colet, id_curier, data_preluare, data_livrare) VALUES
(1,  1, '2026-06-15 09:00:00', '2026-06-15 12:30:00'), -- Dubă (Livrat)
(2,  2, '2026-06-15 10:00:00', '2026-06-16 15:00:00'), -- CAMION (Livrat)
(3,  3, '2026-06-20 08:00:00', NULL),                  -- Dubă (În tranzit)
(4,  2, '2026-06-16 09:00:00', '2026-06-16 18:15:00'), -- CAMION (Livrat)
-- Coletul 5 e în depozit, deci nu are încă o înregistrare în tabela livrări
(6,  1, '2026-06-17 11:00:00', '2026-06-17 14:00:00'), -- Dubă (Livrat)
(7,  2, '2026-06-17 08:00:00', '2026-06-18 11:00:00'), -- CAMION (Livrat)
(8,  3, '2026-06-20 09:30:00', NULL),                  -- Dubă (În tranzit)
(9,  1, '2026-06-18 13:00:00', '2026-06-18 17:45:00'), -- Dubă (Livrat)
(10, 2, '2026-06-18 07:30:00', '2026-06-19 12:00:00'), -- CAMION (Livrat)
-- Coletul 11 e doar înregistrat, nu are livrare
(12, 3, '2026-06-19 10:00:00', '2026-06-19 13:30:00'), -- Dubă (Livrat)
(13, 2, '2026-06-19 08:00:00', '2026-06-20 16:00:00'), -- CAMION (Livrat)
(14, 1, '2026-06-20 14:00:00', NULL),                  -- Dubă (În tranzit)
(15, 3, '2026-06-19 15:00:00', '2026-06-20 10:00:00'); -- Dubă (Livrat)

-- =========================================================
-- 7. PLĂȚI (Sume explicite adăugate pentru fiecare colet)
-- =========================================================
INSERT INTO plati (id_colet, suma) VALUES
(1,  25.00),
(2,  340.00), -- Transport scump (camion)
(3,  45.00),
(4,  210.00), -- Transport scump (camion)
(5,  15.00),
(6,  30.00),
(7,  490.00), -- Transport scump (camion)
(8,  35.00),
(9,  50.00),
(10, 280.00), -- Transport scump (camion)
(11, 20.00),
(12, 18.00),
(13, 600.00), -- Transport agabaritic (camion)
(14, 40.00),
(15, 120.00);
--------------------------------------------------------------------------------

-- =========================================================
-- CONTINUARE COLETE (ID 16 - 30) - DATE EXPLICITE ȘI VARIATE
-- =========================================================
-- Parametri: id_colet, id_client_expeditor, id_client_destinatar, adresa_ridicare, adresa_livrare, greutate_kg, status
INSERT INTO colete (id_colet, id_client_expeditor, id_client_destinatar, adresa_ridicare, adresa_livrare, greutate_kg, status) OVERRIDING SYSTEM VALUE VALUES
(16, 2, 4, 3, 1, 45.00,  'LIVRAT'),
(17, 5, 3, 5, 2, 180.00, 'LIVRAT'),     -- Greu (Camion)
(18, 1, 6, 1, 4, 12.00,  'IN_TRANZIT'),
(19, 4, 2, 2, 5, 320.00, 'LIVRAT'),     -- Foarte greu (Camion)
(20, 3, 1, 4, 3, 8.50,   'LIVRAT'),
(21, 6, 5, 3, 2, 95.00,  'IN_TRANZIT'), -- În tranzit (Camion)
(22, 2, 1, 1, 5, 1.50,   'LIVRAT'),
(23, 5, 4, 5, 3, 210.00, 'LIVRAT'),     -- Greu (Camion)
(24, 3, 6, 2, 4, 18.00,  'IN_DEPOZIT'),
(25, 1, 2, 4, 1, 3.70,   'LIVRAT'),
(26, 6, 3, 1, 2, 115.00, 'LIVRAT'),     -- Greu (Camion)
(27, 4, 5, 5, 4, 14.20,  'LIVRAT'),
(28, 2, 6, 3, 5, 27.00,  'LIVRAT'),
(29, 5, 1, 2, 3, 160.00, 'IN_TRANZIT'), -- În tranzit (Camion)
(30, 3, 4, 4, 2, 5.10,   'LIVRAT');

-- =========================================================
-- CONTINUARE LIVRĂRI (ID 16 - 30) - TIMPI VARIATI (MĂRȚIȘOR - IUNIE)
-- =========================================================
-- Curierul 2 (Radu) are CAMIONUL. Curierii 1 (Mihai) și 3 (Florin) au DUBE.
INSERT INTO livrari (id_colet, id_curier, data_preluare, data_livrare) VALUES
-- Livrare rapidă în luna Martie (Duba 1)
(16, 1, '2026-03-01 08:00:00', '2026-03-01 13:15:00'), 
-- Livrare interjudețeană de 3 zile în Aprilie (CAMION)
(17, 2, '2026-04-10 14:00:00', '2026-04-13 11:30:00'), 
-- Preluat recent, aflat pe drum (Duba 2)
(18, 3, '2026-06-20 18:00:00', NULL),                  
-- Livrare de noapte/peste weekend în Mai (CAMION)
(19, 2, '2026-05-15 16:30:00', '2026-05-18 09:00:00'), 
-- Livrare standard în Mai (Duba 1)
(20, 1, '2026-05-20 10:00:00', '2026-05-20 15:45:00'), 
-- Preluat acum 2 zile, încă pe drum pe traseu lung (CAMION)
(21, 2, '2026-06-19 07:00:00', NULL),                  
-- Livrat de Paște (Duba 2)
(22, 3, '2026-04-30 09:00:00', '2026-04-30 12:00:00'), 
-- Livrare agabaritică la început de Iunie (CAMION)
(23, 2, '2026-06-02 08:00:00', '2026-06-03 17:00:00'), 
-- Coletul 24 este în depozit, nu are înregistrare de livrare generată
-- Livrare rapidă Express (Duba 1)
(25, 1, '2026-06-10 11:00:00', '2026-06-10 13:20:00'), 
-- Livrare Camion la mijlocul lunii Mai
(26, 2, '2026-05-12 08:30:00', '2026-05-13 14:00:00'), 
-- Livrare după-amiază (Duba 2)
(27, 3, '2026-05-25 13:00:00', '2026-05-25 17:10:00'), 
-- Livrare dimineață (Duba 1)
(28, 1, '2026-06-05 07:45:00', '2026-06-05 11:15:00'), 
-- Plecat ieri la drum lung spre destinație (CAMION)
(29, 2, '2026-06-20 06:00:00', NULL),                  
-- Ultima livrare efectuată ieri seară (Duba 2)
(30, 3, '2026-06-20 14:00:00', '2026-06-20 19:30:00');

-- =========================================================
-- CONTINUARE PLĂȚI (ID 16 - 30)
-- =========================================================
INSERT INTO plati (id_colet, suma) VALUES
(16, 85.00),
(17, 410.00),
(18, 30.00),
(19, 720.00),
(20, 22.00),
(21, 290.00),
(22, 19.00),
(23, 540.00),
(24, 40.00),
(25, 25.00),
(26, 380.00),
(27, 35.00),
(28, 65.00),
(29, 430.00),
(30, 28.00);
