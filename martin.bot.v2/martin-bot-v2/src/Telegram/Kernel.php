<?php

namespace App\Telegram;

use App\Application;
use App\Bootstrappers\BootServiceProviders;
use App\Bootstrappers\LoadConfigurationFiles;
use App\Bootstrappers\LoadEnvironmentVariables;
use App\Bootstrappers\RegisterServiceProviders;
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

    public function handle(): void
    {
        try {
            $this->buildTelegramBot()->start();
        } catch (Throwable $e) {
            throw new \Exception($e);
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

    public function buildTelegramBot(): TelegramBot
    {
        return new TelegramBot();
    }
}