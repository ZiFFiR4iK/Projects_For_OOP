<?php

namespace App\Console\Commands;

use App\Application;

class BaseCommand
{
    public string $name = 'migrate:init';

    public function __construct(
        protected Application $app
    )
    {
    }

    protected function getMigrationPath(): string
    {
        return $this->app->databasePath().DIRECTORY_SEPARATOR.'migrations';
    }
}