<?php

namespace App\Migrations;

use Doctrine\DBAL\Connection;
use Doctrine\DBAL\Query\QueryBuilder;

class MigrationRepository
{
    public function __construct(
        private Connection $connection,
        private string $table
    )
    {
    }

    protected function table(): QueryBuilder
    {
        return $this->getConnection()->createQueryBuilder()->from($this->table);
    }

    public function getConnection(): Connection
    {
        return $this->connection;
    }

    public function getMigrations(): array
    {
        return $this->table()->select("*")->fetchAllAssociative();
    }

    public function hasMigrationsTable(): bool
    {
        return $this->getConnection()->createSchemaManager()->tableExists($this->table);
    }
}