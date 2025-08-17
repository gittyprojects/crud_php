#!/bin/bash
set -e

# Make sure .env exists
if [ ! -f .env ]; then
    cp .env.example .env
fi

# Generate APP_KEY if missing
if ! grep -q '^APP_KEY=' .env || [ -z "$(grep '^APP_KEY=' .env | cut -d '=' -f2)" ]; then
    echo "Generating APP_KEY..."
    php artisan key:generate --ansi
fi

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL..."
until pg_isready -h $DB_HOST -p $DB_PORT -U $DB_USERNAME > /dev/null 2>&1; do
    sleep 2
done

# Run migrations
echo "Running migrations..."
php artisan migrate --force

# Clear caches
echo "Clearing caches..."
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear

# Start Apache
echo "Starting Apache..."
apache2-foreground
