INSERT INTO clienti (nume, telefon) VALUES
('Pop', '0736509452'),
('Popescu', '0758961248'),
('Ionescu', '0745986322'),
('Anghelescu', '0789651422'),
('Georgescu', '0722334455');

INSERT INTO curieri (nume, telefon) VALUES
('Damian', '0744388965'),
('Alexandru', '0789563211'),
('Nicolae', '0724267866'),
('Nicolaescu', '0789654177');

INSERT INTO vehicule (nr_inmatriculare, tip, id_curier) VALUES
('B 35 PPI', 'duba', 1),
('PH 18 PHH', 'camion', 2),
('PH 10 ROZ', 'duba', 3),
('B 465 RIK', 'camion', 4);

INSERT INTO adrese (strada, oras) VALUES
('Strada Republicii 12', 'Ploiesti'),
('Bulevardul Independentei 45', 'Bucuresti'),
('Strada Mihai Eminescu 8', 'Cluj-Napoca'),
('Strada Unirii 20', 'Brasov'),
('Calea Victoriei 101', 'Bucuresti');

INSERT INTO colete
(id_client_expeditor, id_client_destinatar, adresa_ridicare, adresa_livrare, greutate_kg, status)
VALUES
(1, 2, 1, 2, 2.50, 'INREGISTRAT'),
(2, 3, 2, 3, 5.20, 'IN_DEPOZIT'),
(3, 4, 3, 4, 1.10, 'IN_TRANZIT'),
(4, 5, 4, 5, 3.75, 'LIVRAT'),
(5, 1, 5, 1, 0.90, 'INREGISTRAT');

INSERT INTO livrari
(id_colet, id_curier, data_preluare, data_livrare)
VALUES
(1, 1, '2026-06-01 09:00:00', '2026-06-02 14:30:00'),
(2, 2, '2026-06-01 10:15:00', '2026-06-02 16:45:00'),
(3, 3, '2026-06-02 08:20:00', '2026-06-03 12:10:00'),
(4, 4, '2026-06-02 11:00:00', '2026-06-03 18:25:00'),
(5, 1, '2026-06-03 09:30:00', NULL);

INSERT INTO plati (id_colet, suma) VALUES
(1, 25.50),
(2, 40.00),
(3, 15.75),
(4, 60.00),
(5, 10.25);
