#!/bin/bash
set -e

echo "Downloading Cecil"
if [ -z "$CECIL_VERSION" ]; then
  curl -sSOL https://cecil.app/cecil.phar
else
  curl -sSOL https://cecil.app/download/$CECIL_VERSION/cecil.phar
fi

php cecil.phar --version

echo "Started Cecil build"
if [[ "$1" == "preview" ]]; then
  php cecil.phar build -v --baseurl=$DEPLOY_PRIME_URL --drafts
else
  php cecil.phar build -v --baseurl=$URL --postprocess
fi

# Verify that _site was actually created
if [ -d "_site" ]; then
  echo "Finished Cecil build ✅"
  exit 0
else
  echo "B
