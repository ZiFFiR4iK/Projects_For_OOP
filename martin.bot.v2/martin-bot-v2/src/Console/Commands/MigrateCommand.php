<?php

namespace App\Console\Commands;

use App\Config;

class MigrateCommand extends BaseCommand implements CommandInterface
{
    public string $name = 'migrate';


    public function handle(): int
    {
        $this->prepareDatabase();
        Config::get('migrator')->migrate($this->getMigrationPath());

        echo "Successful migration".PHP_EOL;
        return 0;
    }

    public function prepareDatabase(): void
    {
        $repository = Config::get('migration.repository');
        if (! $repository->hasMigrationsTable()) {
            Config::get('console.kernel')->runCommand('migrate:init');
        }
    }
}