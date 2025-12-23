<?php

use App\Env;

return [
    'connection' => env('DB_CONNECTION'),
    'credentials' => [
        'host' => env('DB_HOST'),
        'port' => env('DB_PORT'),
        'dbname' => env('DB_DATABASE'),
        'user' => env('DB_USERNAME'),
        'password' => env('DB_PASSWORD')
    ]
];