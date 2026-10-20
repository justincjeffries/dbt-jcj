select
    id as order_id,
    user_id as customer_id,
    order_date,
    status,
    _etl_loaded_at
from {{ source('jaffle_shop', 'orders') }}

union all

select
    id as order_id,
    user_id as customer_id,
    order_date,
    status,
    _fivetran_synced::timestamp_ntz as _etl_loaded_at
from {{ source('fivetran_jaffle', 'orders') }}