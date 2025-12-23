<?php

require __DIR__ . '/vendor/autoload.php';

use App\Config;
use App\Env;
use Doctrine\DBAL\ArrayParameterType;
use Doctrine\DBAL\Connection;
use Doctrine\DBAL\DriverManager;
use Doctrine\DBAL\ParameterType;
use Dotenv\Dotenv;

Dotenv::create(
    Env::getRepository(),
    __DIR__,
    '.env'
)->load();


function migrateUsersFromOldDb(Connection $oldDatabaseConnection, Connection $newDatabaseConnection)
{
    $newDatabaseQueryBuilder = $newDatabaseConnection->createQueryBuilder();
    $usersIdOnNewDb = $newDatabaseQueryBuilder
        ->from('user')
        ->select('id')
        ->fetchAllAssociative();

    if (! $usersIdOnNewDb) { $usersIdOnNewDb = []; }
    $existingIds = array_map(function ($userId) {
        return $userId['id'];
    }, $usersIdOnNewDb);

    $oldDatabaseQueryBuilder = $oldDatabaseConnection->createQueryBuilder();
    $diffUsers = $oldDatabaseQueryBuilder
        ->select('*')
        ->from('users', 'u')
        ->where($oldDatabaseQueryBuilder->expr()->notIn('u.chat_id', ':existingIds'))
        ->setParameter('existingIds', $existingIds, ArrayParameterType::INTEGER)
        ->executeQuery()
        ->fetchAllAssociative();

    if ($diffUsers) {
        $newUsers = array_map(function ($user) {
            return [
                'id' => $user['chat_id'],
                'first_name' => $user['first_name'],
                'last_name' => $user['last_name'],
                'username' => $user['username'],
                'language_code' => 'ru',
                'is_premium' => 0,
                'added_to_attachment_menu' => 0,
                'created_at' => date('Y-m-d H:i:s', time()),
                'updated_at' => date('Y-m-d H:i:s', time()),
            ];
        }, $diffUsers);

        foreach ($newUsers as $newUser) {
            $newDatabaseConnection->insert('user', $newUser);
        }
    }
}

function buildConnection(): Connection
{
    $credentials = [
        'host' => env('DB_HOST'),
        'port' => env('DB_PORT'),
        'dbname' => env('DB_DATABASE'),
        'user' => env('DB_USERNAME'),
        'password' => env('DB_PASSWORD')
    ];

    $driver = env('DB_CONNECTION');
    $credentials['driver'] = "pdo_{$driver}";

    return DriverManager::getConnection($credentials);
}

function buildOldConnection(): Connection
{
    $credentials = [
        'host' => env('OLD_DB_HOST'),
        'port' => env('OLD_DB_PORT'),
        'dbname' => env('OLD_DB_DATABASE'),
        'user' => env('OLD_DB_USERNAME'),
        'password' => env('OLD_DB_PASSWORD')
    ];

    $driver = env('OLD_DB_CONNECTION');
    $credentials['driver'] = "pdo_{$driver}";

    return DriverManager::getConnection($credentials);
}


$newDatabaseConnection = buildConnection();
$oldDatabaseConnection = buildOldConnection();

migrateUsersFromOldDb($oldDatabaseConnection, $newDatabaseConnection);