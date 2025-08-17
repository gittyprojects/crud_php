#!/bin/bash
set -e

# Generate Laravel APP_KEY if missing
if ! grep -q '^APP_KEY=' .env || [ -z "$(grep '^APP_KEY=' .env | cut -d '=' -f2)" ]; then
    echo "Generating APP_KEY..."
    php artisan key:generate --ansi
fi

# Clear Laravel caches
echo "Clearing caches..."
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear

# Optional: Run migrations automatically (uncomment if needed)
# echo "Running migrations..."
# php artisan migrate --force

# Start Apache on Render's assigned port
echo "Starting Apache on port $PORT..."
apache2-foreground -DFOREGROUND -c "Listen ${PORT}"
