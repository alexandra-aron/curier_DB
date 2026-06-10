-- Toate coletele cu numele curierului

SELECT
c.id_colet,
cu.nume AS curier,
c.status
FROM colete c
JOIN livrari l ON c.id_colet = l.id_colet
JOIN curieri cu ON l.id_curier = cu.id_curier;

-- Numar livrari per curier

SELECT
cu.nume,
COUNT(*) AS numar_livrari
FROM curieri cu
JOIN livrari l ON cu.id_curier = l.id_curier
GROUP BY cu.nume;

-- Total incasari

SELECT SUM(suma) AS total_incasari
FROM plati;

-- Colete nelivrate

SELECT *
FROM livrari
WHERE data_livrare IS NULL;

-- Greutatea medie a coletelor

SELECT AVG(greutate_kg) AS greutate_medie
FROM colete;

-- Colete peste greutatea medie

SELECT *
FROM colete
WHERE greutate_kg >
(
SELECT AVG(greutate_kg)
FROM colete
);
