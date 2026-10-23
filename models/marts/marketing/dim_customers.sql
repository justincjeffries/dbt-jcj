-- dim_customers: one row per customer, with their order history and lifetime value.

-- 1. All customers
with customers as (
    select * from {{ ref ('stg_jaffle_shop__customers')}}
),

-- 2. All orders, with each order's paid amount
orders as (
    select * from {{ ref ('fct_orders')}}
),

-- 3. Summarize each customer's orders
customer_orders as (
    select
        customer_id,
        min (order_date) as first_order_date,
        max (order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(amount) as lifetime_value  -- total paid across all their orders
    from orders
    group by 1  -- one row per customer_id
),

-- 4. Attach each customer's order summary to the customer
 final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce (customer_orders.number_of_orders, 0) as number_of_orders,  -- 0 if no orders
        customer_orders.lifetime_value  -- blank if no orders
    from customers
    left join customer_orders using (customer_id)  -- keeps customers with no orders
)

select * from final