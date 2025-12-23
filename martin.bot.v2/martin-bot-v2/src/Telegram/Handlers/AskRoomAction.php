<?php

namespace App\Telegram\Handlers\Actions\Applications;

use App\Telegram\Commands\ApplicationHandler\MacApplicationConversationCommand;
use App\Telegram\Commands\ApplicationHandler\MartinBotApplicationCommandConversation;
use App\Telegram\Commands\ApplicationHandler\PaymentApplicationConversationCommand;
use App\Telegram\Db\ConversationRequestForm;
use App\Telegram\Enums\MartinButtonMessages;
use App\Telegram\Handlers\ApplicationHandler\MacApplicationConversationHandler;
use App\Telegram\Handlers\ApplicationHandler\MartinBotApplicationHandler;
use App\Telegram\Handlers\ApplicationHandler\PaymentApplicationConversationHandler;
use App\Telegram\Handlers\SupportHandler\HelpdeskTicketConversationHandler;
use App\Validation\Validator;
use Longman\TelegramBot\Entities\Message;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Request;

class AskRoomAction extends ApplicationAction
{
    private ?Validator $validator;

    # shitty code
    private array $map = [
        MacApplicationConversationHandler::class     => 'to_ask_macs',
        PaymentApplicationConversationHandler::class => 'to_ask_payment',
        HelpdeskTicketConversationHandler::class    => 'to_ask_content'
    ];

    public function handle(Message $message): ?ServerResponse
    {
        $text = $this->textMessage($message);

        if ($text !== '') {
            return $this->handleInputRoomNumberAction($text);
        }

        return $this->sendAskRoomMessageResponse('Введите вашу комнату: ');
    }


    private function handleInputRoomNumberAction(string $room): ServerResponse
    {
        $this->createValidator();

        if ($this->isValid($room)) {
            ConversationRequestForm::saveRoom($this->getHandler()->getConversation(), $room);

            return $this->getHandler()->transition($this->map[$this->getHandler()::class]);
        } else {
            return $this->sendAskRoomMessageResponse($this->validator->errorsAsString());
        }
    }

    private function createValidator(): void
    {
        $this->validator = new Validator();
    }

    private function isValid(string $room): bool
    {
        return $this->validator->validateField('room', $room, 'required|int|min:0|max:255');
    }

    private function sendAskRoomMessageResponse(string $message): ServerResponse
    {
        return Request::sendMessage(
            $this->buildResponseData(
                $message,
                [
                    [MartinButtonMessages::BACK, MartinButtonMessages::CANCEL]
                ]
            )
        );
    }

    public function transitions(): array
    {
        return [
            MartinButtonMessages::BACK->value          => 'to_ask_surname',
            MartinButtonMessages::CANCEL->value        => 'to_cancelled',
        ];
    }
}