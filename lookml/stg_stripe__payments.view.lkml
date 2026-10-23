view: stg_stripe__payments {
  sql_table_name: ANALYTICS.PROD.STG_STRIPE__PAYMENTS ;;

  dimension: payment_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.payment_id ;;
  }

  dimension: order_id {
    type: number
    hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: payment_method {
    label: "Payment Method"
    type: string
    sql: ${TABLE}.payment_method ;;
  }

  dimension: status {
    label: "Payment Status"
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: payment_total {
    label: "Payment Total"
    type: sum
    sql: ${TABLE}.amount ;;
    value_format_name: usd
  }
}