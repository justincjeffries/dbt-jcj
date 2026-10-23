connection: "snowflake"
include: "*.view.lkml"

explore: fct_orders {
  label: "Orders"

  join: dim_customers {
    type: left_outer
    sql_on: ${fct_orders.customer_id} = ${dim_customers.customer_id} ;;
    relationship: many_to_one
  }

  join: stg_stripe__payments {
    type: left_outer
    sql_on: ${fct_orders.order_id} = ${stg_stripe__payments.order_id} ;;
    relationship: one_to_many
  }
}