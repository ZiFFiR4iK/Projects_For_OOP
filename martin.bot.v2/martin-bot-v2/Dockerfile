FROM php:8.2-fpm-bookworm

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y --no-install-recommends \
    git unzip curl nano vim gnupg2 ca-certificates \
    libicu-dev libzip-dev libgpgme11-dev \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libxml2-dev libssl-dev libpq-dev libcurl4-openssl-dev \
 && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install -j"$(nproc)" \
    pdo_mysql \
    intl \
    zip \
    gd


COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER=1

RUN echo "phar.readonly=0" > /usr/local/etc/php/conf.d/phar.ini

COPY . .
COPY database box.json composer.json composer.lock ./
RUN #composer install --no-interaction --prefer-dist --no-progress


RUN vendor/bin/box compile

RUN chmod +x bot.phar

RUN php console migrate
