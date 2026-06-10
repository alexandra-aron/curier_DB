-- =========================
-- CLIENTI
-- =========================

CREATE TABLE clienti (
id_client INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
nume VARCHAR(100) NOT NULL,
telefon VARCHAR(20)
);

-- =========================
-- CURIERI
-- =========================

CREATE TABLE curieri (
id_curier INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
nume VARCHAR(100) NOT NULL,
telefon VARCHAR(20)
);

-- =========================
-- VEHICULE
-- =========================

CREATE TABLE vehicule (
id_vehicul INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
nr_inmatriculare VARCHAR(20) UNIQUE NOT NULL,
tip VARCHAR(50),
id_curier INT,
FOREIGN KEY (id_curier)
REFERENCES curieri(id_curier)
);

-- =========================
-- ADRESE
-- =========================

CREATE TABLE adrese (
id_adresa INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
strada VARCHAR(150) NOT NULL,
oras VARCHAR(100) NOT NULL
);

-- =========================
-- COLETE
-- =========================

CREATE TABLE colete (
id_colet INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
id_client_expeditor INT NOT NULL,
id_client_destinatar INT NOT NULL,
adresa_ridicare INT NOT NULL,
adresa_livrare INT NOT NULL,
greutate_kg NUMERIC(10,2) CHECK (greutate_kg > 0),
status VARCHAR(30) DEFAULT 'INREGISTRAT',

```
FOREIGN KEY (id_client_expeditor)
    REFERENCES clienti(id_client),

FOREIGN KEY (id_client_destinatar)
    REFERENCES clienti(id_client),

FOREIGN KEY (adresa_ridicare)
    REFERENCES adrese(id_adresa),

FOREIGN KEY (adresa_livrare)
    REFERENCES adrese(id_adresa)
```

);

-- =========================
-- LIVRARI
-- =========================

CREATE TABLE livrari (
id_livrare INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
id_colet INT NOT NULL,
id_curier INT NOT NULL,
data_preluare TIMESTAMP,
data_livrare TIMESTAMP,

```
FOREIGN KEY (id_colet)
    REFERENCES colete(id_colet),

FOREIGN KEY (id_curier)
    REFERENCES curieri(id_curier)
```

);

-- =========================
-- PLATI
-- =========================

CREATE TABLE plati (
id_plata INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
id_colet INT NOT NULL,
suma NUMERIC(12,2) NOT NULL CHECK (suma > 0),

```
FOREIGN KEY (id_colet)
    REFERENCES colete(id_colet)
```

);

-- =========================
-- DATE DE TEST
-- =========================

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
