<?php

declare(strict_types=1);

require __DIR__ . '/../vendor/autoload.php';

$logger = createLogger();
$env = getenv('APP_ENV') ?? 'unknown';
$logger->info("Logging from PHP application. (env={$env})");

echo "Hello, App Runner PHP Managed Runtime!";

function createLogger(): Psr\Log\LoggerInterface
{
    $logger = new Monolog\Logger('MyApp');
    $logger->pushHandler(new Monolog\Handler\StreamHandler('php://stdout', Monolog\Level::Debug));
    return $logger;
}
