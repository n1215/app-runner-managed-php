# App Runner Managed PHP Runtime with Apache + PHP-FPM

An example running Apache HTTP Server and PHP-FPM on AWS App Runner's managed runtime.

No more built-in web servers in production.

## !!Caution!!
If you want to run this example in production, please change [scripts/entrypoint.sh](scripts/entrypoint.sh) and use some process manager like supervisord.
PHP managed runtime seems to be based on Amazon Linux 2, so `yum install -y` command is available on [scripts/build.sh](scripts/build.sh).

See https://docs.docker.com/config/containers/multi-service_container/
