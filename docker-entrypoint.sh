#!/bin/bash
set -e

# Ensure Laravel APP_KEY exists
if ! php artisan key:generate --check; then
    php artisan key:generate --ansi
fi

# Clear caches to avoid old config issues
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear

# Optional: run migrations automatically
# php artisan migrate --force

# Start Apache in foreground
apache2-foreground
