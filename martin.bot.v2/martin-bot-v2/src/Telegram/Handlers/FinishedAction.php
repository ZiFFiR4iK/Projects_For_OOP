<?php

namespace App\Telegram\Handlers\Actions;

use App\Telegram\Commands\BaseMartinBotCommandConversation;
use App\Telegram\Enums\MartinButtonMessages;
use App\Telegram\Handlers\BaseMartinBotConversationHandler;
use Longman\TelegramBot\Entities\Message;
use Longman\TelegramBot\Entities\ServerResponse;

class FinishedAction extends BaseMartinBotConversationAction
{
    public function handle(Message $message): ?ServerResponse
    {
        $this->getHandler()->getConversation()->stop();
        return $this->sendMessage('Действие завершено', $this->getHandler()->getCommand()->getMainKeyboard());
    }

    public function transitions(): array
    {
        return [];
    }
}