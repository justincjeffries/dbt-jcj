view: dim_customers {
  sql_table_name: ANALYTICS.PROD.DIM_CUSTOMERS ;;

  dimension: customer_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customer_name {
    label: "Customer Name"
    type: string
    sql: ${TABLE}.first_name || ' ' || ${TABLE}.last_name ;;
  }

  dimension_group: first_order {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.first_order_date ;;
  }

  dimension: is_repeat_customer {
    label: "Repeat Customer"
    type: yesno
    sql: ${TABLE}.number_of_orders > 1 ;;
  }

  measure: customer_count {
    label: "Customer Count"
    type: count
  }

  measure: total_lifetime_value {
    label: "Total Lifetime Value"
    type: sum
    sql: ${TABLE}.lifetime_value ;;
    value_format_name: usd
  }
}