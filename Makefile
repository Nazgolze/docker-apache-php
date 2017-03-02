build: build-xdebug build-xhprof build-base

test: build test-1.0 test-1.1 test-1.2 test-1.3 test-master

build-base:
	docker build -t droptica/apache-php:php7 base
	docker build -t droptica/apache-php:php5 base/php5

build-xdebug: build-base
	docker build -t droptica/apache-php:xdebug xdebug
	docker build -t droptica/apache-php:xdebug-php5 xdebug/php5

build-xhprof: build-xdebug
	docker build -t droptica/apache-php:xhprof-php5 xhprof/php5
