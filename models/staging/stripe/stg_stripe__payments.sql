-- stg_stripe__payments: one row per payment, combining both raw sources.
-- Amounts are converted from cents to dollars here, so every model downstream uses dollars.

-- 1. Payments from the original Stripe data in RAW.STRIPE
select
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    amount / 100 as amount,  -- cents to dollars
    created as created_at
from raw.stripe.payment

union all  -- stack both sources into one list (keeps all rows)

-- 2. Payments loaded by Fivetran from the Google Drive CSV
select
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    amount / 100 as amount,  -- cents to dollars
    created as created_at
from {{ source('fivetran_jaffle', 'payments') }}