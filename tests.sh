#!/usr/bin/env bash

TEST=${1}
EXPECTED="${2}"
echo "TEST type ${TEST}"
echo "EXPECTED value ${EXPECTED}"

if [ ${TEST} == "php" ]
then
  PHP_VER="$(docker run droptica/apache-php:php7 php --version | grep  PHP\ 7.0 | cut -c-7)"
  if [ "${PHP_VER}" == "${EXPECTED}" ]
  then
    echo "PHP installed in version ${PHP_VER}"
  else
    echo "PHP version incorrect or missing, found only this: ${PHP_VER}"
    exit 1
  fi
fi

if [ ${TEST} == "apache2" ]
then
  APACHE_VER="$(docker run droptica/apache-php:php7 dpkg --get-selections | tail -n+1 | grep -m 1 apache2 | cut -c-7)"
  if [ "${APACHE_VER}" == "${EXPECTED}" ]
  then
    echo "Apache installed in version ${APACHE_VER}"
  else
    echo "Apache missing, found only this: ${APACHE_VER}"
    exit 1
  fi
fi