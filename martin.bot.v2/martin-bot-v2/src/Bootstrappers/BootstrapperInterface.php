<?php

namespace App\Bootstrappers;

use App\Application;

interface BootstrapperInterface
{
    public function bootstrap(Application $app): void;
}