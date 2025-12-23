<?php

namespace App\Telegram\Db;

use App\DB;
use App\Telegram\Conversations\MartinConversation;
use App\Telegram\Entities\ApplicationState;
use App\Telegram\Exception\MartinBotException;

class ApplicationDB extends MartinConversationDB
{
    static string $table;

    public static function getById(MartinConversation $conversation, int $id): ?array
    {
        $connection = DB::getConnection();
        $userId = $conversation->getUserId();

        $application = $connection->createQueryBuilder()
            ->select('t.*', 'crf.name', 'crf.surname', 'crf.room_number', 'a.title AS status')
            ->from(static::$table, 't')
            ->innerJoin('t', 'application_state', 'a', 't.application_state_id = a.id')
            ->innerJoin('t', 'martin_conversation', 'c', 't.conversation_id = c.id')
            ->innerJoin('c', 'conversation_request_form', 'crf', 'c.id = crf.conversation_id')
            ->where('t.id = :id')
            ->andWhere('c.user_id = :user_id')
            ->andWhere('c.id')
            ->setParameter('id', $id)
            ->setParameter('user_id', $userId)
            ->fetchAssociative();

        if (!$application) {
            throw new MartinBotException('Ваша заявка с указанными номером не найдена');
        }

        return $application;
    }
    public static function getOrCreateApplicationState(string $state): ApplicationState
    {
        $connection = DB::getConnection();

        $qb = $connection->createQueryBuilder();
        $result = $qb->select('*')
            ->from('application_state')
            ->where('title = :title')
            ->setParameter('title', $state)
            ->fetchAssociative();

        if (! $result) {
            $connection->insert('application_state', [
                'title' => $state,
            ]);

            // Получаем ID только что созданной записи
            $id = (int) $connection->lastInsertId();

            return new ApplicationState($id, $state);
        }

        // Если нашли — возвращаем существующую
        return new ApplicationState(
            (int) $result['id'],
            $result['title']
        );
    }

    public static function updateByFields(MartinConversation $conversation, array $fields)
    {
        $connection = DB::getConnection();

        $qb = $connection->createQueryBuilder()
            ->update(static::$table);

        foreach ($fields as $column => $value) {
            $param = ':' . $column;
            $qb->set($column, $param)
                ->setParameter($column

                    , $value);
        }

        $qb->where('conversation_id = :conversation_id')
            ->setParameter('conversation_id', $conversation->getId());

        $qb->executeStatement();
    }


    protected static function fetchOne(MartinConversation $conversation): array|bool
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

    public static function create(MartinConversation $conversation): void
    {
        $connection = DB::getConnection();

        $qb = $connection->createQueryBuilder();

        $qb->insert(static::$table)
            ->setValue('conversation_id', ':conversation_id')
            ->setParameter('conversation_id', $conversation->getId())
            ->executeStatement();
    }

    public static function exists(MartinConversation $conversation): bool
    {
        $isFetched = static::fetchOne($conversation);
        return (!! $isFetched);
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
}