<?php

namespace App\Telegram\Handlers\Actions;

use App\Telegram\Enums\MartinButtonMessages;
use App\Telegram\Handlers\BaseMartinBotConversationHandler;
use Longman\TelegramBot\Entities\Message;
use Longman\TelegramBot\Entities\ServerResponse;

class CancelledAction extends BaseMartinBotConversationAction
{
    public function handle(Message $message): ?ServerResponse
    {
        $this->getHandler()->getConversation()->stop();
        return $this->sendMessage('Действие отменено', $this->getHandler()->getCommand()->getMainKeyboard());
    }

    public function transitions(): array
    {
        return [];
    }
}