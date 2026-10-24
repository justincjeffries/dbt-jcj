# fct_orders view: one row per order, built on the dbt fct_orders table.
view: fct_orders {
  sql_table_name: ANALYTICS.PROD.FCT_ORDERS ;;

  # Unique ID for each order
  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  # Links each order to its customer (hidden; used for joins)
  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  # Order date, by day, week, month, and year
  dimension_group: order {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.order_date ;;
  }

  # Order amount (hidden; used by the revenue measures)
  dimension: amount {
    type: number
    hidden: yes
    sql: ${TABLE}.amount ;;
  }

  # Number of orders
  measure: order_count {
    label: "Order Count"
    type: count
  }

  # Total revenue from successful payments
  measure: total_revenue {
    label: "Total Revenue"
    description: "Sum of successful payments per order"
    type: sum
    sql: ${amount} ;;
    value_format_name: usd
  }

  # Revenue divided by order count
  measure: average_order_value {
    label: "Average Order Value"
    type: number
    sql: ${total_revenue} / NULLIF(${order_count}, 0) ;;
    value_format_name: usd
  }
}