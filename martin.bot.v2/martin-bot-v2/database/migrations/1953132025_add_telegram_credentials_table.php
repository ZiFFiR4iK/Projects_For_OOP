<?php
use Doctrine\DBAL\Schema\Schema;
use Doctrine\DBAL\Schema\Table;
use Doctrine\DBAL\Types\Types;

return new class {
    public function up(Schema $schema): void
    {
        $t = $schema->createTable('telegram_credentials');
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn(
            'name',
            Types::STRING,
            ['length' => 255]
        );
        $t->addColumn(
            'token',
            Types::STRING,
            ['length' => 255]
        );
        $t->setPrimaryKey(['id']);
    }

    public function down(Schema $schema): void
    {
        if ($schema->hasTable('telegram_credentials')) {
            $schema->dropTable('telegram_credentials');
        }
    }
};