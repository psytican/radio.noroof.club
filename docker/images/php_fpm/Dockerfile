FROM php:8.3.10-fpm

MAINTAINER Evgenii Panov <ev.panov@gmail.com>

ENV	DEBIAN_FRONTEND noninteractive

RUN apt-get update -yqq \
    && apt-get upgrade -yqq \
    && apt-get install -yqq supervisor \
    && apt-get clean

WORKDIR /opt/app

RUN usermod -u 1000 www-data