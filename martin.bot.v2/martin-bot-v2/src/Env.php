<?php

namespace App;

use Dotenv\Repository\RepositoryBuilder;
use Dotenv\Repository\RepositoryInterface;

class Env
{
    public static RepositoryInterface|null $repository = null;

    public static function getRepository(): RepositoryInterface
    {
        if (!static::$repository) {
            static::$repository = RepositoryBuilder::createWithDefaultAdapters()
                ->immutable()->make();
        }

        return static::$repository;

    }

    public static function get(string $key)
    {
        return static::getRepository()->get($key);
    }
}