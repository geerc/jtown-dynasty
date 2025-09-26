#!/bin/bash
set -e

echo "Downloading Cecil"
if [ -z $CECIL_VERSION ]; then
  curl -sSOL -L https://cecil.app/cecil.phar
else
  curl -sSOL -L https://cecil.app/download/$CECIL_VERSION/cecil.phar
fi
php cecil.phar --version


# Check that cecil.phar is a valid PHAR
if ! php -d phar.readonly=0 cecil.phar --version; then
  echo "Failed to run cecil.phar. Check that the download URL is correct."
  exit 1
fi

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
  echo "Build failed: _site directory not found ❌"
  exit 1
fi
