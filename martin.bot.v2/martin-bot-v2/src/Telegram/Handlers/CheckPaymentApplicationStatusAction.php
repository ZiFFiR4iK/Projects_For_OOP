<?php

namespace App\Telegram\Handlers\Actions\ApplicationStatus;

use App\Telegram\Commands\MartinBotCommandConversation;
use App\Telegram\Db\PaymentApplication;
use App\Telegram\Enums\ApplicationState;
use App\Telegram\Enums\MartinButtonMessages;
use App\Telegram\Handlers\MartinBotConversationHandler;
use Longman\TelegramBot\Entities\Message;
use Longman\TelegramBot\Entities\ServerResponse;

class CheckPaymentApplicationStatusAction extends ApplicationStatusAction
{
    public function handle(Message $message): ?ServerResponse
    {
        $text = $this->textMessage($message);

        if ($text) {
            return $this->handleInputApplicationNumber($text);
        }

        return $this->askApplicationNumberResponse('Введите номер заявки на оплату: ');
    }

    private function handleInputApplicationNumber(string $number): ServerResponse
    {
        $this->createValidator();

        if ($this->isValid($number)) {
            $paymentApplication = PaymentApplication::getById($this->getHandler()->getConversation(), $number);
            $message = $this->createMessage($paymentApplication);

            if ($paymentApplication['file_id']) {
                $this->sendPhoto($paymentApplication['file_id']);
            }

            return $this->sendMessage($message, [
                [MartinButtonMessages::FORWARD],
                [MartinButtonMessages::BACK, MartinButtonMessages::CANCEL]
            ]);
        } else {
            return $this->askApplicationNumberResponse($this->validator->errorsAsString());
        }
    }

    private function createMessage(array $paymentApplication): string
    {
        $stateText = $paymentApplication['is_processed']
            ? "✅ Обработана"
            : "⌛ Не обработана";

        $map = [
            ApplicationState::APPLICATION_CREATED->value => 'Создана',
            ApplicationState::APPLICATION_ACCEPTED->value => 'Принята',
            ApplicationState::APPLICATION_REJECTED->value => 'Отменена',
        ];
        $statusText = $map[$paymentApplication['status']];

        return "📝 *Статус заявки*\n"
            . "━━━━━━━━━━━━━━\n"
            . "📄 Номер: {$paymentApplication['id']}\n"
            . "🗂 Состояние: {$stateText}\n"
            . "🟢 Статус: {$statusText}\n"
            . "━━━━━━━━━━━━━━\n"
            . "👤 Имя: {$paymentApplication['name']}\n"
            . "👤 Фамилия: {$paymentApplication['surname']}\n"
            . "🏠 Комната: {$paymentApplication['room_number']}\n";
    }

    public function transitions(): array
    {
        return [
            MartinButtonMessages::FORWARD->value => 'to_finished',
        ];
    }
}