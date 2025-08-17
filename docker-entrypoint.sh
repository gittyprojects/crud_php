#!/bin/bash
set -e

# Generate Laravel APP_KEY if missing
if ! grep -q '^APP_KEY=' .env || [ -z "$(grep '^APP_KEY=' .env | cut -d '=' -f2)" ]; then
    php artisan key:generate --ansi
fi

# Clear Laravel caches
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear

# Optional: Run migrations automatically
# php artisan migrate --force

# Start Apache in foreground
apache2-foreground
