

---1. Afiseaza toate comenzile care au livrat cu mijloc de transport tip "duba"

SELECT * 
FROM vehicule v
JOIN curieri c ON v.id_curier = c.id_curier
JOIN livrari l ON c.id_curier = l.id_curier
JOIN colete col ON l.id_colet = col.id_colet
WHERE tip = 'duba';

---2. Afiseaza pretul mediu al coletelor livrate in 2026

SELECT ROUND(AVG(p.suma),2) AS pret_mediu
FROM plati p 
JOIN colete c ON p.id_colet = c.id_colet
JOIN livrari l ON c.id_colet = l.id_colet
WHERE EXTRACT (YEAR FROM l.data_livrare) = 2026;


---3. Afiseaza greutatea minima si greutatea maxima pentru coletele livrate cu toate mijloacele de transport tip "duba"
SELECT MIN(col.greutate_kg) AS greutate_miniam, MAX(col.greutate_kg) AS greutate_maxima
FROM colete col 
JOIN livrari l ON col.id_colet = l.id_colet
JOIN curieri cur ON l.id_curier = cur.id_curier
JOIN vehicule v ON cur.id_curier = v.id_curier
WHERE v.tip = 'duba'; -- Lipsa acestui filtru calcula greutatea totală;


---4. Afiseaza top 3 adrese de livrare (adresa,numar livrari), pentru fiecare luna din 2026
SELECT count(l.id_livrare) AS numar_livrari,al.id_adresa, al.strada AS strada, al.oras AS oras
FROM colete col
JOIN livrari l ON col.id_colet = l.id_colet
JOIN adrese ar ON ar.id_adresa = col.adresa_ridicare
JOIN adrese al ON al.id_adresa = col.adresa_livrare
WHERE EXTRACT (YEAR FROM l.data_livrare) = 2026
GROUP BY al.id_adresa, al.strada, al.oras;

---5. Afiseaza toate livrarile si costul total al coletelor din fiecare livrare

SELECT 
    l.id_livrare,
    l.id_colet,
    col.greutate_kg,
    col.status AS status_colet,
    l.data_livrare,
    SUM(p.suma) AS cost_total_colet
FROM livrari l
JOIN colete col ON l.id_colet = col.id_colet
JOIN plati p ON col.id_colet = p.id_colet
GROUP BY l.id_livrare, l.id_colet, col.greutate_kg, col.status, l.data_livrare
ORDER BY l.id_livrare;




---6. Afiseaza toti curierii si costul total al coletelor livrate in 2026


SELECT 
    c.id_curier,
    c.nume AS nume_curier,
    c.telefon AS telefon_curier,
    SUM(p.suma) AS cost_total_livrat
FROM curieri c
JOIN livrari l ON c.id_curier = l.id_curier
JOIN colete col ON l.id_colet = col.id_colet
JOIN plati p ON col.id_colet = p.id_colet
WHERE l.data_livrare IS NOT NULL AND EXTRACT(YEAR FROM l.data_livrare) = 2026
GROUP BY c.id_curier, c.nume, c.telefon
ORDER BY cost_total_livrat DESC;


---7. Toate coletele cu numele curierului

SELECT
  c.id_colet,
  cu.nume AS curier,
  c.status
FROM colete c
JOIN livrari l ON c.id_colet = l.id_colet
JOIN curieri cu ON l.id_curier = cu.id_curier;

8.Numar livrari per curier

SELECT
  cu.nume,
  COUNT(*) AS numar_livrari
FROM curieri cu
JOIN livrari l ON cu.id_curier = l.id_curier
GROUP BY cu.nume;
