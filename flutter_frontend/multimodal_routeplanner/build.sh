#!/bin/bash
set -e

# Load environment variables from project root .env
ENV_FILE="${ENV_FILE:-../../.env}"
if [ -f "$ENV_FILE" ]; then
  export $(grep -v '^\s*#' "$ENV_FILE" | sed 's/[[:space:]]*#.*//' | grep -v '^\s*$' | xargs)
fi

# Build dart-define flags from relevant env vars
DART_DEFINES=""
[ -n "$APP_BASE_URL" ]     && DART_DEFINES="$DART_DEFINES --dart-define=APP_BASE_URL=$APP_BASE_URL"
[ -n "$APP_BACKEND_PATH" ] && DART_DEFINES="$DART_DEFINES --dart-define=APP_BACKEND_PATH=$APP_BACKEND_PATH"

echo ">>> Generating localizations..."
flutter gen-l10n

echo ">>> Building Flutter Web (APP_BASE_URL=${APP_BASE_URL:-default})..."
flutter build web $DART_DEFINES

echo ">>> Patching index.html base href..."
sed -i 's|<base href="/">|<base href="/web/">|' build/web/index.html

echo ">>> Clearing flask_app/templates/..."
rm -rf ../../flask_app/templates/*
mkdir -p ../../flask_app/templates

echo ">>> Copying build output to flask_app/templates/..."
cp -r build/web/. ../../flask_app/templates/

echo ">>> Done."
