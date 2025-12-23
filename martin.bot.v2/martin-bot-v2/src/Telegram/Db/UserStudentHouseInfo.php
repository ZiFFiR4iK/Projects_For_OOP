<?php

namespace App\Telegram\Db;

use App\DB;

class UserStudentHouseInfo
{
    private static string $table = 'user_student_house_info';
    public static function get(int $userId): array
    {
        $connection = DB::getConnection();

        $userData = $connection->createQueryBuilder()
            ->select('*')
            ->from(static::$table)
            ->where('user_id = :user_id')
            ->setParameter('user_id', $userId)
            ->setMaxResults(1)
            ->fetchOne();

        return $userData ?: [];
    }

}