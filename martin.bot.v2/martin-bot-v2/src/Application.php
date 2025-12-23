<?php

namespace App;

use App\Console\Kernel as ConsoleKernel;
use App\Providers\ConsoleApplicationServiceProvider;
use App\Providers\DatabaseServiceProvider;
use App\Providers\MigrationServiceProvider;
use App\Providers\ServiceProvider;
use App\Telegram\Kernel as TelegramKernel;

class Application
{
    private string $basePath;

    /**
     * All of registered service providers.
     *
     * @var ServiceProvider[]
     */
    protected array $serviceProviders = [
        DatabaseServiceProvider::class,
        MigrationServiceProvider::class,
        ConsoleApplicationServiceProvider::class,
    ];

    /**
     * The names of the loaded service providers.
     *
     * @var array
     */
    protected array $loadedProviders = [];

    public function __construct(
        string $basePath
    )
    {
        $this->basePath = $basePath;
    }

    public function bootstrapWith(array $bootstrappers)
    {
        foreach ($bootstrappers as $bootstrapper) {
            (new $bootstrapper)->bootstrap($this);
        }
    }


    public function basePath($path = ''): string
    {
        return join_paths($this->basePath, $path);
    }

    public function databasePath(): string
    {
        return $this->basePath('database');
    }

    public function getConfigPath(): string
    {
        return $this->basePath('config');
    }

    public function registerConfiguredProviders(): void
    {
        $providers = array_merge($this->serviceProviders, Config::get('app.providers'));

        foreach ($providers as $provider) {
            $this->register($provider);
        }
    }

    public function register($provider)
    {
        if ($registered = $this->getProvider($provider)) {
            return $registered;
        }

        if (is_string($provider)) {
            $provider = $this->resolveProvider($provider);
        }

        $provider->register();
        $this->markAsRegistered($provider);

        return $provider;
    }

    public function resolveProvider($provider)
    {
        return new $provider($this);
    }

    public function markAsRegistered(ServiceProvider $provider): void
    {
        $this->serviceProviders[] = $provider;

        $this->loadedProviders[get_class($provider)] = true;
    }

    public function getProvider($provider)
    {
        return array_values($this->getProviders($provider))[0] ?? null;
    }
    public function getProviders($provider): array
    {
        $name = is_string($provider) ? $provider : get_class($provider);

        return Arr::where($this->serviceProviders, fn ($value) => $value instanceof $name);
    }

    public function makeConsoleKernel(): ConsoleKernel
    {
        $kernel = new ConsoleKernel($this);
        Config::set('console.kernel', $kernel);

        return $kernel;
    }

    public function makeTelegramKernel(): TelegramKernel
    {
        $kernel = new TelegramKernel($this);
        Config::set('telegram.kernel', $kernel);

        return $kernel;
    }

}