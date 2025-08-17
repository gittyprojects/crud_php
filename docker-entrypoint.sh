#!/bin/bash
set -e

# Ensure we are in the project root
cd /var/www/laravel-app

# Generate APP_KEY if missing
if ! grep -q '^APP_KEY=' .env || [ -z "$(grep '^APP_KEY=' .env | cut -d '=' -f2)" ]; then
    echo "Generating APP_KEY..."
    php artisan key:generate --ansi
fi

# Clear Laravel caches
echo "Clearing Laravel caches..."
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear

# Optional: Run migrations automatically
# echo "Running migrations..."
# php artisan migrate --force

# Start Apache in foreground
echo "Starting Apache..."
apache2-foreground
