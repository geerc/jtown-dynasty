#!/usr/bin/env bash
set -e

echo "Downloading Cecil"
if [ -z "$CECIL_VERSION" ]; then
  curl -sSOL https://cecil.app/cecil.phar
else
  curl -sSOL https://cecil.app/download/$CECIL_VERSION/cecil.phar
fi

php cecil.phar --version

echo "Started Cecil build"

# Use DEPLOY_PRIME_URL for preview builds, SITE_URL for production (set in Netlify env)
BASEURL="${DEPLOY_PRIME_URL:-$URL}"

# Build site
if [[ $1 == "preview" ]]; then
  php cecil.phar build -v --baseurl="$BASEURL" --drafts
else
  php cecil.phar build -v --baseurl="$BASEURL" --postprocess
fi

echo "Finished Cecil build"
