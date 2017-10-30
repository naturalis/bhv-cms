# PHP & Apache Dockerfile for Boerhaave CMS system
FROM php:7.0-apache
RUN docker-php-ext-install mysqli

# Enable apache mods.
RUN a2enmod php7.0
RUN a2enmod rewrite
