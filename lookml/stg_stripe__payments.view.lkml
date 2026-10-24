# stg_stripe__payments view: one row per payment, built on the dbt payments staging model.
view: stg_stripe__payments {
  sql_table_name: ANALYTICS.PROD.STG_STRIPE__PAYMENTS ;;

  # Unique ID for each payment
  dimension: payment_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.payment_id ;;
  }

  # Links each payment to its order (hidden; used for joins)
  dimension: order_id {
    type: number
    hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  # How the customer paid (credit card, coupon, etc.)
  dimension: payment_method {
    label: "Payment Method"
    type: string
    sql: ${TABLE}.payment_method ;;
  }

  # Whether the payment succeeded or failed
  dimension: status {
    label: "Payment Status"
    type: string
    sql: ${TABLE}.status ;;
  }

  # Total of all payments, including failed ones
  measure: payment_total {
    label: "Payment Total"
    type: sum
    sql: ${TABLE}.amount ;;
    value_format_name: usd
  }
}