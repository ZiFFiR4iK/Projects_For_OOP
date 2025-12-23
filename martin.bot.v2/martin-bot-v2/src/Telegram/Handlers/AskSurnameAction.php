<?php

namespace App\Telegram\Handlers\Actions\Applications;

use App\Telegram\Commands\ApplicationHandler\MartinBotApplicationCommandConversation;
use App\Telegram\Db\ConversationRequestForm;
use App\Telegram\Enums\MartinButtonMessages;
use App\Telegram\Handlers\ApplicationHandler\MartinBotApplicationHandler;
use App\Validation\Validator;
use Longman\TelegramBot\Entities\Message;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Request;

class AskSurnameAction extends ApplicationAction
{
    private ?Validator $validator;
    public function __construct(MartinBotApplicationHandler $handler)
    {
        parent::__construct($handler);

    }

    public function handle(Message $message): ?ServerResponse
    {
        $text = $this->textMessage($message);

        if ($text) {
            return $this->handleInputSurnameAction($text);
        }

        return $this->sendAskSurnameMessageResponse('Введите вашу фамилию: ');
    }


    private function handleInputSurnameAction(string $surname): ServerResponse
    {
        $this->createValidator();

        if ($this->isValid($surname)) {
            ConversationRequestForm::saveSurname($this->getHandler()->getConversation(), $surname);

            return $this->getHandler()->transition('to_ask_room');
        } else {
            return $this->sendAskSurnameMessageResponse($this->validator->errorsAsString());
        }
    }

    private function isValid(string $surname): bool
    {
        return $this->validator->validateField('surname', $surname, 'required|string|no_digits|min:1|max:32');
    }

    private function createValidator(): void
    {
        $this->validator = new Validator();
    }

    private function sendAskSurnameMessageResponse(string $message): ServerResponse
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
            MartinButtonMessages::BACK->value          => 'to_ask_name',
            MartinButtonMessages::CANCEL->value        => 'to_cancelled',
        ];
    }
}