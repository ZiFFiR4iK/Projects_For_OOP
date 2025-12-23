<?php

namespace App\Telegram\Handlers\Actions\ApplicationStatus;

use App\Telegram\Commands\MartinBotCommandConversation;
use App\Telegram\Enums\MartinButtonMessages;
use App\Telegram\Handlers\Actions\BaseMartinBotConversationAction;
use App\Telegram\Handlers\MartinBotConversationHandler;
use App\Validation\Validator;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Request;

abstract class ApplicationStatusAction extends BaseMartinBotConversationAction
{
    protected ?Validator $validator;
    public function __construct(MartinBotConversationHandler $handler)
    {
        parent::__construct($handler);

        $this->addTransitions([
            MartinButtonMessages::CANCEL->value     => 'to_cancelled',
            MartinButtonMessages::BACK->value       => 'to_start',
        ]);
    }
    protected function askApplicationNumberResponse(string $message): ServerResponse
    {
        return Request::sendMessage(
            $this->buildResponseData(
                $message,
                [
                    [MartinButtonMessages::BACK, MartinButtonMessages::CANCEL],
                ]
            )
        );
    }

    protected function isValid(string $number): bool
    {
        return $this->validator->validateField('number', $number, 'required|int|min:1');
    }

    protected function createValidator(): void
    {
        $this->validator = new Validator();
    }
}