-- stg_jaffle_shop__orders: one row per order, combining both raw sources.

-- 1. Orders loaded manually into RAW.JAFFLE_SHOP
select
    id as order_id,
    user_id as customer_id,
    order_date,
    status,
    _etl_loaded_at
from {{ source('jaffle_shop', 'orders') }}

union all  -- stack both sources into one list (keeps all rows)

-- 2. Orders loaded by Fivetran from the Google Drive CSV
select
    id as order_id,
    user_id as customer_id,
    order_date,
    status,
    _fivetran_synced::timestamp_ntz as _etl_loaded_at  -- Fivetran's load time, converted to match the type above
from {{ source('fivetran_jaffle', 'orders') }}