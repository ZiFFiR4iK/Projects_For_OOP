<?php

namespace App\Telegram\Handlers\ApplicationHandler;

use App\Telegram\Conversations\MartinApplicationConversation;
use App\Telegram\Handlers\BaseMartinBotConversationHandler;

/**
 * @extends BaseMartinBotConversationHandler
 * @phpstan-type T MartinApplicationConversation
 */
abstract class MartinBotApplicationHandler extends BaseMartinBotConversationHandler
{
    /** @return MartinApplicationConversation|null */
    public function getConversation(): ?MartinApplicationConversation
    {
        /** @var MartinApplicationConversation|null */
        return parent::getConversation();
    }

}