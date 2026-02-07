FROM php:8.4-apache

RUN apt update && apt upgrade
RUN apt install -y nano curl unzip zip libpng-dev libjpeg-dev libfreetype6-dev libzip-dev
RUN rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd pdo pdo_mysql zip opcache

RUN a2enmod rewrite

WORKDIR /var/www/html

RUN curl -L https://ftp.drupal.org/files/projects/drupal-11.3.3.tar.gz --output drupal.tar.gz
RUN tar -xzf drupal.tar.gz --strip-components=1
RUN rm drupal.tar.gz

RUN chown -R www-data:www-data /var/www/html


