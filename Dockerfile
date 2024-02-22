FROM php:8.1-alpine

ENV PAGER='busybox more'
ENV WP_CLI_ALLOW_ROOT=1

RUN docker-php-ext-install mysqli pdo pdo_mysql && \
  docker-php-ext-enable mysqli pdo_mysql

RUN apk update && apk add mysql-client mariadb-connector-c-dev \
  zip bash git

COPY sbin         /usr/local/sbin
COPY wp.gitignore /tmp/.gitignore

WORKDIR /tmp
