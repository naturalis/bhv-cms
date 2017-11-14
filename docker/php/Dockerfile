# PHP & Apache Dockerfile for Boerhaave CMS system
FROM php:7.0-apache
RUN docker-php-ext-install mysqli pdo pdo_mysql
# Enable apache mods.
RUN a2enmod rewrite
