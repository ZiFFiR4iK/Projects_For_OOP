<?php

namespace App\Telegram\Handlers;

use App\Telegram\Conversations\MartinConversation;

abstract class MartinBotConversationHandler extends BaseMartinBotConversationHandler
{
    /** @return MartinConversation|null */
    public function getConversation(): ?MartinConversation
    {
        /** @var MartinConversation|null */
        return parent::getConversation();
    }
}