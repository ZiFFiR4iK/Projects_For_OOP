<?php

namespace App\Telegram\Db;

use App\DB;

class MartinBotAdmin extends MartinConversationDB
{
    public static string $table = 'martin_admin';
    public static function get(): array
    {
        $connection = DB::getConnection();

        $qb = $connection->createQueryBuilder();

        $result = $qb->select('*')
            ->from(static::$table)
            ->fetchAllAssociative();


        return $result;
    }
}