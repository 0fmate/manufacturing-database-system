# Relational Model

This document reports the relational schema of the manufacturing database system derived from the EER design and implemented in SQL.

## Relations

```text
Cliente(
  IDCliente PK,
  AziendaCliente,
  Email
)

Commessa(
  IDCommessa PK,
  DataStilatura,
  IDCliente FK -> Cliente.IDCliente,
  VIDUfficio FK -> Vendite.VIDUfficio
)

Macchina(
  IDMacchina PK,
  IDCommessa FK -> Commessa.IDCommessa,
  Descrizione,
  Collaudato
)

UfficioAmministrazione(
  IDUfficio PK,
  TipoGestione
)

Vendite(
  VIDUfficio PK FK -> UfficioAmministrazione.IDUfficio,
  NomeDipendente,
  Email,
  Indirizzo,
  SalarioAnnuoV
)

Acquisti(
  AIDUfficio PK FK -> UfficioAmministrazione.IDUfficio,
  NomeDipendente,
  SalarioAnnuoA
)

Contabilità(
  CIDUfficio PK FK -> UfficioAmministrazione.IDUfficio,
  NomeDipendente,
  SalarioAnnuoC
)

Produzione(
  IDProduzione PK,
  CIDUfficio FK -> Contabilità.CIDUfficio,
  TipoDiRuolo
)

Progettisti(
  PIDProduzione PK FK -> Produzione.IDProduzione,
  Nome,
  Indirizzo,
  Email,
  SalarioProgettista,
  VIDUfficio FK -> Vendite.VIDUfficio
)

ProgettistiSkill(
  PIDProduzione PK FK -> Progettisti.PIDProduzione,
  Skill
)

Operai(
  OIDProduzione PK FK -> Produzione.IDProduzione,
  Nome,
  Indirizzo,
  Email,
  SalarioOperaio,
  VIDUfficio
)

FogliDiLavoro(
  IDFoglioDiLavoro,
  OIDProduzione FK -> Operai.OIDProduzione,
  IDMacchina FK -> Macchina.IDMacchina,
  CIDUfficio FK -> Contabilità.CIDUfficio,
  Data_,
  Ora,
  NumeroOperai,
  PK (IDFoglioDiLavoro, OIDProduzione, IDMacchina, CIDUfficio)
)

Componenti(
  IDComponente PK,
  DaAcquistare
)

ComponentiPrelevate(
  IDFoglioDiLavoro FK -> FogliDiLavoro.IDFoglioDiLavoro,
  IDComponente FK -> Componenti.IDComponente,
  QuantitàPrelevata,
  DescrizioneComponente,
  PK (IDFoglioDiLavoro, IDComponente)
)

ComponentiLavorate(
  IDComponente FK -> Componenti.IDComponente,
  OIDProduzione FK -> Operai.OIDProduzione,
  Data_,
  OreDiLavorazione,
  PK (IDComponente, OIDProduzione)
)

MerceInMagazzino(
  IDComponente PK FK -> Componenti.IDComponente,
  Locazione,
  QuantitàDisponibile
)

MerceAcquistata(
  IDComponente PK FK -> Componenti.IDComponente,
  PrezzoAcquisto,
  Quantità,
  ProdottoConforme,
  IDFornitore FK -> Fornitori.IDFornitore
)

Fornitori(
  IDFornitore PK,
  NomeFornitore,
  Email,
  AIDUfficio FK -> Acquisti.AIDUfficio
)

Consegna(
  IDSpedizione PK,
  IDMacchina FK -> Macchina.IDMacchina,
  IDCliente FK -> Cliente.IDCliente,
  TipoTrasporto,
  TempoDiConsegna,
  CollaudoInLoco,
  SuccessoConsegna,
  DataArrivo,
  Destinazione,
  Feedback
)
```

## Notes

- `PK` denotes the primary key.
- `FK` denotes a foreign key. 
- The notation follows the SQL schema adopted in the project, with attribute names aligned to the implementation files.
- `FogliDiLavoro`, `ComponentiPrelevate`, and `ComponentiLavorate` use composite primary keys. 