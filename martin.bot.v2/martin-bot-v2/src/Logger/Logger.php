<?php

namespace App\Logger;

use Throwable;

class Logger
{
    public function __construct(
        protected string $logPath
    )
    {
    }

    function logException(Throwable $e, string $file): void
    {
        $dir = $this->logPath;
        if (!is_dir($dir)) {
            mkdir($dir, 0777, true);
        }

        $timestamp = date('Y-m-d H:i:s');

        $message = sprintf(
            "[%s] %s: %s in %s on line %d\nStack trace:\n%s\n\n",
            $timestamp,
            get_class($e),
            $e->getMessage(),
            $e->getFile(),
            $e->getLine(),
            $e->getTraceAsString()
        );

        file_put_contents($this->logPath . '/' . $file, $message, FILE_APPEND);
    }
}