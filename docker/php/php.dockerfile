#FROM php:8.2-fpm
FROM php:8.2-fpm-alpine

ARG UID
ARG GID
ARG PHP_USER

ENV UID=${UID}
ENV GID=${GID}
ENV PHP_USER=${PHP_USER}

# Create a source code folder inside the container
RUN mkdir -p /var/www/html

WORKDIR /var/www/html

# MacOS staff group's gid is 20, so is the dialout group in alpine linux. We're not using it, let's just remove it.
RUN delgroup dialout

RUN addgroup -g ${GID} --system ${PHP_USER}
RUN adduser -G ${PHP_USER} --system -D -s /bin/sh -u ${UID} ${PHP_USER}

RUN sed -i "s/user = www-data/user = ${PHP_USER}/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = ${PHP_USER}/g" /usr/local/etc/php-fpm.d/www.conf
RUN echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf

RUN docker-php-ext-install pdo pdo_mysql

# Copy the source code from local to container
COPY ./src .

# Set the main source code folder permission
RUN chown -R www-data:www-data /var/www/html

CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
