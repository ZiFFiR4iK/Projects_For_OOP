<?php

namespace App\Telegram\Handlers\Actions\Applications;

use App\Telegram\Db\ConversationRequestForm;
use App\Telegram\Enums\MartinButtonMessages;
use App\Validation\Validator;
use Longman\TelegramBot\Entities\Message;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Request;

class AskNameAction extends ApplicationAction
{
    private ?Validator $validator;

    public function handle(Message $message): ?ServerResponse
    {
        $text = $this->textMessage($message);
        if ($text) {
            return $this->handleInputNameAction($text);
        }

        return $this->sendAskNameMessageResponse('Введите ваше имя: ');
    }


    private function handleInputNameAction(string $name): ServerResponse
    {
        $this->createValidator();

        if ($this->isValid($name)) {
            ConversationRequestForm::saveName($this->getHandler()->getConversation(), $name);

            return $this->getHandler()->transition('to_ask_surname');
        } else {
            return $this->sendAskNameMessageResponse($this->validator->errorsAsString());
        }
    }

    private function createValidator(): void
    {
        $this->validator = new Validator();
    }

    private function isValid(string $name): bool
    {
        return $this->validator->validateField('name', $name, 'required|string|no_digits|min:2|max:32');
    }

    private function sendAskNameMessageResponse(string $message): ServerResponse
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
            MartinButtonMessages::BACK->value          => 'to_ask_user_data',
            MartinButtonMessages::CANCEL->value        => 'to_cancelled',
        ];
    }
}