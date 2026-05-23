-- Manufacturing Database System
-- Relational schema for academic project

CREATE TABLE Cliente (
    IDCliente INT PRIMARY KEY,
    AziendaCliente VARCHAR(300),
    Email VARCHAR(100)
);

CREATE TABLE UfficioAmministrazione (
    IDUfficio INT PRIMARY KEY,
    TipoGestione VARCHAR(300)
);

CREATE TABLE Vendite (
    VIDUfficio INT PRIMARY KEY,
    NomeDipendente VARCHAR(300),
    Email VARCHAR(300),
    Indirizzo VARCHAR(300),
    SalarioAnnuoV DECIMAL(10, 2),
    FOREIGN KEY (VIDUfficio) REFERENCES UfficioAmministrazione(IDUfficio)
);

CREATE TABLE Acquisti (
    AIDUfficio INT PRIMARY KEY,
    NomeDipendente VARCHAR(300),
    SalarioAnnuoA DECIMAL(10, 2),
    FOREIGN KEY (AIDUfficio) REFERENCES UfficioAmministrazione(IDUfficio)
);

CREATE TABLE Contabilità (
    CIDUfficio INT PRIMARY KEY,
    NomeDipendente VARCHAR(300),
    SalarioAnnuoC DECIMAL(10, 2),
    FOREIGN KEY (CIDUfficio) REFERENCES UfficioAmministrazione(IDUfficio)
);

CREATE TABLE Commessa (
    IDCommessa INT PRIMARY KEY,
    DataStilatura DATE,
    IDCliente INT,
    VIDUfficio INT,
    FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCliente),
    FOREIGN KEY (VIDUfficio) REFERENCES Vendite(VIDUfficio)
);

CREATE TABLE Macchina (
    IDMacchina INT PRIMARY KEY,
    IDCommessa INT,
    Descrizione VARCHAR(300),
    Collaudato BOOLEAN,
    FOREIGN KEY (IDCommessa) REFERENCES Commessa(IDCommessa)
);

CREATE TABLE Componenti (
    IDComponente INT PRIMARY KEY,
    DaAcquistare BOOLEAN
);

CREATE TABLE Fornitori (
    IDFornitore INT PRIMARY KEY,
    NomeFornitore VARCHAR(300),
    Email VARCHAR(300),
    AIDUfficio INT,
    FOREIGN KEY (AIDUfficio) REFERENCES Acquisti(AIDUfficio)
);

CREATE TABLE MerceInMagazzino (
    IDComponente INT PRIMARY KEY,
    Locazione VARCHAR(300),
    QuantitàDisponibile INT,
    FOREIGN KEY (IDComponente) REFERENCES Componenti(IDComponente)
);

CREATE TABLE MerceAcquistata (
    IDComponente INT PRIMARY KEY,
    PrezzoAcquisto DECIMAL(10, 2),
    Quantità INT,
    ProdottoConforme BOOLEAN,
    IDFornitore INT,
    FOREIGN KEY (IDComponente) REFERENCES Componenti(IDComponente),
    FOREIGN KEY (IDFornitore) REFERENCES Fornitori(IDFornitore)
);

CREATE TABLE Produzione (
    IDProduzione INT PRIMARY KEY,
    CIDUfficio INT,
    TipoDiRuolo VARCHAR(300),
    FOREIGN KEY (CIDUfficio) REFERENCES Contabilità(CIDUfficio)
);

CREATE TABLE Progettisti (
    PIDProduzione INT PRIMARY KEY,
    Nome VARCHAR(300),
    Indirizzo VARCHAR(300),
    Email VARCHAR(300),
    SalarioProgettista DECIMAL(10, 2),
    VIDUfficio INT,
    FOREIGN KEY (PIDProduzione) REFERENCES Produzione(IDProduzione),
    FOREIGN KEY (VIDUfficio) REFERENCES Vendite(VIDUfficio)
);

CREATE TABLE ProgettistiSkill (
    PIDProduzione INT PRIMARY KEY,
    Skill VARCHAR(300),
    FOREIGN KEY (PIDProduzione) REFERENCES Progettisti(PIDProduzione)
);

CREATE TABLE Operai (
    OIDProduzione INT PRIMARY KEY,
    Nome VARCHAR(300),
    Indirizzo VARCHAR(300),
    Email VARCHAR(300),
    SalarioOperaio DECIMAL(10, 2),
    VIDUfficio INT,
    FOREIGN KEY (OIDProduzione) REFERENCES Produzione(IDProduzione)
);

CREATE TABLE FogliDiLavoro (
    IDFoglioDiLavoro INT,
    OIDProduzione INT,
    IDMacchina INT,
    CIDUfficio INT,
    Data_ DATE,
    Ora TIME,
    NumeroOperai INT,
    PRIMARY KEY (IDFoglioDiLavoro, OIDProduzione, IDMacchina, CIDUfficio),
    FOREIGN KEY (OIDProduzione) REFERENCES Operai(OIDProduzione),
    FOREIGN KEY (IDMacchina) REFERENCES Macchina(IDMacchina),
    FOREIGN KEY (CIDUfficio) REFERENCES Contabilità(CIDUfficio)
);

CREATE TABLE ComponentiPrelevate (
    IDFoglioDiLavoro INT,
    IDComponente INT,
    QuantitàPrelevata INT,
    DescrizioneComponente VARCHAR(300),
    PRIMARY KEY (IDFoglioDiLavoro, IDComponente),
    FOREIGN KEY (IDFoglioDiLavoro) REFERENCES FogliDiLavoro(IDFoglioDiLavoro),
    FOREIGN KEY (IDComponente) REFERENCES Componenti(IDComponente)
);

CREATE TABLE ComponentiLavorate (
    IDComponente INT,
    OIDProduzione INT,
    Data_ DATE,
    OreDiLavorazione INT,
    PRIMARY KEY (IDComponente, OIDProduzione),
    FOREIGN KEY (OIDProduzione) REFERENCES Operai(OIDProduzione),
    FOREIGN KEY (IDComponente) REFERENCES Componenti(IDComponente)
);

CREATE TABLE Consegna (
    IDSpedizione INT PRIMARY KEY,
    IDMacchina INT,
    IDCliente INT,
    TipoTrasporto VARCHAR(300),
    TempoDiConsegna INT,
    CollaudoInLoco BOOLEAN,
    SuccessoConsegna BOOLEAN,
    DataArrivo DATE,
    Destinazione VARCHAR(300),
    Feedback VARCHAR(300),
    FOREIGN KEY (IDMacchina) REFERENCES Macchina(IDMacchina),
    FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCliente)
);