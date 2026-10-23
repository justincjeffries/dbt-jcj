view: fct_orders {
  sql_table_name: ANALYTICS.PROD.FCT_ORDERS ;;

  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: order {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.order_date ;;
  }

  dimension: amount {
    type: number
    hidden: yes
    sql: ${TABLE}.amount ;;
  }

  measure: order_count {
    label: "Order Count"
    type: count
  }

  measure: total_revenue {
    label: "Total Revenue"
    description: "Sum of successful payments per order"
    type: sum
    sql: ${amount} ;;
    value_format_name: usd
  }

  measure: average_order_value {
    label: "Average Order Value"
    type: number
    sql: ${total_revenue} / NULLIF(${order_count}, 0) ;;
    value_format_name: usd
  }
}