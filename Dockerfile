FROM composer:1.9.0 as build
WORKDIR /app
COPY . /app
RUN composer global require hirak/prestissimo && \
    composer install --no-scripts --no-autoloader && \
    composer dump-autoload --optimize

FROM php:7.3-apache-stretch

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    mysql-client

RUN docker-php-ext-install pdo pdo_mysql mysqli

EXPOSE 8080
COPY --from=build /app /var/www/
COPY docker/000-default.conf /etc/apache2/sites-available/000-default.conf


RUN sudo chown -R www-data:www-data /var/www/ && \
    sudo find //var/www/ -type f -exec chmod 644 {} \; && \
    sudo find //var/www/ -type d -exec chmod 755 {} \; && \
    cd //var/www/ && \
    sudo chgrp -R www-data storage bootstrap/cache && \
    sudo chmod -R ug+rwx storage bootstrap/cache && \
    echo "Listen 8080" >> /etc/apache2/ports.conf && \
    a2enmod rewrite

