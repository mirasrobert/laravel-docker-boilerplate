FROM nginx:stable-alpine

ARG NGINXGROUP
ARG NGINXUSER

ENV NGINXGROUP=${NGINXGROUP}
ENV NGINXUSER=${NGINXUSER}

# Changing the user Nginx runs
RUN sed -i "s/user www-data/user ${NGINXUSER}/g" /etc/nginx/nginx.conf

# Add Nginx Configuration [Reverse Proxy]
ADD ./nginx/default.conf /etc/nginx/conf.d/

# Create directorty if not exist
RUN mkdir -p /var/www/html

# Create a group and user within the container
RUN addgroup -g 1000 ${NGINXGROUP} && adduser -g ${NGINXGROUP} -s /bin/sh -D ${NGINXUSER}; exit 0