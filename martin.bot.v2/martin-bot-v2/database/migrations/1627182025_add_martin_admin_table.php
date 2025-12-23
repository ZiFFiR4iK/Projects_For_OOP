<?php


use Doctrine\DBAL\Schema\Schema;
use Doctrine\DBAL\Types\Types;

return new class {
    public function up(Schema $schema): void
    {
        $t = $schema->createTable('martin_admin');
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn(
            'username',
            Types::STRING,
            [
                'length' => 255,
                'notnull' => false
            ]
        );
        $t->addColumn(
            'chat_id',
            Types::STRING,
            ['length' => 255]
        );
        $t->setPrimaryKey(['id']);
    }

    public function down(Schema $schema): void
    {
        if ($schema->hasTable('martin_admin')) {
            $schema->dropTable('martin_admin');
        }
    }
};