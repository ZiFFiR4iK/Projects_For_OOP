<?php
use Doctrine\DBAL\Schema\Schema;
use Doctrine\DBAL\Schema\Table;
use Doctrine\DBAL\Types\Types;

return new class {
    public function up(Schema $schema): void
    {
        $t = $schema->createTable('user');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'comment' => "Unique identifier for this user or bot"]);
        $t->addColumn('is_bot', Types::BOOLEAN, ['default' => false, 'comment' => "True, if this user is a bot"]);
        $t->addColumn('first_name', Types::STRING, ['length' => 255, 'fixed' => true, 'default' => '', 'notnull' => true, 'comment' => "User's or bot's first name"]);
        $t->addColumn('last_name', Types::STRING, ['length' => 255, 'fixed' => true, 'notnull' => false, 'comment' => "User's or bot's last name"]);
        $t->addColumn('username', Types::STRING, ['length' => 191, 'fixed' => true, 'notnull' => false, 'comment' => "User's or bot's username"]);
        $t->addColumn('language_code', Types::STRING, ['length' => 10, 'fixed' => true, 'notnull' => false, 'comment' => "IETF language tag of the user's language"]);
        $t->addColumn('is_premium', Types::BOOLEAN, ['default' => false, 'comment' => "True, if this user is a Telegram Premium user"]);
        $t->addColumn('added_to_attachment_menu', Types::BOOLEAN, ['default' => false, 'comment' => "True, if this user added the bot to the attachment menu"]);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false, 'comment' => 'Entry date creation']);
        $t->addColumn('updated_at', Types::DATETIME_IMMUTABLE, ['notnull' => false, 'comment' => 'Entry date update']);
        $t->setPrimaryKey(['id']);
        $t->addIndex(['username'], 'idx_user_username');

        // chat
        $t = $schema->createTable('chat');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'comment' => 'Unique identifier for this chat']);
        $t->addColumn('type', Types::STRING, [
            'notnull' => true,
            'comment' => 'Type of chat',
            'columnDefinition' => "ENUM('private','group','supergroup','channel') NOT NULL"
        ]);
        $t->addColumn('title', Types::STRING, ['length' => 255, 'fixed' => true, 'default' => '', 'notnull' => true, 'comment' => 'Title, for supergroups, channels and group chats']);
        $t->addColumn('username', Types::STRING, ['length' => 255, 'fixed' => true, 'notnull' => false, 'comment' => 'Username, if available']);
        $t->addColumn('first_name', Types::STRING, ['length' => 255, 'fixed' => true, 'notnull' => false]);
        $t->addColumn('last_name', Types::STRING, ['length' => 255, 'fixed' => true, 'notnull' => false]);
        $t->addColumn('is_forum', Types::BOOLEAN, ['default' => false, 'comment' => 'Supergroup chat is a forum']);
        $t->addColumn('all_members_are_administrators', Types::BOOLEAN, ['default' => false]);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->addColumn('updated_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->addColumn('old_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false, 'comment' => 'Filled when a group is converted to a supergroup']);
        $t->setPrimaryKey(['id']);
        $t->addIndex(['old_id'], 'idx_chat_old_id');

        // user_chat
        $t = $schema->createTable('user_chat');
        $this->mysqlOptions($t);
        $t->addColumn('user_id', Types::BIGINT, ['unsigned' => true, 'comment' => 'Unique user identifier']);
        $t->addColumn('chat_id', Types::BIGINT, ['unsigned' => true, 'comment' => 'Unique chat identifier']);
        $t->setPrimaryKey(['user_id', 'chat_id']);
        $t->addForeignKeyConstraint('user', ['user_id'], ['id'], ['onDelete' => 'CASCADE', 'onUpdate' => 'CASCADE'], 'fk_user_chat_user');
        $t->addForeignKeyConstraint('chat', ['chat_id'], ['id'], ['onDelete' => 'CASCADE', 'onUpdate' => 'CASCADE'], 'fk_user_chat_chat');

        // message_reaction
        $t = $schema->createTable('message_reaction');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true, 'comment' => 'Unique identifier for this entry']);
        $t->addColumn('chat_id', Types::BIGINT, ['unsigned' => true, 'comment' => 'Chat containing the message']);
        $t->addColumn('message_id', Types::BIGINT, ['unsigned' => true, 'comment' => 'Message id inside the chat']);
        $t->addColumn('user_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false, 'comment' => "The user that changed the reaction (if not anonymous)"]);
        $t->addColumn('actor_chat_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false, 'comment' => "The chat on behalf of which the reaction was changed"]);
        $t->addColumn('old_reaction', Types::TEXT, ['comment' => 'Previous list of reaction types']);
        $t->addColumn('new_reaction', Types::TEXT, ['comment' => 'New list of reaction types']);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['id']);
        $t->addIndex(['chat_id'], 'idx_mr_chat');
        $t->addIndex(['user_id'], 'idx_mr_user');
        $t->addIndex(['actor_chat_id'], 'idx_mr_actor_chat');
        $t->addForeignKeyConstraint('chat', ['chat_id'], ['id'], [], 'fk_mr_chat');
        $t->addForeignKeyConstraint('user', ['user_id'], ['id'], [], 'fk_mr_user');
        $t->addForeignKeyConstraint('chat', ['actor_chat_id'], ['id'], [], 'fk_mr_actor_chat');

        // message_reaction_count
        $t = $schema->createTable('message_reaction_count');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn('chat_id', Types::BIGINT, ['unsigned' => true, 'comment' => 'The chat containing the message']);
        $t->addColumn('message_id', Types::BIGINT, ['unsigned' => true, 'comment' => 'Unique message identifier inside the chat']);
        $t->addColumn('reactions', Types::TEXT, ['comment' => 'List of reactions present on the message']);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['id']);
        $t->addIndex(['chat_id'], 'idx_mrc_chat');
        $t->addForeignKeyConstraint('chat', ['chat_id'], ['id'], [], 'fk_mrc_chat');

        // inline_query
        $t = $schema->createTable('inline_query');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'comment' => 'Unique identifier for this query']);
        $t->addColumn('user_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('location', Types::STRING, ['length' => 255, 'fixed' => true, 'notnull' => false]);
        $t->addColumn('query', Types::TEXT);
        $t->addColumn('offset', Types::STRING, ['length' => 255, 'fixed' => true, 'notnull' => false]);
        $t->addColumn('chat_type', Types::STRING, ['length' => 255, 'fixed' => true, 'notnull' => false]);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['id']);
        $t->addIndex(['user_id'], 'idx_inline_user');
        $t->addForeignKeyConstraint('user', ['user_id'], ['id'], [], 'fk_inline_user');

        // chosen_inline_result
        $t = $schema->createTable('chosen_inline_result');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn('result_id', Types::STRING, ['length' => 255, 'fixed' => true, 'default' => '']);
        $t->addColumn('user_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('location', Types::STRING, ['length' => 255, 'fixed' => true, 'notnull' => false]);
        $t->addColumn('inline_message_id', Types::STRING, ['length' => 255, 'fixed' => true, 'notnull' => false]);
        $t->addColumn('query', Types::TEXT);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['id']);
        $t->addIndex(['user_id'], 'idx_cir_user');
        $t->addForeignKeyConstraint('user', ['user_id'], ['id'], [], 'fk_cir_user');

        // message
        $t = $schema->createTable('message');
        $this->mysqlOptions($t);
        $t->addColumn('chat_id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('sender_chat_id', Types::BIGINT, ['unsigned' => true, 'comment' => 'Sender chat']);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'comment' => 'Message id']);
        $t->addColumn('message_thread_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('user_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('sender_boost_count', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('date', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->addColumn('forward_from', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('forward_from_chat', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('forward_from_message_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('forward_signature', Types::TEXT, ['notnull' => false]);
        $t->addColumn('forward_sender_name', Types::TEXT, ['notnull' => false]);
        $t->addColumn('forward_date', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->addColumn('is_topic_message', Types::BOOLEAN, ['default' => false]);
        $t->addColumn('is_automatic_forward', Types::BOOLEAN, ['default' => false]);
        $t->addColumn('reply_to_chat', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('reply_to_message', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('external_reply', Types::TEXT, ['notnull' => false]);
        $t->addColumn('quote', Types::TEXT, ['notnull' => false]);
        $t->addColumn('reply_to_story', Types::TEXT, ['notnull' => false]);
        $t->addColumn('via_bot', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('link_preview_options', Types::TEXT, ['notnull' => false]);
        $t->addColumn('edit_date', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->addColumn('has_protected_content', Types::BOOLEAN, ['default' => false]);
        $t->addColumn('media_group_id', Types::TEXT, ['notnull' => false]);
        $t->addColumn('author_signature', Types::TEXT, ['notnull' => false]);
        $t->addColumn('text', Types::TEXT, ['notnull' => false]);
        $t->addColumn('entities', Types::TEXT, ['notnull' => false]);
        $t->addColumn('caption_entities', Types::TEXT, ['notnull' => false]);
        $t->addColumn('audio', Types::TEXT, ['notnull' => false]);
        $t->addColumn('document', Types::TEXT, ['notnull' => false]);
        $t->addColumn('animation', Types::TEXT, ['notnull' => false]);
        $t->addColumn('game', Types::TEXT, ['notnull' => false]);
        $t->addColumn('photo', Types::TEXT, ['notnull' => false]);
        $t->addColumn('sticker', Types::TEXT, ['notnull' => false]);
        $t->addColumn('story', Types::TEXT, ['notnull' => false]);
        $t->addColumn('video', Types::TEXT, ['notnull' => false]);
        $t->addColumn('voice', Types::TEXT, ['notnull' => false]);
        $t->addColumn('video_note', Types::TEXT, ['notnull' => false]);
        $t->addColumn('caption', Types::TEXT, ['notnull' => false]);
        $t->addColumn('has_media_spoiler', Types::BOOLEAN, ['default' => false]);
        $t->addColumn('contact', Types::TEXT, ['notnull' => false]);
        $t->addColumn('location', Types::TEXT, ['notnull' => false]);
        $t->addColumn('venue', Types::TEXT, ['notnull' => false]);
        $t->addColumn('poll', Types::TEXT, ['notnull' => false]);
        $t->addColumn('dice', Types::TEXT, ['notnull' => false]);
        $t->addColumn('new_chat_members', Types::TEXT, ['notnull' => false]);
        $t->addColumn('left_chat_member', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('new_chat_title', Types::STRING, ['length' => 255, 'notnull' => false]);
        $t->addColumn('new_chat_photo', Types::TEXT, ['notnull' => false]);
        $t->addColumn('delete_chat_photo', Types::BOOLEAN, ['default' => false]);
        $t->addColumn('group_chat_created', Types::BOOLEAN, ['default' => false]);
        $t->addColumn('supergroup_chat_created', Types::BOOLEAN, ['default' => false]);
        $t->addColumn('channel_chat_created', Types::BOOLEAN, ['default' => false]);
        $t->addColumn('message_auto_delete_timer_changed', Types::TEXT, ['notnull' => false]);
        $t->addColumn('migrate_to_chat_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('migrate_from_chat_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('pinned_message', Types::TEXT, ['notnull' => false]);
        $t->addColumn('invoice', Types::TEXT, ['notnull' => false]);
        $t->addColumn('successful_payment', Types::TEXT, ['notnull' => false]);
        $t->addColumn('users_shared', Types::TEXT, ['notnull' => false]);
        $t->addColumn('chat_shared', Types::TEXT, ['notnull' => false]);
        $t->addColumn('connected_website', Types::TEXT, ['notnull' => false]);
        $t->addColumn('write_access_allowed', Types::TEXT, ['notnull' => false]);
        $t->addColumn('passport_data', Types::TEXT, ['notnull' => false]);
        $t->addColumn('proximity_alert_triggered', Types::TEXT, ['notnull' => false]);
        $t->addColumn('boost_added', Types::TEXT, ['notnull' => false]);
        $t->addColumn('forum_topic_created', Types::TEXT, ['notnull' => false]);
        $t->addColumn('forum_topic_edited', Types::TEXT, ['notnull' => false]);
        $t->addColumn('forum_topic_closed', Types::TEXT, ['notnull' => false]);
        $t->addColumn('forum_topic_reopened', Types::TEXT, ['notnull' => false]);
        $t->addColumn('general_forum_topic_hidden', Types::TEXT, ['notnull' => false]);
        $t->addColumn('general_forum_topic_unhidden', Types::TEXT, ['notnull' => false]);
        $t->addColumn('video_chat_scheduled', Types::TEXT, ['notnull' => false]);
        $t->addColumn('video_chat_started', Types::TEXT, ['notnull' => false]);
        $t->addColumn('video_chat_ended', Types::TEXT, ['notnull' => false]);
        $t->addColumn('video_chat_participants_invited', Types::TEXT, ['notnull' => false]);
        $t->addColumn('web_app_data', Types::TEXT, ['notnull' => false]);
        $t->addColumn('reply_markup', Types::TEXT, ['notnull' => false]);

        $t->setPrimaryKey(['chat_id', 'id']);
        $t->addIndex(['user_id'], 'idx_msg_user');
        $t->addIndex(['forward_from'], 'idx_msg_forward_from');
        $t->addIndex(['forward_from_chat'], 'idx_msg_forward_from_chat');
        $t->addIndex(['reply_to_chat'], 'idx_msg_reply_to_chat');
        $t->addIndex(['reply_to_message'], 'idx_msg_reply_to_message');
        $t->addIndex(['via_bot'], 'idx_msg_via_bot');
        $t->addIndex(['left_chat_member'], 'idx_msg_left_chat_member');
        $t->addIndex(['migrate_from_chat_id'], 'idx_msg_migrate_from');
        $t->addIndex(['migrate_to_chat_id'], 'idx_msg_migrate_to');

        $t->addForeignKeyConstraint('user', ['user_id'], ['id'], [], 'fk_msg_user');
        $t->addForeignKeyConstraint('chat', ['chat_id'], ['id'], [], 'fk_msg_chat');
        $t->addForeignKeyConstraint('user', ['forward_from'], ['id'], [], 'fk_msg_forward_from');
        $t->addForeignKeyConstraint('chat', ['forward_from_chat'], ['id'], [], 'fk_msg_forward_from_chat');
        $t->addForeignKeyConstraint('message', ['reply_to_chat','reply_to_message'], ['chat_id','id'], [], 'fk_msg_reply_to');
        $t->addForeignKeyConstraint('user', ['via_bot'], ['id'], [], 'fk_msg_via_bot');
        $t->addForeignKeyConstraint('user', ['left_chat_member'], ['id'], [], 'fk_msg_left_chat_member');

        // edited_message
        $t = $schema->createTable('edited_message');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn('chat_id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('message_id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('user_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('edit_date', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->addColumn('text', Types::TEXT, ['notnull' => false]);
        $t->addColumn('entities', Types::TEXT, ['notnull' => false]);
        $t->addColumn('caption', Types::TEXT, ['notnull' => false]);
        $t->setPrimaryKey(['id']);
        $t->addIndex(['chat_id'], 'idx_em_chat');
        $t->addIndex(['message_id'], 'idx_em_msg');
        $t->addIndex(['user_id'], 'idx_em_user');
        $t->addForeignKeyConstraint('chat', ['chat_id'], ['id'], [], 'fk_em_chat');
        $t->addForeignKeyConstraint('message', ['chat_id','message_id'], ['chat_id','id'], [], 'fk_em_msg');
        $t->addForeignKeyConstraint('user', ['user_id'], ['id'], [], 'fk_em_user');

        // callback_query
        $t = $schema->createTable('callback_query');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('user_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('chat_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('message_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('inline_message_id', Types::STRING, ['length' => 255, 'fixed' => true, 'notnull' => false]);
        $t->addColumn('chat_instance', Types::STRING, ['length' => 255, 'fixed' => true, 'default' => '']);
        $t->addColumn('data', Types::STRING, ['length' => 255, 'fixed' => true, 'default' => '']);
        $t->addColumn('game_short_name', Types::STRING, ['length' => 255, 'fixed' => true, 'default' => '']);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['id']);
        $t->addIndex(['user_id'], 'idx_cbq_user');
        $t->addIndex(['chat_id'], 'idx_cbq_chat');
        $t->addIndex(['message_id'], 'idx_cbq_msg');
        $t->addForeignKeyConstraint('user', ['user_id'], ['id'], [], 'fk_cbq_user');
        $t->addForeignKeyConstraint('message', ['chat_id','message_id'], ['chat_id','id'], [], 'fk_cbq_msg');

        // shipping_query
        $t = $schema->createTable('shipping_query');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('user_id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('invoice_payload', Types::STRING, ['length' => 255, 'fixed' => true, 'default' => '']);
        $t->addColumn('shipping_address', Types::STRING, ['length' => 255, 'fixed' => true, 'default' => '']);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['id']);
        $t->addIndex(['user_id'], 'idx_sq_user');
        $t->addForeignKeyConstraint('user', ['user_id'], ['id'], [], 'fk_sq_user');

        // pre_checkout_query
        $t = $schema->createTable('pre_checkout_query');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('user_id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('currency', Types::STRING, ['length' => 3, 'fixed' => true]);
        $t->addColumn('total_amount', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('invoice_payload', Types::STRING, ['length' => 255, 'fixed' => true, 'default' => '']);
        $t->addColumn('shipping_option_id', Types::STRING, ['length' => 255, 'fixed' => true, 'notnull' => false]);
        $t->addColumn('order_info', Types::TEXT, ['notnull' => false]);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['id']);
        $t->addIndex(['user_id'], 'idx_pcq_user');
        $t->addForeignKeyConstraint('user', ['user_id'], ['id'], [], 'fk_pcq_user');

        // poll
        $t = $schema->createTable('poll');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('question', Types::TEXT);
        $t->addColumn('options', Types::TEXT);
        $t->addColumn('total_voter_count', Types::INTEGER, ['unsigned' => true]);
        $t->addColumn('is_closed', Types::BOOLEAN, ['default' => false]);
        $t->addColumn('is_anonymous', Types::BOOLEAN, ['default' => true]);
        $t->addColumn('type', Types::STRING, ['length' => 255, 'fixed' => true]);
        $t->addColumn('allows_multiple_answers', Types::BOOLEAN, ['default' => false]);
        $t->addColumn('correct_option_id', Types::INTEGER, ['unsigned' => true]);
        $t->addColumn('explanation', Types::STRING, ['length' => 255, 'notnull' => false]);
        $t->addColumn('explanation_entities', Types::TEXT, ['notnull' => false]);
        $t->addColumn('open_period', Types::INTEGER, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('close_date', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['id']);

        // poll_answer
        $t = $schema->createTable('poll_answer');
        $this->mysqlOptions($t);
        $t->addColumn('poll_id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('user_id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('option_ids', Types::TEXT);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['poll_id', 'user_id']);
        $t->addForeignKeyConstraint('poll', ['poll_id'], ['id'], [], 'fk_pa_poll');

        // chat_member_updated
        $t = $schema->createTable('chat_member_updated');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn('chat_id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('user_id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('date', Types::DATETIME_IMMUTABLE);
        $t->addColumn('old_chat_member', Types::TEXT);
        $t->addColumn('new_chat_member', Types::TEXT);
        $t->addColumn('invite_link', Types::TEXT, ['notnull' => false]);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['id']);
        $t->addForeignKeyConstraint('chat', ['chat_id'], ['id'], [], 'fk_cmu_chat');
        $t->addForeignKeyConstraint('user', ['user_id'], ['id'], [], 'fk_cmu_user');

        // chat_join_request
        $t = $schema->createTable('chat_join_request');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn('chat_id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('user_id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('date', Types::DATETIME_IMMUTABLE);
        $t->addColumn('bio', Types::TEXT, ['notnull' => false]);
        $t->addColumn('invite_link', Types::TEXT, ['notnull' => false]);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['id']);
        $t->addForeignKeyConstraint('chat', ['chat_id'], ['id'], [], 'fk_cjr_chat');
        $t->addForeignKeyConstraint('user', ['user_id'], ['id'], [], 'fk_cjr_user');

        // chat_boost_updated
        $t = $schema->createTable('chat_boost_updated');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn('chat_id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('boost', Types::TEXT);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['id']);
        $t->addIndex(['chat_id'], 'idx_cbu_chat');
        $t->addForeignKeyConstraint('chat', ['chat_id'], ['id'], [], 'fk_cbu_chat');

// chat_boost_removed
        $t = $schema->createTable('chat_boost_removed');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn('chat_id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('boost_id', Types::STRING, ['length' => 200]);
        $t->addColumn('remove_date', Types::DATETIME_IMMUTABLE);
        $t->addColumn('source', Types::TEXT);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['id']);
        $t->addIndex(['chat_id'], 'idx_cbr_chat');
        $t->addForeignKeyConstraint('chat', ['chat_id'], ['id'], [], 'fk_cbr_chat');

// telegram_update
        $t = $schema->createTable('telegram_update');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true]);
        $t->addColumn('chat_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('message_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('edited_message_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('channel_post_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('edited_channel_post_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('message_reaction_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('message_reaction_count_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('inline_query_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('chosen_inline_result_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('callback_query_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('shipping_query_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('pre_checkout_query_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('poll_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('poll_answer_poll_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('my_chat_member_updated_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('chat_member_updated_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('chat_join_request_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('chat_boost_updated_id', Types::BIGINT, ['unsigned' => true, 'notnull' => true]);
        $t->addColumn('chat_boost_removed_id', Types::BIGINT, ['unsigned' => true, 'notnull' => true]);
        $t->setPrimaryKey(['id']);

        $t->addIndex(['message_id'], 'idx_tu_message_id');
        $t->addIndex(['chat_id','message_id'], 'idx_tu_chat_message_id');
        $t->addIndex(['edited_message_id'], 'idx_tu_edited_message_id');
        $t->addIndex(['channel_post_id'], 'idx_tu_channel_post_id');
        $t->addIndex(['edited_channel_post_id'], 'idx_tu_edited_channel_post_id');
        $t->addIndex(['inline_query_id'], 'idx_tu_inline_query_id');
        $t->addIndex(['chosen_inline_result_id'], 'idx_tu_chosen_inline_result_id');
        $t->addIndex(['callback_query_id'], 'idx_tu_callback_query_id');
        $t->addIndex(['shipping_query_id'], 'idx_tu_shipping_query_id');
        $t->addIndex(['pre_checkout_query_id'], 'idx_tu_pre_checkout_query_id');
        $t->addIndex(['poll_id'], 'idx_tu_poll_id');
        $t->addIndex(['poll_answer_poll_id'], 'idx_tu_poll_answer_poll_id');
        $t->addIndex(['my_chat_member_updated_id'], 'idx_tu_my_chat_member_updated_id');
        $t->addIndex(['chat_member_updated_id'], 'idx_tu_chat_member_updated_id');
        $t->addIndex(['chat_join_request_id'], 'idx_tu_chat_join_request_id');

        $t->addForeignKeyConstraint('message', ['chat_id','message_id'], ['chat_id','id'], [], 'fk_tu_message');
        $t->addForeignKeyConstraint('edited_message', ['edited_message_id'], ['id'], [], 'fk_tu_edited_message');
        $t->addForeignKeyConstraint('message', ['chat_id','channel_post_id'], ['chat_id','id'], [], 'fk_tu_channel_post');
        $t->addForeignKeyConstraint('edited_message', ['edited_channel_post_id'], ['id'], [], 'fk_tu_edited_channel_post');
        $t->addForeignKeyConstraint('inline_query', ['inline_query_id'], ['id'], [], 'fk_tu_inline_query');
        $t->addForeignKeyConstraint('chosen_inline_result', ['chosen_inline_result_id'], ['id'], [], 'fk_tu_chosen_inline_result');
        $t->addForeignKeyConstraint('callback_query', ['callback_query_id'], ['id'], [], 'fk_tu_callback_query');
        $t->addForeignKeyConstraint('shipping_query', ['shipping_query_id'], ['id'], [], 'fk_tu_shipping_query');
        $t->addForeignKeyConstraint('pre_checkout_query', ['pre_checkout_query_id'], ['id'], [], 'fk_tu_pre_checkout_query');
        $t->addForeignKeyConstraint('poll', ['poll_id'], ['id'], [], 'fk_tu_poll');
        $t->addForeignKeyConstraint('poll_answer', ['poll_answer_poll_id'], ['poll_id'], [], 'fk_tu_poll_answer');
        $t->addForeignKeyConstraint('chat_member_updated', ['my_chat_member_updated_id'], ['id'], [], 'fk_tu_my_cmu');
        $t->addForeignKeyConstraint('chat_member_updated', ['chat_member_updated_id'], ['id'], [], 'fk_tu_cmu');
        $t->addForeignKeyConstraint('chat_join_request', ['chat_join_request_id'], ['id'], [], 'fk_tu_cjr');

        // conversation
        $t = $schema->createTable('conversation');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn('user_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('chat_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('status', Types::STRING, [
            'length' => 32,
            'default' => 'active',
            'notnull' => false
        ]);
        $t->addColumn('command', Types::STRING, ['length' => 160, 'default' => '']);
        $t->addColumn('notes', Types::TEXT, ['notnull' => false]);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->addColumn('updated_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['id']);
        $t->addIndex(['user_id'], 'idx_conv_user');
        $t->addIndex(['chat_id'], 'idx_conv_chat');
        $t->addIndex(['status'], 'idx_conv_status');
        $t->addForeignKeyConstraint('user', ['user_id'], ['id'], [], 'fk_conv_user');
        $t->addForeignKeyConstraint('chat', ['chat_id'], ['id'], [], 'fk_conv_chat');

        // request_limiter
        $t = $schema->createTable('request_limiter');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn('chat_id', Types::STRING, ['length' => 255, 'fixed' => true, 'notnull' => false]);
        $t->addColumn('inline_message_id', Types::STRING, ['length' => 255, 'fixed' => true, 'notnull' => false]);
        $t->addColumn('method', Types::STRING, ['length' => 255, 'fixed' => true, 'notnull' => false]);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['id']);







        $t = $schema->createTable('martin_conversation');
        $this->mysqlOptions($t);
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn('user_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('chat_id', Types::BIGINT, ['unsigned' => true, 'notnull' => false]);
        $t->addColumn('handler', Types::STRING, ['length' => 160, 'default' => '']);
        $t->addColumn('status', Types::STRING, [
            'length' => 32,
            'default' => 'active',
            'notnull' => false
        ]);
        $t->addColumn('state', Types::STRING, [
            'length' => 64,
            'notnull' => false
        ]);
        $t->addColumn('created_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->addColumn('updated_at', Types::DATETIME_IMMUTABLE, ['notnull' => false]);
        $t->setPrimaryKey(['id']);
        $t->addIndex(['user_id'], 'idx_mart_conv_user');
        $t->addIndex(['chat_id'], 'idx_mart_conv_chat');
        $t->addIndex(['status'], 'idx_mart_conv_status');
        $t->addForeignKeyConstraint('user', ['user_id'], ['id'], [], 'fk_mart_conv_user');
        $t->addForeignKeyConstraint('chat', ['chat_id'], ['id'], [], 'fk_mart_conv_chat');





        $t = $schema->createTable('user_student_house_info');
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn(
            'user_id',
            Types::BIGINT,
            ['unsigned' => true, 'comment' => 'Unique user identifier']
        );
        $t->addColumn(
            'room_number',
            Types::SMALLINT,
            ['notnull' => true]
        );
        $t->addColumn(
            'name',
            Types::STRING,
            ['length' => 255, 'notnull' => false]
        );
        $t->addColumn(
            'surname',
            Types::STRING,
            ['length' => 255, 'notnull' => true]
        );
        $t->addForeignKeyConstraint(
            'user', ['user_id'], ['id'],
            ['onDelete' => 'CASCADE', 'onUpdate' => 'CASCADE'],
            'fk_user_user_student_house_info'
        );
        $t->setPrimaryKey(['id']);
        $t->addUniqueConstraint(['user_id']);


        $t = $schema->createTable('application_state');
        $t->addColumn('id', Types::SMALLINT, ['autoincrement' => true]);
        $t->addColumn('title', Types::STRING, ['length' => 255]);
        $t->setPrimaryKey(['id']);


        $t = $schema->createTable('mac_application');
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn(
            'is_processed',
            Types::BOOLEAN,
            [
                'default' => false
            ]
        );
        $t->addColumn(
            'conversation_id',
            Types::BIGINT,
            ['unsigned' => true]
        );
        $t->addColumn(
            'application_text',
            Types::TEXT,
            [
                'notnull' => false
            ]
        );
        $t->addForeignKeyConstraint(
            'martin_conversation', ['conversation_id'], ['id'],
            ['onDelete' => 'CASCADE', 'onUpdate' => 'CASCADE'],
            'fk_martin_conversation_mac_application'
        );
        $t->setPrimaryKey(['id']);

        $t = $schema->createTable('payment_application');
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn(
            'is_processed',
            Types::BOOLEAN,
            [
                'default' => false
            ]
        );
        $t->addColumn(
            'conversation_id',
            Types::BIGINT,
            ['unsigned' => true]
        );
        $t->addColumn(
            'file_id',
            Types::STRING,
            [
                'length' => 255,
                'notnull' => false
            ]
        );
        $t->addForeignKeyConstraint(
            'martin_conversation', ['conversation_id'], ['id'],
            ['onDelete' => 'CASCADE', 'onUpdate' => 'CASCADE'],
            'fk_martin_conversation_payment_application'
        );
        $t->setPrimaryKey(['id']);


        $t = $schema->createTable('conversation_request_form');
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn(
            'conversation_id',
            Types::BIGINT,
            ['unsigned' => true, 'comment' => 'Unique conversation identifier']
        );
        $t->addColumn(
            'room_number',
            Types::SMALLINT,
            ['notnull' => false]
        );
        $t->addColumn(
            'name',
            Types::STRING,
            ['length' => 255, 'notnull' => false]
        );
        $t->addColumn(
            'surname',
            Types::STRING,
            ['length' => 255, 'notnull' => false]
        );
        $t->addForeignKeyConstraint(
            'martin_conversation', ['conversation_id'], ['id'],
            ['onDelete' => 'CASCADE', 'onUpdate' => 'CASCADE'],
            'fk_conversation_martin_conversation_request_form'
        );
        $t->addUniqueConstraint(['conversation_id']);
        $t->setPrimaryKey(['id']);

        $t = $schema->createTable('martin_ticket');
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn(
            'is_processed',
            Types::BOOLEAN,
            [
                'default' => false
            ]
        );
        $t->addColumn(
            'conversation_id',
            Types::BIGINT,
            ['unsigned' => true]
        );
        $t->addColumn(
            'content',
            Types::TEXT,
            [
                'notnull' => false
            ]
        );
        $t->addColumn('application_state_id', Types::SMALLINT, [
            'notnull' => false,
        ]);
        $t->addForeignKeyConstraint(
            'martin_conversation', ['conversation_id'], ['id'],
            ['onDelete' => 'CASCADE', 'onUpdate' => 'CASCADE'],
            'fk_conversation_martin_tickets'
        );
        $t->addForeignKeyConstraint(
            'application_state', ['application_state_id'], ['id'],
            ['onDelete' => 'SET NULL', 'onUpdate' => 'CASCADE'],
            'fk_application_state_martin_ticket'
        );
        $t->setPrimaryKey(['id']);


        $t = $schema->createTable('admin_message');
        $t->addColumn('id', Types::BIGINT, ['unsigned' => true, 'autoincrement' => true]);
        $t->addColumn(
            'conversation_id',
            Types::BIGINT,
            ['unsigned' => true]
        );
        $t->addColumn(
            'content',
            Types::TEXT,
            [
                'notnull' => false
            ]
        );
        $t->addForeignKeyConstraint(
            'martin_conversation', ['conversation_id'], ['id'],
            ['onDelete' => 'CASCADE', 'onUpdate' => 'CASCADE'],
            'fk_conversation_admin_message'
        );
        $t->setPrimaryKey(['id']);

    }

    public function down(Schema $schema): void
    {
        foreach ([
             'request_limiter',
             'user_student_house_info',
             'mac_application',
             'payment_application',
             'admin_message',
             'martin_ticket',
             'conversation_request_form',
             'conversation',
             'martin_conversation',
             'telegram_update',
             'chat_boost_removed',
             'chat_boost_updated',
             'chat_join_request',
             'chat_member_updated',
             'poll_answer',
             'poll',
             'pre_checkout_query',
             'shipping_query',
             'callback_query',
             'edited_message',
             'message',
             'chosen_inline_result',
             'inline_query',
             'message_reaction_count',
             'message_reaction',
             'user_chat',
             'chat',
             'user',
        ] as $table) {
            if ($schema->hasTable($table)) {
                $schema->dropTable($table);
            }
        }
    }

    private function mysqlOptions(Table $t): void
    {
        $t->addOption('engine',  'InnoDB');
        $t->addOption('charset', 'utf8mb4');
        $t->addOption('collate', 'utf8mb4_unicode_520_ci');
    }
};
