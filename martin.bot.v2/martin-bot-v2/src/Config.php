<?php

namespace App;


class Config
{
    public static Repository $config;
    public static function register(Repository $config): void
    {
        static::$config = $config;
    }

    public static function get(string $key)
    {
        return static::$config->get($key);
    }

    public static function set(string $key, mixed $value): void
    {
        static::$config->set($key, $value);
    }
}