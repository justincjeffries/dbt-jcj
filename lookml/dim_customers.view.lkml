# dim_customers view: one row per customer, built on the dbt dim_customers table.
view: dim_customers {
  sql_table_name: ANALYTICS.PROD.DIM_CUSTOMERS ;;

  # Unique ID for each customer
  dimension: customer_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  # Customer's first name
  dimension: first_name {
    label: "First Name"
    type: string
    sql: ${TABLE}.first_name ;;
  }

  # Customer's last name
  dimension: last_name {
    label: "Last Name"
    type: string
    sql: ${TABLE}.last_name ;;
  }

  # First and last name combined (built in LookML)
  dimension: customer_name {
    label: "Customer Name"
    type: string
    sql: ${first_name} || ' ' || ${last_name} ;;
  }

  # Date of the customer's first order, by day, month, and year
  dimension_group: first_order {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.first_order_date ;;
  }

  # Date of the customer's most recent order, by day, month, and year
  dimension_group: most_recent_order {
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.most_recent_order_date ;;
  }

  # How many orders the customer has placed
  dimension: number_of_orders {
    label: "Number of Orders"
    type: number
    sql: ${TABLE}.number_of_orders ;;
  }

  # Yes if the customer has more than one order (built in LookML)
  dimension: is_repeat_customer {
    label: "Repeat Customer"
    type: yesno
    sql: ${number_of_orders} > 1 ;;
  }

  # One customer's total paid across all orders
  dimension: lifetime_value {
    label: "Lifetime Value"
    type: number
    sql: ${TABLE}.lifetime_value ;;
    value_format_name: usd
  }

  # Number of customers
  measure: customer_count {
    label: "Customer Count"
    type: count
  }

  # Lifetime value added up across customers
  measure: total_lifetime_value {
    label: "Total Lifetime Value"
    type: sum
    sql: ${lifetime_value} ;;
    value_format_name: usd
  }
}