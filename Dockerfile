# Use PHP 8.2 with Apache
FROM php:8.2-apache

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libzip-dev unzip git curl libonig-dev libxml2-dev build-essential zlib1g-dev \
    && docker-php-ext-configure zip \
    && docker-php-ext-install pdo pdo_mysql zip mbstring tokenizer xml ctype \
    && a2enmod rewrite \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory (project root)
WORKDIR /var/www/laravel-app

# Copy composer from official image
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Copy composer files
COPY composer.json composer.lock ./

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Copy full project into container
COPY . .

# Copy .env if missing
RUN cp .env.example .env || true

# Set permissions
RUN chown -R www-data:www-data /var/www/laravel-app \
    && chmod -R 775 /var/www/laravel-app/storage /var/www/laravel-app/bootstrap/cache

# Point Apache to Laravel's public folder
RUN sed -i 's|/var/www/html|/var/www/laravel-app/public|g' /etc/apache2/sites-available/000-default.conf
RUN sed -i 's|<Directory /var/www/>|<Directory /var/www/laravel-app/public>|g' /etc/apache2/apache2.conf

# Suppress ServerName warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Expose Apache port
EXPOSE 80

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Start container via entrypoint
CMD ["docker-entrypoint.sh"]
