<?php

namespace App\Telegram\Conversations;

use App\Telegram\Db\ApplicationDB;
use App\Telegram\Db\ConversationRequestForm;
use App\Telegram\Db\HelpDeskApplicationDB;
use App\Telegram\Db\MacApplication;
use App\Telegram\Db\PaymentApplication;

class HelpdeskTicketConversation extends MartinApplicationConversation
{
    public function getApplicationId(): int
    {
        return HelpDeskApplicationDB::get($this)['id'];
    }

    public function setApplicationState(string $state): void
    {
        $applicationState = ApplicationDB::getOrCreateApplicationState($state);
        HelpDeskApplicationDB::updateByFields($this, [
            'application_state_id' => $applicationState->id
        ]);
    }

    public function createHelpDeskApplicationIfNotExists(): void
    {
        if (! HelpDeskApplicationDB::exists($this)) {
            HelpDeskApplicationDB::create($this);
        }
    }

    public function removeContext(): void
    {
        ConversationRequestForm::delete($this);
        HelpDeskApplicationDB::delete($this);
    }


    public function buildNotificationMessage(array $userData): string
    {
        $helpdeskApplication = HelpDeskApplicationDB::get($this);

        return "❗ Создана заявка №{$helpdeskApplication['id']} на сообщение о проблеме от "
            . "{$userData['name']} {$userData['surname']} комната №{$userData['room_number']}";
    }
}