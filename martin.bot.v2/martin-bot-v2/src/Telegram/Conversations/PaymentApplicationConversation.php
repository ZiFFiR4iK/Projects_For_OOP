<?php

namespace App\Telegram\Conversations;

use App\Telegram\Db\ApplicationDB;
use App\Telegram\Db\ConversationRequestForm;
use App\Telegram\Db\MacApplication;
use App\Telegram\Db\PaymentApplication;

class PaymentApplicationConversation extends MartinApplicationConversation
{
    public function createMacApplicationIfNotExists(): void
    {
        if (! PaymentApplication::exists($this)) {
            PaymentApplication::create($this);
        }
    }

    public function removeContext(): void
    {
        ConversationRequestForm::delete($this);
        PaymentApplication::delete($this);
    }

    public function setApplicationState(string $state): void
    {
        $applicationState = ApplicationDB::getOrCreateApplicationState($state);

        PaymentApplication::updateByFields($this, [
            'application_state_id' => $applicationState->id
        ]);
    }
    public function getApplicationId(): int
    {

        return PaymentApplication::get($this)['id'];
    }

    public function buildNotificationMessage(array $userData): string
    {
        $paymentApplication = PaymentApplication::get($this);

        return "❗ Создана заявка №{$paymentApplication['id']} на оплату от "
            . "{$userData['name']} {$userData['surname']} комната №{$userData['room_number']}";
    }
}