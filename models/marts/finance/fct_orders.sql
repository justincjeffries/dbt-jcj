-- fct_orders: one row per order, with the total amount actually paid.

-- 1. All orders
with orders as  (
    select * from {{ ref ('stg_jaffle_shop__orders' )}}
),

-- 2. All payments
payments as (
    select * from {{ ref ('stg_stripe__payments') }}
),

-- 3. Total successful payments per order
order_payments as (
    select
        order_id,
        sum (case when status = 'success' then amount end) as amount  -- failed payments are ignored

    from payments
    group by 1  -- one row per order_id
),

-- 4. Attach each order's payment total to the order
 final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce (order_payments.amount, 0) as amount  -- 0 if no successful payments

    from orders
    left join order_payments using (order_id)  -- keeps orders with no payments
)

select * from final