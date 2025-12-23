<?php

namespace App\Console\Commands;

use App\Config;

class MigrateRollbackCommand extends BaseCommand implements CommandInterface
{
    public string $name = 'migrate:rollback';

    public function handle(): int
    {
        Config::get('migrator')->rollback($this->getMigrationPath());

        echo "Successful rollback".PHP_EOL;
        return 0;
    }
}