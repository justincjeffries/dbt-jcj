-- stg_jaffle_shop__customers: one row per customer, combining both raw sources.

-- 1. Customers loaded manually into RAW.JAFFLE_SHOP
select
    id as customer_id,
    first_name,
    last_name
from {{ source('jaffle_shop', 'customers') }}

union all  -- stack both sources into one list (keeps all rows)

-- 2. Customers loaded by Fivetran from the Google Drive CSV
select
    id as customer_id,
    trim(first_name) as first_name,  -- removes stray spaces from the CSV
    last_name
from {{ source('fivetran_jaffle', 'customers') }}