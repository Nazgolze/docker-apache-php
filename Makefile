build: build-xdebug build-xhprof build-base

test: build test-base test-xdebug test-xhprof

build-base:
	docker build -t droptica/apache-php:php7 base
	docker build -t droptica/apache-php:php5 base/php5

test-base:
	@echo "test pase PHP 7.0"
	@./tests.py 'droptica/apache-php:php7' 'php' 'PHP 7.0'
	@./tests.py 'droptica/apache-php:php7' 'apache2' 'apache2'
	@echo "build pase PHP 5.6"
	@./tests.py 'droptica/apache-php:php5' 'php' 'PHP 5.6'
	@./tests.py 'droptica/apache-php:php5' 'apache2' 'apache2'

build-xdebug: build-base
	docker build -t droptica/apache-php:xdebug xdebug
	docker build -t droptica/apache-php:xdebug-php5 xdebug/php5

test-xdebug:
	@echo "test pase PHP 7.0 with xdebug"
	@./tests.py 'droptica/apache-php:xdebug' 'php' 'PHP 7.0'
	@./tests.py 'droptica/apache-php:xdebug' 'apache2' 'apache2'
	@./tests.py 'droptica/apache-php:xdebug' 'php-extension' 'xdebug'
	@echo "test pase PHP 5.6 with xdebug"
	@./tests.py 'droptica/apache-php:xdebug-php5' 'php' 'PHP 5.6'
	@./tests.py 'droptica/apache-php:xdebug-php5' 'apache2' 'apache2'
	@./tests.py 'droptica/apache-php:xdebug-php5' 'php-extension' 'xdebug'


build-xhprof: build-xdebug
	docker build -t droptica/apache-php:xhprof-php5 xhprof/php5

test-xhprof:
	@echo "test pase PHP 5.6 with xhprof"
	@./tests.py 'droptica/apache-php:xhprof-php5' 'php' 'PHP 5.6'
	@./tests.py 'droptica/apache-php:xhprof-php5' 'apache2' 'apache2'
	@./tests.py 'droptica/apache-php:xhprof-php5' 'php-extension' 'xdebug'
	@./tests.py 'droptica/apache-php:xhprof-php5' 'php-extension' 'xhprof'
