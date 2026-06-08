#!/usr/bin/env bash
set -euo pipefail

# Vercel Ignored Build Step helper.
# Exit 0 means skip this Vercel build.
# Exit 1 means continue this Vercel build.
#
# Usage:
#   bash scripts/vercel-ignore-unaffected.sh web
#   bash scripts/vercel-ignore-unaffected.sh api

PROJECT_SCOPE="${1:-}"

case "$PROJECT_SCOPE" in
  web)
    RELEVANT_REGEX='^(artifacts/mawaeedak/|lib/|scripts/|package.json$|pnpm-lock.yaml$|pnpm-workspace.yaml$|vercel.json$)'
    ;;
  api)
    RELEVANT_REGEX='^(artifacts/api-server/|lib/|scripts/|package.json$|pnpm-lock.yaml$|pnpm-workspace.yaml$|vercel.json$)'
    ;;
  *)
    echo "Unknown project scope. Continue build for safety."
    exit 1
    ;;
esac

CURRENT_SHA="${VERCEL_GIT_COMMIT_SHA:-$(git rev-parse HEAD)}"
PREVIOUS_SHA="${VERCEL_GIT_PREVIOUS_SHA:-}"

if [ -z "$PREVIOUS_SHA" ]; then
  if git rev-parse "${CURRENT_SHA}^" >/dev/null 2>&1; then
    PREVIOUS_SHA="${CURRENT_SHA}^"
  else
    echo "No previous commit available. Continue build for safety."
    exit 1
  fi
fi

CHANGED_FILES="$(git diff --name-only "$PREVIOUS_SHA" "$CURRENT_SHA" || true)"

if [ -z "$CHANGED_FILES" ]; then
  echo "No changed files detected. Skip build."
  exit 0
fi

echo "Changed files:"
echo "$CHANGED_FILES"

if echo "$CHANGED_FILES" | grep -E "$RELEVANT_REGEX" >/dev/null; then
  echo "Relevant files changed for $PROJECT_SCOPE. Continue Vercel build."
  exit 1
fi

echo "Only irrelevant files changed for $PROJECT_SCOPE. Skip Vercel build."
exit 0
