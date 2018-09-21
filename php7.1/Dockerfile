FROM php:7.1-apache
MAINTAINER Droptica <info@droptica.com>

# Packages
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install --no-install-recommends -y \
  libc-client-dev \
  libkrb5-dev \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  libpng-dev \
  mcrypt \
  libmcrypt-dev \
  libjpeg-dev \
  libmemcached-dev \
  patch \
  pkg-config libmagickwand-dev imagemagick \
  zlib1g-dev libicu-dev


RUN pecl install imagick memcached redis
RUN docker-php-ext-enable imagick memcached redis

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install -j$(nproc) bcmath exif fileinfo gd intl imap mbstring mcrypt mysqli pdo pdo_mysql soap xmlrpc zip

RUN docker-php-ext-enable opcache

# Enable apache mods
RUN a2enmod rewrite expires

# Time Zone
RUN echo "date.timezone=${PHP_TIMEZONE:-UTC}" > $PHP_INI_DIR/conf.d/date_timezone.ini

# Create dedicated WWW usera across all images
RUN useradd -u 7001 -s /bin/false -d /var/www -c "Droptica dedicated www user" www

# Add support for WWW user
RUN sed -i -e 's/www-data/www/g' /etc/apache2/envvars

# Cleaning
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD configs/entrypoint.sh /bin/entrypoint.sh
ADD configs/htpasswd.conf /etc/apache2/conf-available/htpasswd.conf
ADD configs/000-default.conf /etc/apache2/sites-available/000-default.conf
ADD configs/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

RUN chmod 777 /bin/entrypoint.sh
ENV DOCUMENT_ROOT /var/www/html

CMD entrypoint.sh
