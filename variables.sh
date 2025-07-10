#!/bin/bash

# Expects $API_NAME to be set
# Outputs: DISPLAY_NAME, PATH, SPEC_PATH, BACKEND_URL

case "$API_NAME" in
  orders)
    DISPLAY_NAME="Orders API"
    PATH="orders"
    SPEC_PATH="apis/orders/swagger.json"
    BACKEND_URL="http://orders.internal.company.local"
    ;;
  payments)
    DISPLAY_NAME="Payments API"
    PATH="payments"
    SPEC_PATH="apis/payments/swagger.json"
    BACKEND_URL="http://payments.internal.company.local"
    ;;
  customers)
    DISPLAY_NAME="Customer API"
    PATH="customers"
    SPEC_PATH="apis/customers/swagger.json"
    BACKEND_URL="http://customers.internal.company.local"
    ;;
  *)
    echo "❌ Unknown API: $API_NAME"
    exit 1
    ;;
esac
