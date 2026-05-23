-- Business queries for the manufacturing database system

-- 1. List of orders with their assigned machines
SELECT c.IDCommessa, c.DataStilatura, m.IDMacchina, m.Descrizione
FROM Commessa c
JOIN Macchina m ON c.IDCommessa = m.IDCommessa;

-- 2. Total worker hours for each machine
SELECT f.IDMacchina, SUM(cl.OreDiLavorazione) AS TotaleOre
FROM FogliDiLavoro f
JOIN ComponentiLavorate cl ON f.OIDProduzione = cl.OIDProduzione
GROUP BY f.IDMacchina;

-- 3. Suppliers with the highest number of collaborations
SELECT f.NomeFornitore, COUNT(m.IDComponente) AS NumeroCollaborazioni
FROM Fornitori f
JOIN MerceAcquistata m ON f.IDFornitore = m.IDFornitore
GROUP BY f.NomeFornitore
ORDER BY NumeroCollaborazioni DESC;

-- 4. Average salary of employees by department
SELECT 'Operai' AS Tipo, ROUND(AVG(SalarioOperaio), 2) AS SalarioMedio
FROM Operai
UNION ALL
SELECT 'Progettisti' AS Tipo, ROUND(AVG(SalarioProgettista), 2) AS SalarioMedio
FROM Progettisti
UNION ALL
SELECT 'Vendite' AS Tipo, ROUND(AVG(SalarioAnnuoV), 2) AS SalarioMedio
FROM Vendite
UNION ALL
SELECT 'Contabilità' AS Tipo, ROUND(AVG(SalarioAnnuoC), 2) AS SalarioMedio
FROM Contabilità
UNION ALL
SELECT 'Acquisti' AS Tipo, ROUND(AVG(SalarioAnnuoA), 2) AS SalarioMedio
FROM Acquisti;

-- 5. Orders requiring components not yet purchased
SELECT c.IDCommessa, c.DataStilatura
FROM Commessa c
JOIN Macchina m ON c.IDCommessa = m.IDCommessa
JOIN FogliDiLavoro f ON m.IDMacchina = f.IDMacchina
JOIN ComponentiPrelevate cp ON f.IDFoglioDiLavoro = cp.IDFoglioDiLavoro
JOIN Componenti comp ON cp.IDComponente = comp.IDComponente
WHERE comp.DaAcquistare = TRUE;

-- 6. Total working hours on a specific machine
SELECT f.IDMacchina, SUM(cl.OreDiLavorazione) AS TotaleOre
FROM FogliDiLavoro f
JOIN Macchina m ON m.IDMacchina = f.IDMacchina
JOIN ComponentiLavorate cl ON f.OIDProduzione = cl.OIDProduzione
WHERE f.IDMacchina = 7516
GROUP BY f.IDMacchina;

-- 7. Components with stock above a predefined threshold
SELECT m.IDComponente, m.Locazione, m.QuantitàDisponibile
FROM MerceInMagazzino m
WHERE m.QuantitàDisponibile > 20;

-- 8. Customers who placed the highest number of orders
SELECT c.IDCliente, cl.AziendaCliente, COUNT(c.IDCommessa) AS NumeroOrdinativi
FROM Commessa c
JOIN Cliente cl ON c.IDCliente = cl.IDCliente
GROUP BY c.IDCliente, cl.AziendaCliente
ORDER BY NumeroOrdinativi DESC;

-- 9. Delayed shipments by transport type
SELECT TipoTrasporto, COUNT(IDSpedizione) AS NumeroRitardi
FROM Consegna
WHERE SuccessoConsegna = FALSE
GROUP BY TipoTrasporto
ORDER BY NumeroRitardi DESC;

-- 10. Average delivery time by transport type
SELECT TipoTrasporto, ROUND(AVG(TempoDiConsegna), 0) AS TempoMedioDiConsegna
FROM Consegna
WHERE SuccessoConsegna = TRUE
GROUP BY TipoTrasporto
ORDER BY TempoMedioDiConsegna DESC;

-- 11. Total purchasing cost by supplier
SELECT f.NomeFornitore, SUM(ma.PrezzoAcquisto * ma.Quantità) AS TotaleSpesa
FROM Fornitori f
JOIN MerceAcquistata ma ON f.IDFornitore = ma.IDFornitore
GROUP BY f.NomeFornitore;

-- 12. Designers with a specific skill
SELECT p.Nome, p.PIDProduzione
FROM Progettisti p
JOIN ProgettistiSkill ps ON p.PIDProduzione = ps.PIDProduzione
WHERE ps.Skill = 'Modellazione 3D';

-- 13. Number of successfully tested on-site machines by customer
SELECT c.IDCliente, cl.AziendaCliente, COUNT(*) AS CollaudiRiusciti
FROM Consegna c
JOIN Cliente cl ON c.IDCliente = cl.IDCliente
WHERE c.CollaudoInLoco = TRUE AND c.SuccessoConsegna = TRUE
GROUP BY c.IDCliente, cl.AziendaCliente;

-- 14. Average purchase price by component for compliant goods
SELECT IDComponente, AVG(PrezzoAcquisto) AS PrezzoMedio
FROM MerceAcquistata
WHERE ProdottoConforme = TRUE
GROUP BY IDComponente
ORDER BY PrezzoMedio DESC;

-- 15. Employees with salary above department average
SELECT AVG(SalarioOperaio) INTO @MediaSalarioOperaio
FROM Operai;

SELECT AVG(SalarioProgettista) INTO @MediaSalarioProgettista
FROM Progettisti;

SELECT Nome, OIDProduzione, SalarioOperaio
FROM Operai
WHERE SalarioOperaio > @MediaSalarioOperaio
ORDER BY SalarioOperaio DESC;

SELECT Nome, PIDProduzione, SalarioProgettista
FROM Progettisti
WHERE SalarioProgettista > @MediaSalarioProgettista
ORDER BY SalarioProgettista DESC;

-- 16. Components not yet used in production
SELECT MAX(QuantitàDisponibile) INTO @QuantitaMassima
FROM MerceInMagazzino;

SELECT c.IDComponente
FROM Componenti c
JOIN MerceInMagazzino m ON c.IDComponente = m.IDComponente
WHERE m.QuantitàDisponibile = @QuantitaMassima
  AND c.DaAcquistare = FALSE;

-- 17. Number of sales made by each sales manager in a specific period
SELECT v.NomeDipendente, COUNT(c.IDCommessa) AS NumeroVendite
FROM Vendite v
JOIN Commessa c ON v.VIDUfficio = c.VIDUfficio
WHERE c.DataStilatura BETWEEN '2015-06-21' AND '2016-06-21'
GROUP BY v.NomeDipendente
ORDER BY NumeroVendite DESC;

-- 18. Number of distinct orders by customer with at least one tested machine
SELECT cl.IDCliente, cl.AziendaCliente, COUNT(DISTINCT co.IDCommessa) AS NumeroCommesse
FROM Cliente cl
JOIN Commessa co ON cl.IDCliente = co.IDCliente
JOIN Macchina m ON co.IDCommessa = m.IDCommessa
WHERE m.Collaudato = TRUE
GROUP BY cl.IDCliente, cl.AziendaCliente
ORDER BY NumeroCommesse DESC;