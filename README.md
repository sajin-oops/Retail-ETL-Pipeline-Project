# Retail Sales ETL Pipeline & Financial Reconciliation

An end-to-end data engineering pipeline built with **Python (Pandas, Psycopg2)** and **PostgreSQL**. The pipeline extracts multi-channel retail sales data, cleans and standardizes inconsistent records, executes an idempotent bulk upsert into a relational data warehouse, and conducts a programmatic financial reconciliation audit.

## Architecture & Data Flow

```text
[ store_sales.csv ]
        |
        ▼ (Extraction & Cleaning via Pandas)
[ retail_etl_pipeline.ipynb ]
    ├── Parse & standardize dates (YYYY-MM-DD)
    ├── Normalize customer emails & handle nulls
    ├── Enforce positive integer quantities
    ├── Deduplicate on primary key grain: (order_id, order_line_item)
    └── Format monetary fields to NUMERIC(10, 2)
        |
        ▼ (psycopg2.extras.execute_values)
[ PostgreSQL: fact_retail_sales ]
    └── Idempotent UPSERT (ON CONFLICT DO UPDATE)
        |
        ▼ (Automated Audit & Business Queries)
[ retail query.sql ]
    ├── Row-volume parity verification
    └── Net revenue discrepancy audit ($0.00 variance)
```

## Financial Reconciliation Audit Results

| Metric | Source (Pandas) | Target (PostgreSQL) | Variance | Status |
| --- | --- | --- | --- | --- |
| **Total Record Count** | 24,655 | 24,655 | 0 | **PASSED** |
| **Gross Sales Revenue** | $15,292,263.27 | $15,292,263.27 | $0.00 | **PASSED** |
| **Return Deductions** | $754,244.31 | $754,244.31 | $0.00 | **PASSED** |
| **Net Settled Revenue** | **$14,538,018.96** | **$14,538,018.96** | **$0.00** | **PASSED** |
