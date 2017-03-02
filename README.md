# Apache and php on docker tailored for Drupal/Wordpress

## Tags
- `php7`, `latest`,
- `php5`, 
- `xdebug`, `xdebug-php5`, //default php version is php7
- `xhprof-php5` // xhprof does not support php7 out of the box at this time

## Installation / Usage

1. Install the `droptica/apache-php` container:

    ``` sh
    $ docker pull droptica/apache-php
    ```

  Alternatively, pull a specific version of `droptica/apache-php`:
    ``` sh
    $ docker pull droptica/apache-php:xdebug-php5
    ```
    
2. Download drupal to a folder of your choosing    

3. Run the containter
    ```
    $ docker run -p 8080:80 -v /my-folder/with-drupal:/var/www/html droptica/apache-php:xdebug
    ```
    or if you are in the drupal folder you can
    ```
    $ docker run -p 8080:80 -v $(pwd):/var/www/html droptica/apache-php:xdebug
    ```
    In your browser go to http://localhost:8080 and see your drupal there
    
4. Docker compose
    Most of the time you would also want database and perhaps other containers (eg.mysql, phpmyadmin):
    
    ```
  web:
    image: droptica/apache-php
    volumes:
      - ./dir-with-drupal:/var/www/html
    links:
      - mysql:mysql
    environment:
#      DOCUMENT_ROOT: /var/www/html

  mysql:
    image: mysql:5.6
    volumes:
#      - ./dir-for-persistent-database-files:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: root-password
      MYSQL_DATABASE: db
      MYSQL_USER: user
      MYSQL_PASSWORD: password
      
  phpmyadmin:
    image: nazarpc/phpmyadmin
    links:
      - mysql:mysql
    ```
   run
   ```
   docker-compose up
   ```

## Configuration


- `ENV DOCUMENT_ROOT` // allows to specify path for document root different then /var/www/html
