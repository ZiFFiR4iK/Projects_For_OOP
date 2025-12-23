<?php

namespace App\Telegram\Db;

use App\DB;
use App\Telegram\Conversations\MartinConversation;
use App\Telegram\Exception\MartinBotException;
use App\Telegram\Exception\PaymentApplicationException;

class HelpDeskApplicationDB extends ApplicationDB
{
    public static string $table = 'martin_ticket';

    public static function get(MartinConversation $conversation): array
    {
        $helpdesk = static::fetchOne($conversation);

        if (!$helpdesk) {
            throw new MartinBotException('Сбой сервера. Не найдена заявка на новое сообщение о проблеме');
        }

        return $helpdesk;
    }

    public static function saveContent(MartinConversation $conversation, string $content): void
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

    public static function getByIdForAdmin(int $id): array
    {
        $connection = DB::getConnection();

        $application = $connection->createQueryBuilder()
            ->select('t.*', 'crf.name', 'crf.surname', 'crf.room_number', 'a.title AS status')
            ->from(static::$table, 't')
            ->innerJoin('t', 'application_state', 'a', 't.application_state_id = a.id')
            ->innerJoin('t', 'martin_conversation', 'c', 't.conversation_id = c.id')
            ->innerJoin('c', 'conversation_request_form', 'crf', 'c.id = crf.conversation_id')
            ->where('t.id = :id')
            ->setParameter('id', $id)
            ->fetchAssociative();

        if (! $application) {
            throw new MartinBotException('Заявка с указанным номером не найдена');
        }

        return $application;
    }

    public static function getConversationData(int $id): array
    {
        $connection = DB::getConnection();

        $data = $connection->createQueryBuilder()
            ->select('c.id as conversation_id', 'c.chat_id', 'c.user_id')
            ->from(static::$table, 't')
            ->innerJoin('t', 'martin_conversation', 'c', 't.conversation_id = c.id')
            ->where('t.id = :id')
            ->setParameter('id', $id)
            ->fetchAssociative();

        if (! $data) {
            throw new MartinBotException('Не удалось найти диалог для выбранной заявки');
        }

        return $data;
    }

    public static function markProcessed(int $id): void
    {
        $connection = DB::getConnection();

        $connection->createQueryBuilder()
            ->update(static::$table)
            ->set('is_processed', ':processed')
            ->where('id = :id')
            ->setParameter('processed', true)
            ->setParameter('id', $id)
            ->executeStatement();
    }

    public static function updateStatus(int $id, string $status): void
    {
        $connection = DB::getConnection();
        $state = static::getOrCreateApplicationState($status);

        $connection->createQueryBuilder()
            ->update(static::$table)
            ->set('application_state_id', ':state')
            ->where('id = :id')
            ->setParameter('state', $state->id)
            ->setParameter('id', $id)
            ->executeStatement();
    }
}
