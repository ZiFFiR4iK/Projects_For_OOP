<?php

namespace App\Telegram\Handlers\Actions\ApplicationStatus;

use App\Telegram\Db\ApplicationDB;
use App\Telegram\Db\HelpDeskApplicationDB;
use App\Telegram\Db\MacApplication;
use App\Telegram\Enums\ApplicationState;
use App\Telegram\Enums\MartinButtonMessages;
use Longman\TelegramBot\Entities\Message;
use Longman\TelegramBot\Entities\ServerResponse;

class CheckHelpDeskTicketApplicationStatus extends ApplicationStatusAction
{
    public function handle(Message $message): ?ServerResponse
    {
        $text = $this->textMessage($message);

        if ($text) {
            return $this->handleInputApplicationNumber($text);
        }

        return $this->askApplicationNumberResponse('Введите номер заявки: ');
    }

    private function handleInputApplicationNumber(string $number): ServerResponse
    {
        $this->createValidator();

        if ($this->isValid($number)) {
            $application = HelpDeskApplicationDB::getById($this->getHandler()->getConversation(), $number);
            $message = $this->createMessage($application);

            return $this->sendMessage($message, [
                [MartinButtonMessages::FORWARD],
                [MartinButtonMessages::BACK, MartinButtonMessages::CANCEL]
            ]);
        } else {
            return $this->askApplicationNumberResponse($this->validator->errorsAsString());
        }
    }

    private function createMessage(array $application): string
    {
        $stateText = $application['is_processed']
            ? "✅ Обработана"
            : "⌛ Не обработана";

        $map = [
            ApplicationState::APPLICATION_CREATED->value => 'Создана',
            ApplicationState::APPLICATION_ACCEPTED->value => 'Принята',
            ApplicationState::APPLICATION_REJECTED->value => 'Отменена',
        ];
        $statusText = $map[$application['status']];

        return "📝 *Статус заявки*\n"
            . "━━━━━━━━━━━━━━\n"
            . "📄 Номер: {$application['id']}\n"
            . "🗂 Состояние: {$stateText}\n"
            . "🟢 Статус: {$statusText}\n"
            . "━━━━━━━━━━━━━━\n"
            . "👤 Имя: {$application['name']}\n"
            . "👤 Фамилия: {$application['surname']}\n"
            . "🏠 Комната: {$application['room_number']}\n"
            . "━━━━━━━━━━━━━━\n"
            . "🎫 Содержание тикета:\n{$application['content']}";
    }

    public function transitions(): array
    {
        return [
            MartinButtonMessages::FORWARD->value => 'to_finished',
        ];
    }
}