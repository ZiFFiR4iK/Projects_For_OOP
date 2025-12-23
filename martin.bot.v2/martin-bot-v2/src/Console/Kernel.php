<?php

namespace App\Console;


use App\Application;
use App\Bootstrappers\BootServiceProviders;
use App\Bootstrappers\LoadConfigurationFiles;
use App\Bootstrappers\LoadEnvironmentVariables;
use App\Bootstrappers\RegisterServiceProviders;
use App\Config;
use Throwable;

class Kernel
{
    public function __construct(
        private Application $app
    )
    {
        $this->bootstrap();
    }

    private array $bootstrapers = [
        LoadEnvironmentVariables::class,
        LoadConfigurationFiles::class,
        RegisterServiceProviders::class,
        BootServiceProviders::class
    ];

    public function handle(array $input): int
    {
        try {
            return $this->run($input);
        } catch (Throwable $e) {
            echo 'Error: '.$e->getMessage().PHP_EOL;

            return 1;
        }
    }

    public function bootstrappers(): array
    {
        return $this->bootstrapers;
    }

    public function bootstrap(): void
    {
        $this->app->bootstrapWith($this->bootstrappers());
    }

    public function run(array $input): int
    {
        $commandName = $input[1] ?? null;

        $command = Config::get("command.{$commandName}");

        return $command->handle();
    }

    public function runCommand(string $commandName) {
        $command = Config::get("command.{$commandName}");

        return $command->handle();
    }
}