<?php

namespace App\Telegram\Db;

use App\Telegram\Conversations\MartinConversation;
use App\Telegram\Exception\MartinBotException;

class AdminHelpdeskMessageDB extends AdminMessageDB
{
    /**
     * Persist the selected ticket id so we can reuse it across steps.
     */
    public static function storeTicketId(MartinConversation $conversation, int $ticketId): void
    {
        $payload = static::getPayload($conversation);
        $payload['ticket_id'] = $ticketId;

        static::upsertConversationContent(
            $conversation,
            json_encode($payload, JSON_THROW_ON_ERROR)
        );
    }

    public static function getTicketData(MartinConversation $conversation): array
    {
        return static::getPayload($conversation, true);
    }

    public static function storeReply(MartinConversation $conversation, string $reply): void
    {
        $payload = static::getPayload($conversation);
        $payload['reply'] = $reply;

        static::upsertConversationContent(
            $conversation,
            json_encode($payload, JSON_THROW_ON_ERROR)
        );
    }

    public static function storeStatus(MartinConversation $conversation, string $status): void
    {
        $payload = static::getPayload($conversation);
        $payload['status'] = $status;

        static::upsertConversationContent(
            $conversation,
            json_encode($payload, JSON_THROW_ON_ERROR)
        );
    }

    private static function getPayload(MartinConversation $conversation, bool $shouldExist = false): array
    {
        $record = static::fetchOne($conversation);

        if (! $record) {
            if ($shouldExist) {
                throw new MartinBotException('Сбой сервера. Контекст тикета не найден');
            }

            return [];
        }

        $raw = (string) ($record['content'] ?? '');
        $payload = $raw ? json_decode($raw, true) : [];

        if (!is_array($payload)) {
            throw new MartinBotException('Сбой сервера. Данные тикета повреждены');
        }

        return $payload;
    }
}
