<?php

require __DIR__ . '/vendor/autoload.php';
use App\Env;
use Dotenv\Dotenv;

/**
 * Create a MySQL dump file using mysqldump
 *
 * @param string      $host  MySQL host
 * @param string      $user  MySQL username
 * @param string      $pass  MySQL password
 * @param string      $db    Database name
 * @param int         $port  MySQL port (default 3306)
 * @param string|null $file  Output file path (auto-generated if null)
 *
 * @return string|false  Path to the dump file, or false on error
 */
function createMysqlDump(
    string $host,
    string $user,
    string $pass,
    string $db,
    int $port = 3306,
    string $file = null
): string|false {
    if ($file === null) {
        $file = __DIR__ . "/database/backups/backup_" . $db . "_" . date("Y-m-d_H-i-s") . ".sql";
    }

    $hostEsc = escapeshellarg($host);
    $userEsc = escapeshellarg($user);
    $passEsc = escapeshellarg($pass);
    $dbEsc   = escapeshellarg($db);
    $fileEsc = escapeshellarg($file);

    $command = "mysqldump --host={$hostEsc} --port={$port} --user={$userEsc} --password={$passEsc} {$dbEsc} > {$fileEsc}";

    exec($command, $output, $resultCode);

    return $resultCode === 0 ? $file : false;
}

Dotenv::create(
    Env::getRepository(),
    __DIR__,
    '.env'
)->load();


$dumpFile = createMysqlDump(
    env('DB_HOST'),
    env('DB_USERNAME'),
    env('DB_PASSWORD'),
    env('DB_DATABASE'),
    env('DB_PORT')
);

if ($dumpFile !== false) {
    echo "Dump created successfully: $dumpFile\n";
} else {
    echo "Failed to create dump!\n";
}