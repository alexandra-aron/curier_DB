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
    FOREIGN KEY (id_curier) REFERENCES curieri(id_curier)
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
    FOREIGN KEY (id_client_expeditor) REFERENCES clienti(id_client),
    FOREIGN KEY (id_client_destinatar) REFERENCES clienti(id_client),
    FOREIGN KEY (adresa_ridicare) REFERENCES adrese(id_adresa),
    FOREIGN KEY (adresa_livrare) REFERENCES adrese(id_adresa)
);

-- =========================
-- LIVRARI
-- =========================

CREATE TABLE livrari (
    id_livrare INT GENERATED ALWAYS AS IDENTITY 
        PRIMARY KEY,
    id_colet INT NOT NULL,
    id_curier INT NOT NULL,
    data_preluare TIMESTAMP,
    data_livrare TIMESTAMP,
    FOREIGN KEY (id_colet) REFERENCES colete(id_colet),
    FOREIGN KEY (id_curier) REFERENCES curieri(id_curier)
);

-- =========================
-- PLATI
-- =========================

CREATE TABLE plati (
    id_plata INT GENERATED ALWAYS AS IDENTITY 
        PRIMARY KEY,
    id_colet INT NOT NULL,
    suma NUMERIC(12,2) NOT NULL CHECK (suma > 0),
    FOREIGN KEY (id_colet) REFERENCES colete(id_colet)
);
