<?php

use App\Providers\MigrationServiceProvider;

return [
    'providers' => [
    ],
    'kernel_path' => dirname(__DIR__),
    'migrations' => 'martin_migrations',
    'application' => [
        'username' => env('APP_USERNAME'),
        'password' => env('APP_PASSWORD')
    ]
];