FROM php:8.2-fpm

ARG PHPGROUP
ARG PHPUSER

ENV PHPGROUP=${PHPGROUP}
ENV PHPUSER=${PHPUSER}

RUN addgroup -g 1000 ${PHPGROUP} && adduser -g ${PHPGROUP} -s /bin/sh -D ${PHPUSER}; exit 0

# Change user and group
RUN sed -i "s/user = www-data/user = ${PHPUSER}/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = ${PHPGROUP}/g" /usr/local/etc/php-fpm.d/www.conf

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libfreetype-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo pdo_mysql

# Create a source code folder inside the container
RUN mkdir -p /var/www/html

# Set the main source code folder permission
RUN chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

# Copy the source code from local to container
COPY ./src .

RUN mkdir -p /usr/local/bin

# Copy the permission.sh script into the Docker image
COPY ./docker/php/permission.sh /usr/local/bin/permission.sh

# Make the script executable
RUN chmod +x /usr/local/bin/permission.sh

# Run permission bash and php fpm
CMD ["/bin/bash", "-c", "/usr/local/bin/permission.sh && php-fpm -y /usr/local/etc/php-fpm.conf -R"]