#!/usr/bin/env bash
set -e  # exit immediately on error
set -o pipefail

echo "🔧 Setting up PHP…"
# Use whatever PHP version you want
PHP_VERSION="${PHP_VERSION:-8.1}"

# Install PHP if missing
if ! command -v php >/dev/null 2>&1; then
  echo "Installing PHP $PHP_VERSION…"
  # Netlify build image is Ubuntu-based
  sudo apt-get update -qq
  sudo apt-get install -y software-properties-common
  sudo add-apt-repository -y ppa:ondrej/php
  sudo apt-get update -qq
  sudo apt-get install -y "php${PHP_VERSION}" "php${PHP_VERSION}-cli" unzip
  sudo update-alternatives --install /usr/bin/php php /usr/bin/php${PHP_VERSION} 1
fi

echo "✅ PHP version: $(php -v | head -n 1)"

# Download Cecil if missing
CECIL_VERSION="${CECIL_VERSION:-latest}"
if [ ! -f ./cecil.phar ]; then
  echo "Downloading Cecil ($CECIL_VERSION)…"
  if [ "$CECIL_VERSION" = "latest" ]; then
    curl -sSL https://cecil.app/cecil.phar -o cecil.phar
  else
    curl -sSL "https://github.com/Cecilapp/Cecil/releases/download/$CECIL_VERSION/cecil.phar" -o cecil.phar
  fi
  chmod +x cecil.phar
fi

echo "🚀 Running Cecil build…"
php ./cecil.phar build

echo "✅ Cecil build complete."

