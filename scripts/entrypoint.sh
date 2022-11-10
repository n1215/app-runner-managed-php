#!/usr/bin/env bash

set -xe

php-fpm -D

httpd -DFOREGROUND
