<?php

namespace App\Telegram\Handlers\Actions\Applications;

use App\Telegram\Handlers\Actions\BaseMartinBotConversationAction;
use App\Telegram\Handlers\ApplicationHandler\MartinBotApplicationHandler;
use App\Telegram\Handlers\BaseMartinBotConversationHandler;
use InvalidArgumentException;

abstract class ApplicationAction extends BaseMartinBotConversationAction
{
    public function __construct(
        protected BaseMartinBotConversationHandler $handler
    )
    {
        if (!$handler instanceof MartinBotApplicationHandler) {
            throw new InvalidArgumentException(
                'ApplicationAction requires MartinBotApplicationHandler'
            );
        }
        parent::__construct($handler);
    }

    public function getHandler(): MartinBotApplicationHandler
    {
        return $this->handler;
    }
}