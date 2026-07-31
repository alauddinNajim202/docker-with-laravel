#!/bin/bash

set -e

echo "Fixing permissions..."

chown -R www-data:www-data storage bootstrap/cache || true
chmod -R 775 storage bootstrap/cache || true


echo "Running migrations..."
php artisan migrate --force || true


echo "Starting PHP-FPM..."

exec "$@"
