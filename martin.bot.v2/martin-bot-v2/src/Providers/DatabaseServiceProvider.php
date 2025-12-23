<?php

namespace App\Providers;

use App\Config;
use Doctrine\DBAL\Connection;
use Doctrine\DBAL\DriverManager;

class DatabaseServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        Config::set('database.doctrine.connection', $this->buildConnection());
    }

    protected function buildConnection(): Connection
    {
        $credentials = Config::get('database.credentials');

        $driver = Config::get('database.connection');
        $credentials['driver'] = "pdo_{$driver}";

        return DriverManager::getConnection($credentials);
    }

}