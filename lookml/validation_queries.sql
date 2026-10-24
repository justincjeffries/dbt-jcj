-- Total Revenue and Average Order Value
select sum(amount) as total_revenue,
       sum(amount) / nullif(count(*), 0) as average_order_value
from analytics.prod.fct_orders;

-- Revenue by payment method
select payment_method, sum(amount) as payment_total
from analytics.prod.stg_stripe__payments
where status = 'success'
group by 1
order by 2 desc;