<?php

namespace App\Bootstrappers;

use App\Application;

class RegisterServiceProviders implements BootstrapperInterface
{
    public function bootstrap(Application $app): void
    {
        $app->registerConfiguredProviders();
    }
}