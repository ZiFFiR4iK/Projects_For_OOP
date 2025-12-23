<?php

namespace App\Telegram\Handlers\Actions\ApplicationStatus;

use App\Telegram\Db\MacApplication;
use App\Telegram\Enums\ApplicationState;
use App\Telegram\Enums\MartinButtonMessages;
use App\Telegram\Handlers\MartinBotConversationHandler;
use Longman\TelegramBot\Entities\Message;
use Longman\TelegramBot\Entities\ServerResponse;

class CheckMacApplicationStatusAction extends ApplicationStatusAction
{
    public function handle(Message $message): ?ServerResponse
    {
        $text = $this->textMessage($message);

        if ($text) {
            return $this->handleInputApplicationNumber($text);
        }

        return $this->askApplicationNumberResponse('Введите номер заявки на МАК: ');
    }

    private function handleInputApplicationNumber(string $number): ServerResponse
    {
        $this->createValidator();

        if ($this->isValid($number)) {
            $macApplication = MacApplication::getById($this->getHandler()->getConversation(), $number);
            $message = $this->createMessage($macApplication);

            return $this->sendMessage($message, [
                [MartinButtonMessages::FORWARD],
                [MartinButtonMessages::BACK, MartinButtonMessages::CANCEL]
            ]);
        } else {
            return $this->askApplicationNumberResponse($this->validator->errorsAsString());
        }
    }

    private function createMessage(array $macApplication): string
    {
        $macList = $this->transformMacApplicationText($macApplication['application_text']);

        $stateText = $macApplication['is_processed']
            ? "✅ Обработана"
            : "⌛ Не обработана";

        $map = [
            ApplicationState::APPLICATION_CREATED->value => 'Создана',
            ApplicationState::APPLICATION_ACCEPTED->value => 'Принята',
            ApplicationState::APPLICATION_REJECTED->value => 'Отменена',
        ];
        $statusText = $map[$macApplication['status']];

        return "📝 *Статус заявки*\n"
            . "━━━━━━━━━━━━━━\n"
            . "📄 Номер: {$macApplication['id']}\n"
            . "🗂 Состояние: {$stateText}\n"
            . "🟢 Статус: {$statusText}\n"
            . "━━━━━━━━━━━━━━\n"
            . "👤 Имя: {$macApplication['name']}\n"
            . "👤 Фамилия: {$macApplication['surname']}\n"
            . "🏠 Комната: {$macApplication['room_number']}\n"
            . "━━━━━━━━━━━━━━\n"
            . "💻 MAC-адреса:\n{$macList}";
    }

    private function transformMacApplicationText(string $macApplicationText): string
    {
        $macs = array_map('trim', explode(';', $macApplicationText));

        $output = "";
        foreach ($macs as $i => $mac) {
            if ($mac === "") continue;
            $output .= ($i + 1) . ". " . $mac . PHP_EOL;
        }

        return $output;
    }

    public function transitions(): array
    {
        return [
            MartinButtonMessages::FORWARD->value => 'to_finished',
        ];
    }
}