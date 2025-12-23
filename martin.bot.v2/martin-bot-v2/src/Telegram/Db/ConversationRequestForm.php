<?php

namespace App\Telegram\Db;

use App\DB;
use App\Telegram\Conversations\MartinConversation;
use App\Telegram\Exception\ConversationRequestFormException;
use Longman\TelegramBot\Conversation;

class ConversationRequestForm
{
    private static string $table = 'conversation_request_form';

    public static function onloadUser(MartinConversation $conversation, array $user): void
    {
        $connection = DB::getConnection();

        $connection->createQueryBuilder()
            ->update(static::$table)
            ->set('name', ':name')
            ->where('conversation_id = :conversation_id')
            ->setParameter('conversation_id', $conversation->getId())
            ->setParameter('name', $user['name'])
            ->setParameter('name', $user['surname'])
            ->setParameter('name', $user['room_number'])
            ->executeStatement();
    }
    public static function get(MartinConversation $conversation): array
    {
        $conversationRequestForm = static::fetchOne($conversation);
        if (!$conversationRequestForm) {
            throw new ConversationRequestFormException('Сбой сервера. Не найдена форма заполнения данных пользователя');
        }

        return $conversationRequestForm;
    }

    public static function exists(MartinConversation $conversation): bool
    {
        $isFetched = static::fetchOne($conversation);
        return (!! $isFetched);
    }

    private static function fetchOne(MartinConversation $conversation)
    {
        $connection = DB::getConnection();

        return $connection->createQueryBuilder()
            ->select('*')
            ->from(static::$table)
            ->where('conversation_id = :conversation_id')
            ->setParameter('conversation_id', $conversation->getId())
            ->setMaxResults(1)
            ->fetchAssociative();
    }

    public static function delete(MartinConversation $conversation): void
    {
        $connection = DB::getConnection();

        $connection->createQueryBuilder()
            ->delete(static::$table)
            ->where('conversation_id = :conversation_id')
            ->setParameter('conversation_id', $conversation->getId())
            ->executeStatement();
    }

    public static function clear(MartinConversation $conversation): void
    {
        $connection = DB::getConnection();

        $connection->createQueryBuilder()
            ->update(static::$table)
            ->set('name', ':name')
            ->set('surname', ':surname')
            ->set('room_number', ':room_number')
            ->where('conversation_id = :conversation_id')
            ->setParameter('name', null)
            ->setParameter('surname', null)
            ->setParameter('room_number', null)
            ->setParameter('conversation_id', $conversation->getId())
            ->executeStatement();
    }
    public static function create(MartinConversation $conversation): void
    {
        $connection = DB::getConnection();

        $qb = $connection->createQueryBuilder();

        $qb->insert(static::$table)
            ->setValue('conversation_id', ':conversation_id')
            ->setParameter('conversation_id', $conversation->getId())
            ->executeStatement();
    }

    public static function saveName(MartinConversation $conversation, string $name): void
    {
        $connection = DB::getConnection();

        $connection->createQueryBuilder()
            ->update(static::$table)
            ->set('name', ':name')
            ->where('conversation_id = :conversation_id')
            ->setParameter('conversation_id', $conversation->getId())
            ->setParameter('name', $name)
            ->executeStatement();
    }

    public static function saveSurname(MartinConversation $conversation, string $surname): void
    {
        $connection = DB::getConnection();

        $connection->createQueryBuilder()
            ->update(static::$table)
            ->set('surname', ':surname')
            ->where('conversation_id = :conversation_id')
            ->setParameter('conversation_id', $conversation->getId())
            ->setParameter('surname', $surname)
            ->executeStatement();
    }

    public static function saveRoom(MartinConversation $conversation, int $room)
    {
        $connection = DB::getConnection();

        $connection->createQueryBuilder()
            ->update(static::$table)
            ->set('room_number', ':room')
            ->where('conversation_id = :conversation_id')
            ->setParameter('conversation_id', $conversation->getId())
            ->setParameter('room', $room)
            ->executeStatement();
    }
}