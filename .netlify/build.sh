#!/bin/bash
set -e
set -o pipefail

echo "Using committed Cecil PHAR..."
php bin/cecil.phar --version

echo "Starting Cecil build..."

# Check if this is a preview deploy (Netlify sets DEPLOY_PRIME_URL for previews)
if [ -n "$DEPLOY_PRIME_URL" ]; then
    echo "Building preview with drafts..."
    php bin/cecil.phar build -v --baseurl="$DEPLOY_PRIME_URL" --drafts
else
    echo "Building production site..."
    php bin/cecil.phar build -v --baseurl="$URL"
fi

# Ensure the _site folder exists
if [ ! -d "_site" ]; then
    echo "Error: _site directory was not created!"
    exit 1
fi

echo "Cecil build finished successfully. _site folder is ready for deployment."
