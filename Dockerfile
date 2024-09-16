FROM php:7.4-fpm
LABEL Le Duong <leduong@me.com>
ENV DEBIAN_FRONTEND=noninteractive

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && apt-get update -q \
    && apt-get install -qq -y curl git \
        libcurl3-dev \
        libonig-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxslt-dev \
        unzip zip \
    && apt-get clean

# Install PHP extensions.
RUN docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install -j$(nproc) pdo pdo_mysql
RUN docker-php-ext-install -j$(nproc) curl 
RUN docker-php-ext-install -j$(nproc) exif
RUN docker-php-ext-install -j$(nproc) pcntl
RUN docker-php-ext-install -j$(nproc) opcache
RUN docker-php-ext-install -j$(nproc) xsl
RUN docker-php-ext-install -j$(nproc) bcmath
RUN docker-php-ext-install -j$(nproc) tokenizer
RUN docker-php-ext-install -j$(nproc) calendar
RUN docker-php-ext-install -j$(nproc) sockets

# RUN apt-get install -y \
#         libonig-dev \
#     && docker-php-ext-install iconv mbstring

RUN apt-get install -y \
        libssl-dev \
    && docker-php-ext-install ftp phar

RUN apt-get install -y \
        libicu-dev \
    && docker-php-ext-install intl

RUN apt-get install -y \
        libmcrypt-dev \
    && docker-php-ext-install session

RUN apt-get install -y \
        libxml2-dev \
    && docker-php-ext-install simplexml xml xmlrpc

RUN apt-get install -y \
        libzip-dev \
        zlib1g-dev \
    && docker-php-ext-install zip

RUN apt-get install -y \
        libgmp-dev \
    && docker-php-ext-install gmp