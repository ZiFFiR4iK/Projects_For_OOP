<?php

namespace App\Bootstrappers;

use App\Application;
use App\Env;
use Dotenv\Dotenv;

class LoadEnvironmentVariables implements BootstrapperInterface
{
    public function bootstrap(Application $app): void
    {
        $this->createEnvironment($app->basePath() ?? __DIR__)->load();
    }

    private function createEnvironment(string $envPath): Dotenv
    {
        return Dotenv::create(
            Env::getRepository(),
            $envPath,
            '.env'
        );
    }
}