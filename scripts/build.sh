#!/usr/bin/env bash

set -xe

# Apache httpd config
cp -f /app/conf/httpd/app.conf /etc/httpd/conf.d/app.conf
ln -s /dev/stderr /var/log/httpd/error.log
ln -s /dev/stdout /var/log/httpd/access.log
sed -i -e 's/LoadModule mpm_prefork_module/#LoadModule mpm_prefork_module/g' /etc/httpd/conf.modules.d/00-mpm.conf
sed -i -e 's/#LoadModule mpm_event_module/LoadModule mpm_event_module/g' /etc/httpd/conf.modules.d/00-mpm.conf

# PHP-FPM config
cp -f /app/conf/php-fpm/container.conf /etc/php-fpm.d/container.conf
ln -s /dev/stderr /var/log/php-fpm/error.log
ln -s /dev/stdout /var/log/php-fpm/www-access.log
ln -s /dev/stderr /var/log/php-fpm/www-error.log

# Install Composer
EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
then
    >&2 echo 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php
rm composer-setup.php

# Install dependencies
php composer.phar install


