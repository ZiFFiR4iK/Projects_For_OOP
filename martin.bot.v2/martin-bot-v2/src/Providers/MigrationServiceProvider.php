<?php

namespace App\Providers;

use App\Config;
use App\Console\Commands\MigrateCommand;
use App\Migrations\MigrationRepository;
use App\Migrations\Migrator;

class MigrationServiceProvider extends ServiceProvider
{
    protected array $commands = [
    ];

    public function register(): void
    {
        $this->registerRepository();

        $this->registerMigrator();

        $this->registerCreator();

        $this->registerCommands($this->commands);
    }

    public function registerRepository(): void
    {
        $table = Config::get('app.migrations');
        $connection = Config::get('database.doctrine.connection');

        Config::set('migration.repository', new MigrationRepository($connection, $table));
    }

    public function registerMigrator(): void
    {
        $connection = Config::get('database.doctrine.connection');
        $repository = Config::get('migration.repository');

        Config::set('migrator', new Migrator($connection, $repository));
    }

    public function registerCreator(): void
    {
        ## TODO: create migration with console
    }

    public function registerCommands(array $commands)
    {
        ## TODO: create subcommands for migration
    }
}