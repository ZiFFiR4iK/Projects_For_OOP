<?php

namespace App\Telegram\Db;

use App\DB;
use App\Telegram\Conversations\MartinConversation;
use App\Telegram\Exception\MacAddressAddException;
use Exception;

class AdminMessageDB extends ApplicationDB
{
    static string $table = 'admin_message';

    public static function get(MartinConversation $conversation): array
    {
        $adminMessage = static::fetchOne($conversation);

        if (!$adminMessage) {
            throw new MacAddressAddException('Сбой сервера. Не найдено сообщение на МАК-адрес');
        }

        return $adminMessage;
    }

    public static function save(MartinConversation $conversation, string $content): void
    {
        $connection = DB::getConnection();

        $connection->createQueryBuilder()
            ->update(static::$table)
            ->set('content', ':content')
            ->where('conversation_id = :conversation_id')
            ->setParameter('conversation_id', $conversation->getId())
            ->setParameter('content', $content)
            ->executeStatement();
    }

    public static function upsertConversationContent(MartinConversation $conversation, string $content): void
    {
        $connection = DB::getConnection();

        $table = static::$table;
        $conversationId = $conversation->getId();

        try {
            $updated = $connection->createQueryBuilder()
                ->update($table)
                ->set('content', ':content')
                ->where('conversation_id = :conversation_id')
                ->setParameter('conversation_id', $conversationId)
                ->setParameter('content', $content)
                ->executeStatement();

            if ($updated === 0) {
                $connection->createQueryBuilder()
                    ->insert($table)
                    ->values([
                        'conversation_id' => ':conversation_id',
                        'content' => ':content',
                    ])
                    ->setParameter('conversation_id', $conversationId)
                    ->setParameter('content', $content)
                    ->executeStatement();
            }

        } catch (Exception $e) {
            throw new \RuntimeException("Failed to upsert conversation content: " . $e->getMessage(), 0, $e);
        }
    }
}