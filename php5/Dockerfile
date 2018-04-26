# Composer Docker Container
# Base Dockerfile: composer/base
FROM php:5-apache
MAINTAINER Droptica <info@droptica.com>

# Packages
RUN a2enmod rewrite expires && apt-get update && apt-get install --no-install-recommends -y \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  libpng12-dev \
  mcrypt \
  libmcrypt-dev \
  libjpeg-dev \
  libmemcached-dev \
  pkg-config libmagickwand-dev imagemagick \
  zlib1g-dev libicu-dev


RUN printf "\n" | pecl install imagick && docker-php-ext-enable imagick \
  && echo "no" | pecl install memcached-2.2.0 && docker-php-ext-enable memcached \
  && pecl install redis && docker-php-ext-enable redis \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j$(nproc) gd pdo pdo_mysql mbstring zip bcmath intl exif fileinfo \
  && docker-php-ext-enable opcache

# Time Zone
RUN echo "date.timezone=${PHP_TIMEZONE:-UTC}" > $PHP_INI_DIR/conf.d/date_timezone.ini

# Create dedicated WWW usera across all images
RUN useradd -u 7001 -s /bin/false -d /var/www -c "Droptica dedicated www user" www

# Add support for WWW user
RUN sed -i -e 's/www-data/www/g' /etc/apache2/envvars

# Cleaning
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD config/entrypoint.sh /bin/entrypoint.sh

RUN chmod 777 /bin/entrypoint.sh

ADD config/htpasswd.conf /etc/apache2/conf-available/htpasswd.conf

ADD config/000-default.conf /etc/apache2/sites-available/000-default.conf
ADD config/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

ENV DOCUMENT_ROOT /var/www/html

CMD entrypoint.sh
