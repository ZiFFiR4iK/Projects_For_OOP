<?php

namespace App\Console\Commands;

use App\Config;
use Doctrine\DBAL\Connection;
use Doctrine\DBAL\Schema\Schema;
use Doctrine\DBAL\Types\Types;

class DatabaseInstallCommand implements CommandInterface
{
    private string $name = 'migrate:init';
    public function handle(): int
    {
        /** @var Connection $connection */
        $connection = Config::get('database.doctrine.connection');

        $schema = new Schema();
        $table  = $schema->createTable(Config::get('app.migrations'));
        $table->addColumn('id', Types::INTEGER, ['unsigned' => true, 'autoincrement' => true]);
        $table->addColumn('migration', Types::STRING, ['length' => 255]);
        $table->addColumn('created_at', Types::DATETIME_IMMUTABLE, [
            'default' => $connection->getDatabasePlatform()->getCurrentTimestampSQL()
        ]);
        $table->setPrimaryKey(['id']);

        $sqlArray = $schema->toSql($connection->getDatabasePlatform());

        $connection->executeQuery($sqlArray[0]);

        echo 'Migrations table created'.PHP_EOL;

        return 0;
    }
}