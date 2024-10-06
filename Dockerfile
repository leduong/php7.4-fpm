# LABEL Le Duong <leduong@me.com>
FROM php:5.5-apache
ENV DEBIAN_FRONTEND=noninteractive


# Import the missing GPG keys
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138 \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9 \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EF0F382A1A7B6500

# Dependencies
## Freshen apt's cache so it knows where to find files.
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
        vim \
        wget \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libc-client-dev \
        libkrb5-dev \
        cron zlib1g zlib1g-dev libxml2 libxml2-dev \
    && apt-get clean \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd zip simplexml soap opcache mysqli pdo pdo_mysql mbstring exif bcmath

RUN docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-install -j$(nproc) iconv mcrypt json imap

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*