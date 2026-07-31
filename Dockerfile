FROM php:8.4-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    unzip git curl libzip-dev zip default-mysql-client \
    && docker-php-ext-install pdo pdo_mysql zip

# install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Working directory
WORKDIR /var/www

# Copy existing application directory contents
COPY . /var/www


# Install dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction


# Copy  entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
    && sed -i 's/\r$//' /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm", "-F"]




