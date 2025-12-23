<?php
declare(strict_types=1);

use Dotenv\Dotenv;

$phar = \Phar::running(false);
$BASE = $phar ? ('phar://' . $phar) : __DIR__;
$DISK = $phar ? \dirname($phar) : \dirname(__DIR__ ?? __FILE__);

require $BASE . '/vendor/autoload.php';

if (class_exists(Dotenv::class)) {
    $dotenv = Dotenv::createImmutable($DISK);
    $dotenv->safeLoad();
}

/** @var App\Application $app */
$app = require $BASE . '/bootstrap/app.php';

$kernel = $app->makeTelegramKernel();
$kernel->handle();

