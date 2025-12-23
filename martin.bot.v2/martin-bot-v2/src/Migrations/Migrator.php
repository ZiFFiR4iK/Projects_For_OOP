<?php

namespace App\Migrations;

use App\Config;
use Doctrine\DBAL\Connection;
use Doctrine\DBAL\Schema\Comparator;
use Doctrine\DBAL\Schema\Schema;

class Migrator
{
    public function __construct(
        private readonly Connection $connection,
        private MigrationRepository $repository
    )
    {
    }

    public function migrate(string $path): void
    {
        $appliedMigrations = $this->getAppliedMigrations();
        $migrationFiles    = $this->getMigrationFiles($path);

        $migrationsToApply = array_values(array_diff($migrationFiles, $appliedMigrations));

        foreach ($migrationsToApply as $migration) {
            $migrationInstance = require $path . '/' . $migration;

            $fromSchema = $this->connection->createSchemaManager()->introspectSchema();
            $toSchema   = clone $fromSchema;

            $migrationInstance->up($toSchema);

            $diff = $this->connection->createSchemaManager()->createComparator()
                ->compareSchemas($fromSchema, $toSchema);
            $platform = $this->connection->getDatabasePlatform();
            $sqls = $platform->getAlterSchemaSQL($diff);

            foreach ($sqls as $sql) {
                $this->connection->executeStatement($sql);
            }

            $this->addMigration($migration);
        }

    }

    public function rollback(string $path): void
    {
        $appliedMigrations = $this->getAppliedMigrations();
        $migrationFiles = $this->getMigrationFiles($path);

        $migrationsToRollback = array_values(array_intersect($migrationFiles, $appliedMigrations));

        foreach ($migrationsToRollback as $migration) {
            $migrationInstance = require $path . '/' . $migration;

            $fromSchema = $this->connection->createSchemaManager()->introspectSchema();
            $toSchema = clone $fromSchema;

            $migrationInstance->down($toSchema);

            $diff = $this->connection->createSchemaManager()->createComparator()
                ->compareSchemas($fromSchema, $toSchema);
            $platform = $this->connection->getDatabasePlatform();
            $sqls = $platform->getAlterSchemaSQL($diff);

            foreach ($sqls as $sql) {
                $this->connection->executeStatement($sql);
            }

            $this->removeMigration($migration);
        }
    }

    private function getAppliedMigrations(): array
    {
        return array_map(fn ($migration) => $migration['migration'], $this->repository->getMigrations());
    }

    private function getMigrationFiles(string $path): array
    {
        $migrationFiles = scandir($path);

        $filteredFiles = array_filter($migrationFiles, function ($fileName) {
            return ! in_array($fileName, ['.', '..']);
        });

        return array_values($filteredFiles);
    }

    private function addMigration(string $migration): void
    {
        $queryBuilder = $this->connection->createQueryBuilder();

        $queryBuilder->insert(Config::get('app.migrations'))
            ->values(['migration' => ':migration'])
            ->setParameter('migration', $migration)
            ->executeStatement();
    }

    public function removeMigration(string $migration): void
    {
        $queryBuilder = $this->connection->createQueryBuilder();

        $queryBuilder
            ->delete(Config::get('app.migrations'))
            ->where('migration = :migration')
            ->setParameter('migration', $migration)
            ->executeStatement();
    }
}