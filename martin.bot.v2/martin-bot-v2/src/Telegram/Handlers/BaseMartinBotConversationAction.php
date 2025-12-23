<?php

namespace App\Telegram\Handlers\Actions;

use App\Telegram\Enums\MartinButtonMessages;
use App\Telegram\Exception\MartinBotException;
use App\Telegram\Handlers\BaseMartinBotConversationHandler;
use Longman\TelegramBot\Entities\Message;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Request;

abstract class BaseMartinBotConversationAction
{
    protected array $transitions = [];

    public function __construct(
        protected BaseMartinBotConversationHandler $handler
    )
    {
        $this->transitions = [
            MartinButtonMessages::CANCEL_COMMAND->value => 'to_cancelled',
        ];

        $this->addTransitions($this->transitions());
    }

    public function setHandler(BaseMartinBotConversationHandler $handler): void
    {
        $this->handler = $handler;
    }

    public function getHandler(): BaseMartinBotConversationHandler
    {
        return $this->handler;
    }

    protected function buildResponseData(string $message, array $keyboard = []): array
    {
        return [
            'chat_id' => $this->getHandler()->getConversation()->getChatId(),
            'text' => $message,
            'reply_markup' => json_encode([
                'keyboard' => $keyboard,
                'resize_keyboard' => true,
                'one_time_keyboard' => false,
                'is_persistent'     => true,
            ]),
        ];
    }

    protected function sendDocument(string $downloadPath)
    {
        Request::sendDocument([
            'chat_id' => $this->getHandler()->getConversation()->getChatId(),
            'document' => Request::encodeFile($downloadPath),
        ]);
    }


    protected function handleSimpleTransitions(?MartinButtonMessages $button): ?ServerResponse
    {
        if (!$button) {
            return null;
        }
        if (isset($this->transitions[$button->value])) {
            return $this->getHandler()->transition($this->transitions[$button->value]);
        }

        return null;
    }

    protected function addTransitions(array $transitions): void
    {
        $this->transitions = array_merge($this->transitions, $transitions);
    }

    protected function textMessage(Message $message): string
    {
        if (! $message->getText()) {
            return '';
        }

        return $this->getHandler()->resetText() ? '' : trim($message->getText());
    }

    protected function sendPhoto(string $fileId): ServerResponse
    {
        return Request::sendPhoto([
            'chat_id' => $this->getHandler()->getConversation()->getChatId(),
            'photo' => $fileId,
        ]);
    }
    protected function sendMessage(string $message, array $buttons = []): ServerResponse
    {
        return Request::sendMessage(
            $this->buildResponseData(
                $message,
                $buttons
            )
        );
    }

    public function getResponse(Message $message): ServerResponse
    {
        $text = $this->textMessage($message);
        $button = MartinButtonMessages::tryFrom($text);
        if ($response = $this->handleSimpleTransitions($button)) {
            return $response;
        }

        return $this->handle($message);
    }

    protected function transit(string $transition): ServerResponse
    {
        return $this->getHandler()->transition($transition);
    }
    public function transitions(): array
    {
        return [];
    }
    abstract public function handle(Message $message): ?ServerResponse;
}