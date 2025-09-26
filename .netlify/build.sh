#!/bin/bash
set -e  # exit immediately if a command exits with a non-zero status
set -o pipefail

# -----------------------------------------------------------------------------
# Netlify Build Script for Cecil (Using Committed PHAR)
# -----------------------------------------------------------------------------

echo "Using committed Cecil PHAR..."

# Show Cecil version
php bin/cecil.phar --version

echo "Starting Cecil build..."

# Determine build type: preview or production
if [[ "$1" == "preview" ]]; then
    echo "Building preview with drafts..."
    php bin/cecil.phar build -v --baseurl="$DEPLOY_PRIME_URL" --drafts
else
    echo "Building production site..."
    php bin/cecil.phar build -v --baseurl="$URL" --postprocess
fi

# Verify that the _site folder was created
if [ ! -d "_site" ]; then
    echo "E
