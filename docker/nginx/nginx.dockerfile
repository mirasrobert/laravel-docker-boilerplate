FROM nginx:stable-alpine

ARG UID
ARG GID
ARG NGINX_USER

ENV UID=${UID}
ENV GID=${GID}
ENV NGINX_USER=${NGINX_USER}

RUN addgroup -g ${GID} --system ${NGINX_USER}
RUN adduser -G ${NGINX_USER} --system -D -s /bin/sh -u ${UID} ${NGINX_USER}
RUN sed -i "s/user  nginx/user ${NGINX_USER}/g" /etc/nginx/nginx.conf

# Add Nginx Configuration [Reverse Proxy]
ADD ./docker/nginx/default.conf /etc/nginx/conf.d/

# Create directorty if not exist
RUN mkdir -p /var/www/html