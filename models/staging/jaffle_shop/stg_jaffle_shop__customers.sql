select
    id as customer_id,
    first_name,
    last_name
from {{ source('jaffle_shop', 'customers') }}

union all

select
    id as customer_id,
    trim(first_name) as first_name,
    last_name
from {{ source('fivetran_jaffle', 'customers') }}