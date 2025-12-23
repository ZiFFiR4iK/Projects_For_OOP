<?php

namespace App\Telegram\Db;

use App\DB;
use App\Telegram\Conversations\MartinConversation;
use App\Telegram\Exception\MartinBotException;
use App\Telegram\Exception\PaymentApplicationException;

class PaymentApplication extends ApplicationDB
{
    public static string $table = 'payment_application';



    public static function get(MartinConversation $conversation): array
    {
        $paymentApplication = static::fetchOne($conversation);

        if (!$paymentApplication) {
            throw new PaymentApplicationException('Сбой сервера. Не найдена заявка на оплату');
        }

        return $paymentApplication;
    }


    public static function saveFileId(MartinConversation $conversation, string $fileId): void
    {
        $connection = DB::getConnection();

        $connection->createQueryBuilder()
            ->update(static::$table)
            ->set('file_id', ':file_id')
            ->where('conversation_id = :conversation_id')
            ->setParameter('conversation_id', $conversation->getId())
            ->setParameter('file_id', $fileId)
            ->executeStatement();
    }
}