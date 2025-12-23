<?php

namespace App\Telegram\Handlers\Actions\Instructions;

use App\Telegram\Enums\MartinButtonMessages;
use App\Telegram\Handlers\Actions\BaseMartinBotConversationAction;
use Longman\TelegramBot\Entities\Message;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Request;

class StartAction extends BaseMartinBotConversationAction
{

    public function handle(Message $message): ?ServerResponse
    {
        return $this->makeInitialDialogResponse();
    }

    private function makeInitialDialogResponse(): ServerResponse
    {
        return Request::sendMessage(
            $this->buildResponseData(
                $this->map[$this->getHandler()::class] ?? 'Продолжить?',
                [
                    [MartinButtonMessages::BACK, MartinButtonMessages::FORWARD]
                ]
            )
        );
    }

    public function transitions(): array
    {
        return [
            MartinButtonMessages::BACK->value           => 'to_cancelled',
            MartinButtonMessages::FORWARD->value        => 'to_show_instructions',
        ];
    }
}