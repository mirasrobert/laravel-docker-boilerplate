FROM nginx:stable-alpine

ARG UID
ARG GID
ARG USER

ENV UID=${UID}
ENV GID=${GID}
ENV USER=${USER}

RUN addgroup -g ${GID} --system ${USER}
RUN adduser -G ${USER} --system -D -s /bin/sh -u ${UID} ${USER}
RUN sed -i "s/user  nginx/user ${USER}/g" /etc/nginx/nginx.conf

# Add Nginx Configuration [Reverse Proxy]
ADD ./docker/nginx/default.conf /etc/nginx/conf.d/

# Create directorty if not exist
RUN mkdir -p /var/www/html