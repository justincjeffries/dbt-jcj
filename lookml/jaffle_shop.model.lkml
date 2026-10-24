# Model file: the Snowflake connection, the views to use, and how they join.
connection: "snowflake"
include: "*.view.lkml"

# Orders explore: start from orders, then join customers and payments
explore: fct_orders {
  label: "Orders"

  # Many orders belong to one customer
  join: dim_customers {
    type: left_outer
    sql_on: ${fct_orders.customer_id} = ${dim_customers.customer_id} ;;
    relationship: many_to_one
  }

  # One order can have several payments
  join: stg_stripe__payments {
    type: left_outer
    sql_on: ${fct_orders.order_id} = ${stg_stripe__payments.order_id} ;;
    relationship: one_to_many
  }
}