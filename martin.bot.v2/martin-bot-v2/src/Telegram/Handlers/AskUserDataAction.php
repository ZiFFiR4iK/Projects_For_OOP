<?php

namespace App\Telegram\Handlers\Actions\Applications;

use App\Telegram\Commands\ApplicationHandler\MartinBotApplicationCommandConversation;
use App\Telegram\Db\ConversationRequestForm;
use App\Telegram\Db\UserStudentHouseInfo;
use App\Telegram\Enums\MartinButtonMessages;
use App\Telegram\Handlers\ApplicationHandler\MartinBotApplicationHandler;
use App\Validation\Validator;
use Longman\TelegramBot\Entities\Message;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Request;

class AskUserDataAction extends ApplicationAction
{
    public function handle(Message $message): ?ServerResponse
    {
        $text = $this->textMessage($message);

        if ($text === MartinButtonMessages::IMPORT_USER_DATA->value) {
            return $this->handleImportUserDataAction();
        }

        return $this->respondAskUserData('Как заполнить данные?');
    }

    private function handleImportUserDataAction(): ServerResponse
    {
        $user = $this->importUserData($this->getHandler()->getConversation()->getUserId());

        if (!$user) {
            return $this->respondAskUserData('Не удалось импортировать пользователя');
        }

        if (!$this->isImportedUserValid($user)) {
            return $this->respondAskUserData('Не удалось импортировать пользователя. Невалидные значения');
        }

        ConversationRequestForm::onloadUser($this->getHandler()->getConversation(), $user);

        return $this->getHandler()->transition('to_ask_macs');
    }

    private function isImportedUserValid(array $user): bool
    {
        return (new Validator())->validate($user, [
            'name'        => 'required|string',
            'surname'     => 'required|string',
            'room_number' => 'required|int|min:1|max:255',
        ]);
    }

    private function importUserData(int $userId): array
    {
        return UserStudentHouseInfo::get($userId);
    }

    private function respondAskUserData(string $message): ServerResponse
    {
        $this->setPersistedFormDataForConversation();

        return $this->makeAskUserDataResponse($message);
    }

    private function setPersistedFormDataForConversation(): void
    {
        if (! ConversationRequestForm::exists($this->getHandler()->getConversation())) {
            ConversationRequestForm::create(($this->getHandler()->getConversation()));
        } else {
            ConversationRequestForm::clear(($this->getHandler()->getConversation()));
        };
    }

    private function makeAskUserDataResponse(string $message): ServerResponse
    {
        return Request::sendMessage(
            $this->buildResponseData(
                $message,
                [
                    [MartinButtonMessages::MANUAL_INPUT],
                    [MartinButtonMessages::IMPORT_USER_DATA],
                    [MartinButtonMessages::BACK, MartinButtonMessages::CANCEL]
                ]
            )
        );
    }

    public function transitions(): array
    {
        return [
            MartinButtonMessages::BACK->value         => 'to_start',
            MartinButtonMessages::CANCEL->value       => 'to_cancelled',
            MartinButtonMessages::MANUAL_INPUT->value => 'to_ask_name',
        ];
    }
}