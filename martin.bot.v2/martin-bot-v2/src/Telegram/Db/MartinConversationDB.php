<?php

namespace App\Telegram\Db;

use App\DB;
use App\Telegram\Conversations\MartinConversation;
use Exception;
use Longman\TelegramBot\ConversationDB;
use Longman\TelegramBot\Exception\TelegramException;
use PDO;

class MartinConversationDB extends ConversationDB
{
    public static function initializeConversation(): void
    {
        define('TB_CONVERSATION_MARTIN', static::$table_prefix . 'martin_conversation');
    }

    public static function insertConversation(int $user_id, int $chat_id, string $command): bool
    {
        if (!static::isDbConnected()) {
            return false;
        }

        try {
            $sth = static::$pdo->prepare('INSERT INTO `' . TB_CONVERSATION_MARTIN . '`
                (`status`, `user_id`, `chat_id`, `handler`, `created_at`, `updated_at`)
                VALUES
                (:status, :user_id, :chat_id, :handler, :created_at, :updated_at)
            ');

            $date = static::getTimestamp();

            $sth->bindValue(':status', 'active');
            $sth->bindValue(':user_id', $user_id);
            $sth->bindValue(':chat_id', $chat_id);
            $sth->bindValue(':handler', $command);
            $sth->bindValue(':created_at', $date);
            $sth->bindValue(':updated_at', $date);

            return $sth->execute();
        } catch (Exception $e) {
            throw new TelegramException($e->getMessage());
        }
    }

    public static function selectConversation(int $user_id, int $chat_id, $limit = 0): bool|array
    {
        if (!self::isDbConnected()) {
            return false;
        }

        try {
            $sql = '
              SELECT *
              FROM `' . TB_CONVERSATION_MARTIN . '`
              WHERE `status` = :status
                AND `chat_id` = :chat_id
                AND `user_id` = :user_id
            ';

            if ($limit > 0) {
                $sql .= ' LIMIT :limit';
            }

            $sth = self::$pdo->prepare($sql);

            $sth->bindValue(':status', 'active');
            $sth->bindValue(':user_id', $user_id);
            $sth->bindValue(':chat_id', $chat_id);

            if ($limit > 0) {
                $sth->bindValue(':limit', $limit, PDO::PARAM_INT);
            }

            $sth->execute();

            return $sth->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            throw new TelegramException($e->getMessage());
        }
    }

    public static function updateConversation(array $fields_values, array $where_fields_values): void
    {
        // Auto update the update_at field.
        $fields_values['updated_at'] = self::getTimestamp();

        self::update(TB_CONVERSATION_MARTIN, $fields_values, $where_fields_values);
    }

}