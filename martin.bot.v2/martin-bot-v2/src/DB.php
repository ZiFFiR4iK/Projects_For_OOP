<?php

namespace App;

use Doctrine\DBAL\Connection;

class DB
{
    public static function getConnection(): Connection
    {
        return Config::get('database.doctrine.connection');
    }
}