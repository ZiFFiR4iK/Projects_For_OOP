<?php

namespace App\Telegram\Db;

use App\DB;
use App\Telegram\Conversations\MartinConversation;
use App\Telegram\Exception\MacAddressAddException;

class MacApplication extends ApplicationDB
{
    public static string $table = 'mac_application';
    public static function create(MartinConversation $conversation): void
    {
        $connection = DB::getConnection();

        $qb = $connection->createQueryBuilder();

        $qb->insert(static::$table)
            ->setValue('conversation_id', ':conversation_id')
            ->setParameter('conversation_id', $conversation->getId())
            ->executeStatement();
    }

    public static function get(MartinConversation $conversation): array
    {
        $macApplication = static::fetchOne($conversation);

        if (!$macApplication) {
            throw new MacAddressAddException('Сбой сервера. Не найдена заявка на МАК-адрес');
        }

        return $macApplication;
    }

    public static function exists(MartinConversation $conversation): bool
    {
        $isFetched = static::fetchOne($conversation);
        return (!! $isFetched);
    }


    public static function addMac(MartinConversation $conversation, string $mac): void
    {
        $connection = DB::getConnection();

        $current = $connection->createQueryBuilder()
            ->from(static::$table)
            ->select('application_text')
            ->where('conversation_id = :conversation_id')
            ->setParameter('conversation_id', $conversation->getId())
            ->fetchOne();


        $macs = [];
        if ($current !== false && $current !== null) {
            $macs = preg_split('/;\s*/', rtrim((string)$current), -1, PREG_SPLIT_NO_EMPTY);
            $macs = array_map('trim', $macs);
        }

        $macs[] = $mac;
        $macs = array_values(array_unique($macs));

        $updated = implode('; ', $macs);

        $connection->createQueryBuilder()
            ->update(static::$table)
            ->set('application_text', ':application_text')
            ->where('conversation_id = :conversation_id')
            ->setParameter('conversation_id', $conversation->getId())
            ->setParameter('application_text', $updated)
            ->executeStatement();
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