<?php
use Doctrine\DBAL\Schema\Schema;
use Doctrine\DBAL\Schema\Table;
use Doctrine\DBAL\Types\Types;

return new class {
    public function up(Schema $schema): void
    {
        $t = $schema->getTable('payment_application');
        $t->addColumn('application_state_id', Types::SMALLINT, [
            'notnull' => false,
        ]);
        $t->addForeignKeyConstraint(
            'application_state', ['application_state_id'], ['id'],
            ['onDelete' => 'SET NULL', 'onUpdate' => 'CASCADE'],
            'fk_application_state_payment_application'
        );

        $t = $schema->getTable('mac_application');
        $t->addColumn('application_state_id', Types::SMALLINT, [
            'notnull' => false,
        ]);
        $t->addForeignKeyConstraint(
            'application_state', ['application_state_id'], ['id'],
            ['onDelete' => 'SET NULL', 'onUpdate' => 'CASCADE'],
            'fk_application_state_mac_application'
        );
    }

    public function down(Schema $schema): void
    {
        $t = $schema->getTable('payment_application');
        $t->dropColumn('application_state_id');

        $t = $schema->getTable('mac_application');
        $t->dropColumn('application_state_id');

        $schema->dropTable('application_state');
    }
};