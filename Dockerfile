FROM php:8.1-alpine

RUN docker-php-ext-install mysqli pdo pdo_mysql && \
  docker-php-ext-enable mysqli pdo_mysql

RUN apk update && apk add mysql-client mariadb-connector-c-dev \
  zip bash git

WORKDIR /tmp
