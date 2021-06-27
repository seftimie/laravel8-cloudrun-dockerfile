FROM php:7.3-apache-stretch
WORKDIR /app
COPY . /var/www/

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    mysql-client

RUN docker-php-ext-install pdo pdo_mysql mysqli

EXPOSE 8080
COPY docker/000-default.conf /etc/apache2/sites-available/000-default.conf

RUN chown -R www-data:www-data /var/www/;
RUN find //var/www/ -type f -exec chmod 644 {} \;
RUN find //var/www/ -type d -exec chmod 755 {} \;

RUN cd //var/www/ && \
    chgrp -R www-data storage bootstrap/cache && \
    chmod -R ug+rwx storage bootstrap/cache && \
    echo "Listen 8080" >> /etc/apache2/ports.conf && \
    a2enmod rewrite

