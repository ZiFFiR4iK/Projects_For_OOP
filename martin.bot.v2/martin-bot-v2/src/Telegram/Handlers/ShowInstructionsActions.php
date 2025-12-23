<?php

namespace App\Telegram\Handlers\Actions;

use App\Config;
use App\Telegram\Enums\MartinButtonMessages;
use Longman\TelegramBot\Entities\Message;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Request;

class ShowInstructionsActions extends BaseMartinBotConversationAction
{

    public function handle(Message $message): ?ServerResponse
    {
        $message = $this->textMessage($message);

        return $this->makeResponse($message);
    }

    public function makeResponse(string $message): ServerResponse
    {
        switch ($message) {
            case MartinButtonMessages::SHOW_PAYMENT_DATA->value:
                return $this->sendInstructionsMessage($this->formatRequisites(Config::get('telegram.requisites')));
            case MartinButtonMessages::SEND_CONNECTION_INSTRUCTIONS_FILE->value:
                $this->sendDocument(Config::get('app.kernel_path') . '/storage/Instruction.pdf');

                return $this->sendInstructionsMessage('Отправлен файл с инструкциями по подключению');
            default:
                return $this->sendInstructionsMessage('Список инструкций');
        }
    }

    private function sendInstructionsMessage(string $message): ServerResponse
    {
        return Request::sendMessage(
            $this->buildResponseData(
                $message,
                [
                    [MartinButtonMessages::SHOW_PAYMENT_DATA],
                    [MartinButtonMessages::SEND_CONNECTION_INSTRUCTIONS_FILE],
                    [MartinButtonMessages::BACK, MartinButtonMessages::CANCEL]
                ]
            )
        );
    }

    public function transitions(): array
    {
        return [
            MartinButtonMessages::CANCEL->value     => 'to_cancelled',
            MartinButtonMessages::BACK->value       => 'to_start',
        ];
    }

    private function formatRequisites(array $data): string
    {
        if (empty($data)) {
            return 'Реквизиты не найдены';
        }

        $lines = [];
        $i = 1;
        $count = count($data);

        foreach ($data as $name => $cards) {
            foreach ($cards as $card) {
                if ($count === 1) {
                    $lines[] = "{$name} {$card}";
                } else {
                    $lines[] = "{$i}. {$name} {$card}";
                }
            }
            $i++;
        }

        return implode(PHP_EOL, $lines);
    }
}