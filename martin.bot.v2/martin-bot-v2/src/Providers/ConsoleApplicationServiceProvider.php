<?php

namespace App\Providers;

use App\Config;
use App\Console\Commands\DatabaseInstallCommand;
use App\Console\Commands\MigrateCommand;
use App\Console\Commands\MigrateRollbackCommand;

class ConsoleApplicationServiceProvider extends ServiceProvider
{
    protected array $commands = [
        'InitMigrationDatabase' => DatabaseInstallCommand::class,
        'MigrateCommand' => MigrateCommand::class,
        'RollbackCommand' => MigrateRollbackCommand::class
    ];

    public function register(): void
    {
        $this->registerCommands($this->commands);
    }

    public function registerCommands(array $commands): void
    {
        foreach ($commands as $commandName => $command) {
            $method = "register{$commandName}Command";

            if (method_exists($this, $method)) {
                $this->{$method}();
            } else {
                Config::set('command.'.$this->getCommandName($command), new $command($this->app));
            }
        }
    }

    private function getCommandName(string $command)
    {
        return (new \ReflectionClass($command))
            ->getProperty('name')
            ->getDefaultValue();
    }
}