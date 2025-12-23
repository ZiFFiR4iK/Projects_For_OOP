<?php

use App\Config;
use App\Env;


if (! function_exists('env')) {
    function env(string $key): ?string
    {
        return Env::get($key);
    }
}

if (! function_exists('config')) {
    function config(string $key)
    {
        return Config::get($key);
    }
}



if (! function_exists('join_paths')) {
    function join_paths(): string
    {
        $args = func_get_args(); // Get all arguments passed to the function
        $paths = [];

        // Flatten nested arrays of path segments
        foreach ($args as $arg) {
            $paths = array_merge($paths, (array)$arg);
        }

        // Remove any empty path segments
        $paths = array_filter($paths);

        // Join the segments with the directory separator
        return implode(DIRECTORY_SEPARATOR, $paths);
    }
}

if (! function_exists('value')) {
    function value($value, ...$args)
    {
        return $value instanceof Closure ? $value(...$args) : $value;
    }
}

if (! function_exists('custom_basename')) {
    function custom_basename(string $path, string $suffix = ''): string {
        // нормализуем слэши (Windows \ -> /)
        $path = str_replace('\\', '/', $path);

        // отрезаем путь до последнего слэша
        $pos = strrpos($path, '/');
        $basename = ($pos === false) ? $path : substr($path, $pos + 1);

        // если указан суффикс и basename на него оканчивается → обрезаем
        if ($suffix !== '' && substr($basename, -strlen($suffix)) === $suffix) {
            $basename = substr($basename, 0, -strlen($suffix));
        }

        return $basename;
    }
}
