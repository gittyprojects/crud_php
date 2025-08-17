#!/bin/bash
set -e

# Generate APP_KEY if missing
if ! grep -q '^APP_KEY=' .env || [ -z "$(grep '^APP_KEY=' .env | cut -d '=' -f2)" ]; then
    echo "Generating APP_KEY..."
    php artisan key:generate --ansi
fi

# Clear caches
echo "Clearing caches..."
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear

# Run migrations automatically (optional)
echo "Running migrations..."
php artisan migrate --force || echo "Migration failed, check DB connection"

# Start Apache in foreground
echo "Starting Apache..."
apache2-foreground
