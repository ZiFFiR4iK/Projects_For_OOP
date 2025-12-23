<?php

namespace App\Telegram\Conversations;

use App\Telegram\Db\ApplicationDB;
use App\Telegram\Db\ConversationRequestForm;
use App\Telegram\Db\MacApplication;
use Longman\TelegramBot\Conversation;

class MacApplicationConversation extends MartinApplicationConversation
{
    public function createMacApplicationIfNotExists(): void
    {
        if (! MacApplication::exists($this)) {
            MacApplication::create($this);
        }
    }

    public function removeContext(): void
    {
        ConversationRequestForm::delete($this);
        MacApplication::delete($this);
    }

    public function getApplicationId(): int
    {
        return MacApplication::get($this)['id'];
    }

    public function setApplicationState(string $state): void
    {
        $applicationState = ApplicationDB::getOrCreateApplicationState($state);

        MacApplication::updateByFields($this, [
            'application_state_id' => $applicationState->id
        ]);
    }

    public function buildNotificationMessage(array $userData): string
    {
        $macApplication = MacApplication::get($this);

        return "❗ Создана заявка №{$macApplication['id']} на добавление МАК-адресов от "
        . "{$userData['name']} {$userData['surname']} комната №{$userData['room_number']}";
    }
}