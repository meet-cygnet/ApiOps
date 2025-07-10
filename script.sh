#!/bin/bash

set -e

git fetch origin main

changed_files=$(git diff --name-only origin/main...HEAD | grep 'apis/.*/swagger.json' || true)

if [[ -z "$changed_files" ]]; then
  echo "✅ No Swagger files changed."
  exit 0
fi

for file in $changed_files; do
  API_NAME=$(basename $(dirname "$file"))
  echo "🔍 Processing $API_NAME..."

  # Load variables
  export API_NAME
  source ./deploy/variables.sh

  echo "📦 Importing $API_NAME from $SPEC_PATH"
  az apim api import \
    --resource-group "$APIM_RESOURCE_GROUP" \
    --service-name "$APIM_NAME" \
    --path "$PATH" \
    --api-id "$API_NAME" \
    --specification-format OpenApi \
    --specification-path "$SPEC_PATH" \
    --display-name "$DISPLAY_NAME" \
    --protocols Https

  echo "🔧 Setting backend: $BACKEND_URL"
  az apim api update \
    --resource-group "$APIM_RESOURCE_GROUP" \
    --service-name "$APIM_NAME" \
    --api-id "$API_NAME" \
    --set serviceUrl="$BACKEND_URL"
done
