// MongoDB queries for the manufacturing database system

// 1. Quality control documentation
// Upstream: compliant purchased goods
// Downstream: tested machines

db.Macchina.find(
  { Collaudato: true }
).sort(
  { IDCommessa: true }
);

db.MerceAcquistata.find(
  { ProdottoConforme: true }
).sort(
  { IDComponente: true }
);

// 2. Customer feedback reporting
// Positive feedback on successful on-site testing

db.Consegna.find(
  {
    CollaudoInLoco: true,
    SuccessoConsegna: true,
    Feedback: "*****"
  }
).sort(
  { IDMacchina: true }
);

// Negative feedback on successful on-site testing

db.Consegna.find(
  {
    CollaudoInLoco: true,
    SuccessoConsegna: true,
    Feedback: "*"
  }
).sort(
  { IDMacchina: true }
);