-- OLAP queries for the manufacturing database system

-- 1. Pivot: total cost and quantity by supplier
SELECT
    f.NomeFornitore,
    f.Email,
    SUM(ma.PrezzoAcquisto * ma.Quantità) AS CostoTotale,
    SUM(ma.Quantità) AS QuantitàTotale
FROM Fornitori f
JOIN MerceAcquistata ma ON f.IDFornitore = ma.IDFornitore
GROUP BY f.NomeFornitore, f.Email
ORDER BY CostoTotale ASC, QuantitàTotale DESC;

-- 2. Pivot: purchase vs stock ratio by component
SELECT
    ma.IDComponente,
    CONCAT(
        ROUND(
            (SUM(ma.Quantità) / NULLIF(SUM(mg.QuantitàDisponibile), 0) * 100),
            0
        ),
        '%'
    ) AS RapportoPercentuale
FROM MerceAcquistata ma
LEFT JOIN MerceInMagazzino mg ON ma.IDComponente = mg.IDComponente
GROUP BY ma.IDComponente
ORDER BY ma.IDComponente;

-- 3. Designer skills overview
SELECT
    P.Nome               AS NomeProgettista,
    P.Indirizzo          AS IndirizzoProgettista,
    P.Email              AS EmailProgettista,
    PS.Skill
FROM Progettisti P
INNER JOIN ProgettistiSkill PS ON P.PIDProduzione = PS.PIDProduzione
ORDER BY PS.Skill, P.Nome;

-- 4. Total salaries by department
SELECT 'Vendite' AS Reparto, SUM(SalarioAnnuoV)       AS TotaleSalari
FROM Vendite

UNION ALL

SELECT 'Acquisti' AS Reparto, SUM(SalarioAnnuoA)      AS TotaleSalari
FROM Acquisti

UNION ALL

SELECT 'Contabilità' AS Reparto, SUM(SalarioAnnuoC)   AS TotaleSalari
FROM Contabilità

UNION ALL

SELECT 'Progettisti' AS Reparto, SUM(SalarioProgettista) AS TotaleSalari
FROM Progettisti

UNION ALL

SELECT 'Operai' AS Reparto, SUM(SalarioOperaio)       AS TotaleSalari
FROM Operai;