# dbt + Snowflake Analytics Pipeline

An end-to-end analytics pipeline built on the modern data stack.

## Overview
CSV files in Google Drive are loaded into Snowflake by Fivetran. dbt transforms
the raw data into tested, documented models, deployed to production with dbt
platform jobs and reported in Power BI.

## Tools
Snowflake · dbt · Fivetran · GitHub · Power BI

## Project structure
- **Sources**: raw data in Snowflake (`RAW.JAFFLE_SHOP`, `RAW.STRIPE`,
  `RAW.FIVETRAN_JAFFLE`), with freshness checks
- **Staging** (`models/staging`): one cleaned model per source table; unions
  manually loaded and Fivetran-loaded data
- **Marts** (`models/marts`): `fct_orders` (one row per order with payment
  totals) and `dim_customers` (one row per customer with lifetime value)
- **Tests**: data tests on keys, accepted values, relationships, and payment totals

## Build order (DAG)
```
RAW sources
   ↓
stg_jaffle_shop__customers   stg_jaffle_shop__orders   stg_stripe__payments
          │                            └──────────┬──────────┘
          │                                   fct_orders
          └─────────────────┬───────────────────┘
                       dim_customers
```

## Environments
- Development: `ANALYTICS.DBT_JUSTIN`
- Production: `ANALYTICS.PROD`, built by a scheduled dbt platform job

## Semantic layer (LookML)
The `lookml/` folder defines a Looker semantic layer on top of the dbt marts:
reusable measures (Total Revenue, Average Order Value, Customer Count), business
dimensions (Repeat Customer, Payment Method), and an Orders explore joining orders,
customers, and payments with explicit join relationships. Definitions were validated
against equivalent SQL in Snowflake (`lookml/validation_queries.sql`).

Based on the dbt Labs "dbt Fundamentals" course project, extended with a
Fivetran source, multi-source unions, and production deployment.

