FROM php:7.4-fpm-alpine

# Install system dependencies
RUN apk update && apk add --no-cache \
    libzip-dev \
    $PHPIZE_DEPS \
    && docker-php-ext-install pdo pdo_mysql

# Clean up
RUN apk del $PHPIZE_DEPS && rm -rf /var/cache/apk/*
