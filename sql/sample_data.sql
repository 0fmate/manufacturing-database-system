-- Sample data for the manufacturing database system
-- This script is intentionally small and illustrative.

-- Uffici amministrativi
INSERT INTO UfficioAmministrazione (IDUfficio, TipoGestione) VALUES
  (1, 'Vendite'),
  (2, 'Acquisti'),
  (3, 'Contabilità');

INSERT INTO Vendite (VIDUfficio, NomeDipendente, Email, Indirizzo, SalarioAnnuoV) VALUES
  (1, 'Mario Rossi',   'mario.rossi@example.com',   'Via Roma 1, Napoli',      48000.00),
  (4, 'Luca Bianchi',  'luca.bianchi@example.com',  'Via Milano 10, Torino',   52000.00);

INSERT INTO Acquisti (AIDUfficio, NomeDipendente, SalarioAnnuoA) VALUES
  (2, 'Giulia Verdi',  42000.00),
  (5, 'Paolo Neri',    45000.00);

INSERT INTO Contabilità (CIDUfficio, NomeDipendente, SalarioAnnuoC) VALUES
  (3, 'Sara Fumagalli', 43000.00),
  (6, 'Anna Colombo',    46000.00);

-- Clienti
INSERT INTO Cliente (IDCliente, AziendaCliente, Email) VALUES
  (1, 'Caseificio Alfa S.r.l.',  'alfa@example.com'),
  (2, 'Latteria Beta S.p.A.',    'beta@example.com');

-- Commesse
INSERT INTO Commessa (IDCommessa, DataStilatura, IDCliente, VIDUfficio) VALUES
  (1001, '2023-03-15', 1, 1),
  (1002, '2023-04-10', 2, 1);

-- Macchine
INSERT INTO Macchina (IDMacchina, IDCommessa, Descrizione, Collaudato) VALUES
  (5001, 1001, 'Impianto pastorizzazione 1000L/h', TRUE),
  (5002, 1002, 'Linea imbottigliamento latte UHT', FALSE);

-- Produzione e personale
INSERT INTO Produzione (IDProduzione, CIDUfficio, TipoDiRuolo) VALUES
  (10, 3, 'P'),  -- Progettista
  (20, 3, 'O');  -- Operaio

INSERT INTO Progettisti (PIDProduzione, Nome, Indirizzo, Email, SalarioProgettista, VIDUfficio) VALUES
  (10, 'Francesca Conti', 'Via Manzoni 5, Salerno', 'f.conti@example.com', 65000.00, 1);

INSERT INTO ProgettistiSkill (PIDProduzione, Skill) VALUES
  (10, 'Modellazione 3D'),
  (10, 'Material Knowledge');

INSERT INTO Operai (OIDProduzione, Nome, Indirizzo, Email, SalarioOperaio, VIDUfficio) VALUES
  (20, 'Giovanni Esposito', 'Via Garibaldi 12, Avellino', 'g.esposito@example.com', 28000.00, 1);

-- Componenti e magazzino
INSERT INTO Componenti (IDComponente, DaAcquistare) VALUES
  (2001, FALSE),
  (2002, TRUE);

INSERT INTO MerceInMagazzino (IDComponente, Locazione, QuantitàDisponibile) VALUES
  (2001, 'Scaffale A1', 50);

INSERT INTO MerceAcquistata (IDComponente, PrezzoAcquisto, Quantità, ProdottoConforme, IDFornitore) VALUES
  (2001, 120.50,  30, TRUE, 3001),
  (2002,  85.00,  20, TRUE, 3002);

-- Fornitori
INSERT INTO Fornitori (IDFornitore, NomeFornitore, Email, AIDUfficio) VALUES
  (3001, 'SteelCircuitry Ltd.', 'steel@example.com', 2),
  (3002, 'CopperTech Corporation', 'copper@example.com', 2);

-- Fogli di lavoro e componenti lavorate/prelevate
INSERT INTO FogliDiLavoro (IDFoglioDILavoro, OIDProduzione, IDMacchina, CIDUfficio, Data_, Ora, NumeroOperai) VALUES
  (7001, 20, 5001, 3, '2023-03-20', '08:00:00', 3);

INSERT INTO ComponentiPrelevate (IDFoglioDiLavoro, IDComponente, QuantitàPrelevata, DescrizioneComponente) VALUES
  (7001, 2001, 10, 'Tubazioni inox 304');

INSERT INTO ComponentiLavorate (IDComponente, OIDProduzione, Data_, OreDiLavorazione) VALUES
  (2001, 20, '2023-03-20', 5);

-- Consegne
INSERT INTO Consegna (IDSpedizione, IDMacchina, IDCliente, TipoTrasporto,
                      TempoDiConsegna, CollaudoInLoco, SuccessoConsegna,
                      DataArrivo, Destinazione, Feedback) VALUES
  (9001, 5001, 1, 'Camion', 3, TRUE,  TRUE,  '2023-03-25', 'Nocera Inferiore', '*****'),
  (9002, 5002, 2, 'Nave',   10, TRUE, FALSE, '2023-04-30', 'Cagliari',         '*');