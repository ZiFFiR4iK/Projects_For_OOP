<?php

namespace App\Telegram\Commands\MartinCommand;

use App\Config;
use App\Telegram\Enums\MartinButtonMessages;
use App\Telegram\Handlers\BaseMartinBotConversationHandler;
use Longman\TelegramBot\Commands\SystemCommand;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Entities\Update;
use Longman\TelegramBot\Telegram;

class MartinSystemCommand extends SystemCommand
{
    protected array $handlers = [];
    public function __construct(Telegram $telegram, ?Update $update = null)
    {
        parent::__construct($telegram, $update);

        $this->handlers = Config::get('telegram.handlers');
    }

    public function executeHandler(string $handlerName): ServerResponse
    {
        /** @var BaseMartinBotConversationHandler $handler */
        $handler = $this->handlers[$handlerName];

        return (new $handler($this))->execute();
    }

    public function getMainKeyboard(): array
    {
        $buttons = [
            [MartinButtonMessages::PAYMENT],
            [MartinButtonMessages::MAC_APPLICATION],
            [MartinButtonMessages::CHECK_APPLICATION_STATUS],
            [MartinButtonMessages::SHOW_INSTRUCTIONS],
            [MartinButtonMessages::CREATE_TICKET]
        ];

        if ($this->telegram->isAdmin()) {
            $buttons = array_merge($buttons, [
                [
                    MartinButtonMessages::SHOW_ADMIN_MENU
                ]
            ]);
        };

        return $buttons;
    }
}