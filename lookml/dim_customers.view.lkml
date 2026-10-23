view: dim_customers {
  sql_table_name: ANALYTICS.PROD.DIM_CUSTOMERS ;;

  dimension: customer_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: first_name {
    label: "First Name"
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    label: "Last Name"
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: customer_name {
    label: "Customer Name"
    type: string
    sql: ${first_name} || ' ' || ${last_name} ;;
  }

  dimension_group: first_order {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.first_order_date ;;
  }

  dimension_group: most_recent_order {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.most_recent_order_date ;;
  }

  dimension: number_of_orders {
    label: "Number of Orders"
    type: number
    sql: ${TABLE}.number_of_orders ;;
  }

  dimension: is_repeat_customer {
    label: "Repeat Customer"
    type: yesno
    sql: ${number_of_orders} > 1 ;;
  }

  dimension: lifetime_value {
    label: "Lifetime Value"
    type: number
    sql: ${TABLE}.lifetime_value ;;
    value_format_name: usd
  }

  measure: customer_count {
    label: "Customer Count"
    type: count
  }

  measure: total_lifetime_value {
    label: "Total Lifetime Value"
    type: sum
    sql: ${lifetime_value} ;;
    value_format_name: usd
  }
}