# Manufacturing Database System

Database project developed for the undergraduate **Base di Dati** exam.

This repository contains the design and implementation of a manufacturing database system for managing customers, orders, suppliers, components, production activities, quality control, logistics, and analytical reporting. The project includes an EER model, a relational schema, SQL queries for operational analysis, a MongoDB reporting section, an OLAP-oriented analytical extension based on a star schema, and a small Python command-line utility for interacting with the database. 


## Authors

- Davide D'Amico
- Gerardo Rainone

## Project context

This project was developed for the bachelor's degree exam in **Base di Dati**.  
The original academic work was based on a real-world inspired manufacturing case study focused on procurement, warehouse operations, production workflow, labor organization, quality control, delivery tracking, and reporting activities. 

The repository is a cleaned and reorganized version of the original project material, with normalized filenames and a clearer folder structure for academic documentation and portfolio use. 

## Repository structure

```text
.
├── docs/
│   └── database-project-report.pdf
├── model/
│   ├── eer-diagram.drawio
│   ├── eer-diagram.png
│   ├── relational-model.md
│   ├── star-schema.drawio
│   └── star-schema.png
├── sql/
│   ├── schema.sql
│   ├── business_queries.sql
│   ├── olap_queries.sql
│   └── sample_data.sql
├── nosql/
│   └── mongodb_queries.js
├── artifacts/
│   └── olap/
│       ├── suppliers-pivot.xlsx
│       ├── designers-skills-pivot.xlsx
│       └── department-salaries-pivot.xlsx
├── src/
│   └── db_menu.py
├── .env.example
├── .gitignore
└── requirements.txt
```

## Repository contents

### `docs/`

Contains the final academic report in PDF format, including the project description, the EER model, the relational model, the SQL implementation, the MongoDB section, the OLAP extension, and the Python-based database menu shown in the final part of the report. 

### `model/`

Contains the database design artifacts:

- `eer-diagram.drawio`: editable EER diagram;
- `eer-diagram.png`: exported version of the EER diagram;
- `relational-model.md`: relational model written in clean Markdown format;
- `star-schema.drawio`: editable star schema for the analytical section;
- `star-schema.png`: exported version of the star schema. 

### `sql/`

Contains the relational database implementation and SQL query files:

- `schema.sql`: relational schema definition with tables, primary keys, and foreign keys; 
- `business_queries.sql`: SQL queries for operational and business-oriented analysis on the transactional schema; 
- `olap_queries.sql`: SQL queries for analytical reporting related to suppliers, designers' skills, and salary distribution by department; 
- `sample_data.sql`: small illustrative sample dataset for testing the schema and running example queries. 

### `nosql/`

Contains MongoDB queries used for reporting tasks related to quality control and customer feedback. The report explains that MongoDB was used to inspect selected data imported from the relational database in JSON-style document form. 

### `artifacts/olap/`

Contains spreadsheet artifacts produced for the OLAP and reporting section of the project:

- `suppliers-pivot.xlsx`: supplier-level summary of total purchase cost and total purchased quantity;
- `designers-skills-pivot.xlsx`: overview of designers' skills distribution;
- `department-salaries-pivot.xlsx`: salary totals by department, including the salary-to-revenue comparison discussed in the report. 

### `src/`

Contains a small Python command-line utility for interacting with the MySQL database.  
This script reflects the final integration step described in the academic report, where a menu-driven Python program was used to inspect tables, create or delete tables, and execute custom SQL queries. 

### `.env.example`

Provides an example environment configuration for the Python database utility, including host, user, password, database name, and authentication plugin.

### `requirements.txt`

Lists the Python dependencies required to run the command-line utility.

## System scope

The system was designed to support:

- customer and order management; 
- supplier and raw material tracking; 
- production workflow monitoring; 
- workforce and department management; 
- quality control and logistics; 
- business and analytical reporting. 

## Data model

The project starts from an Extended Entity-Relationship model and derives a relational schema that includes entities such as `Cliente`, `Commessa`, `Macchina`, `Fornitori`, `Componenti`, `Produzione`, `Progettisti`, `Operai`, and `Consegna`. 

The relational layer also includes administrative structures such as `Vendite`, `Acquisti`, and `Contabilità`, together with production-related tables such as `FogliDiLavoro`, `ComponentiPrelevate`, and `ComponentiLavorate`. 

For the analytical extension, the repository also includes a star schema used to support OLAP-style analyses on supplier relations, designers' skills, and salary reporting. 

## SQL, NoSQL, and OLAP sections

The SQL section supports the transactional and operational side of the system, including order tracking, warehouse inspection, labor reporting, supplier monitoring, transport analysis, and salary-related queries. 

The MongoDB section focuses on two specific reporting tasks:

- quality control documentation on machines and purchased goods;
- customer feedback analysis for successful on-site delivery testing. 

The OLAP section extends the project with analytical queries and related spreadsheet outputs. In the report, this part is explicitly connected to management decisions concerning supplier relationships, designers' performance and skills, and salary analysis across departments. 

## Python utility

The repository also includes a simple Python menu for interacting with the database from the command line. This component is consistent with the final part of the academic report, where a small Python program was used to connect to MySQL and perform basic inspection and query execution tasks.

To keep the repository safer and more reusable, configuration values are provided through environment variables rather than hardcoded credentials.

## Usage

A typical usage flow is the following:

1. Create a relational database environment compatible with the SQL schema.
2. Execute `sql/schema.sql` to create the tables. 
3. Optionally execute `sql/sample_data.sql` to populate the database with a small illustrative dataset.
4. Run `sql/business_queries.sql` for operational and business queries. 
5. Run `sql/olap_queries.sql` for analytical reporting.
6. Use `nosql/mongodb_queries.js` in MongoDB if the required collections have been imported from the relational database. 
7. Optionally use `src/db_menu.py` as a simple command-line interface for database inspection and custom queries. 

## Python setup

Install the required packages:

```bash
pip install -r requirements.txt
```

Create a local environment file starting from `.env.example`, then configure the database connection values before running the Python script.

## Notes

This repository is intended for academic documentation and portfolio purposes.  
The original report refers to a real company case study, but the repository is presented here only as a university database project.
