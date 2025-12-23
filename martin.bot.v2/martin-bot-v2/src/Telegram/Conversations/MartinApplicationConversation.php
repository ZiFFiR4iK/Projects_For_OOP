<?php

namespace App\Telegram\Conversations;

use App\Telegram\Db\ConversationRequestForm;

abstract class MartinApplicationConversation extends MartinConversation
{
    abstract public function getApplicationId(): int;

    abstract public function setApplicationState(string $state): void;

    public function afterFinish(): void
    {
        $userData = ConversationRequestForm::get($this);

        $this->sendMessageToAdmins($this->buildNotificationMessage($userData));
    }

    abstract public function buildNotificationMessage(array $userData): string;
}