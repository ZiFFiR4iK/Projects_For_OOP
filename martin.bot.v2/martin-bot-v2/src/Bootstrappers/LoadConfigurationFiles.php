<?php

namespace App\Bootstrappers;

use App\Application;
use App\Config;
use App\Repository;
use Symfony\Component\Finder\Finder;
use Symfony\Component\Finder\SplFileInfo;

class LoadConfigurationFiles implements BootstrapperInterface
{

    public function bootstrap(Application $app): void
    {
        $items = [];
        $config = new Repository($items);

        $this->loadConfigurationFiles($app, $config);

        Config::register($config);
    }

    protected function loadConfigurationFiles(Application $app, Repository $repository): void
    {
        $files = $this->getConfigurationFiles($app);

        foreach ($files as $key => $path) {
            $repository->set($key, require $path);
        }
    }

    protected function getConfigurationFiles(Application $app): array
    {
        $files = [];

        $configPath = $app->getConfigPath();

        foreach (Finder::create()->files()->name('*.php')->in($configPath) as $file) {
            $directory = $this->getNestedDirectory($file, $configPath);

            $files[$directory.custom_basename($file->getPathname(), '.php')] = $file->getPathname();
        }

        ksort($files, SORT_NATURAL);

        return $files;
    }

    protected function getNestedDirectory(SplFileInfo $file, $configPath): string
    {
        $directory = $file->getPath();
        if ($nested = trim(str_replace($configPath, '', $directory), DIRECTORY_SEPARATOR)) {
            $nested = str_replace(DIRECTORY_SEPARATOR, '.', $nested).'.';
        }

        return $nested;
    }
}