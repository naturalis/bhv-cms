# PHP & Apache Dockerfile for Boerhaave CMS system
FROM php:7.0-apache
RUN docker-php-ext-install mysqli
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils libmagickwand-dev
RUN apt-get update -y && apt-get install -y libpng-dev zlib1g-dev
RUN docker-php-ext-install gd
RUN pecl install imagick
RUN docker-php-ext-enable imagick
# Enable apache mods.
RUN a2enmod rewrite
