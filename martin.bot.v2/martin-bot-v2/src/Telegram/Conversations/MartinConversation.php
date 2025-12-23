<?php

namespace App\Telegram\Conversations;

use App\Telegram\Db\MartinBotAdmin;
use App\Telegram\Db\MartinConversationDB;
use iter\IterFnTest;
use Longman\TelegramBot\Conversation;
use Longman\TelegramBot\ConversationDB;
use Longman\TelegramBot\Request;

class MartinConversation extends Conversation
{
    public ?string $state = null;

    /**
     * Command to be executed if the conversation is active
     *
     * @var string
     */
    protected string $handler;

    public function setHandler(string $handler): MartinConversation
    {
        $this->handler = $handler;
        return $this;
    }

    protected function start(): bool
    {
        if (
            $this->command
            && !$this->exists()
            && MartinConversationDB::insertConversation(
                $this->user_id,
                $this->chat_id,
                $this->command
            )
        ) {
            return $this->load();
        }

        return false;
    }


    public function getState(): ?string
    {
        return $this->state;
    }
    public function setState(?string $state): void
    {
        $this->state = $state;
    }


    public function persistState(): void
    {
        if ($this->exists()) {
            $fields = ['state' => $this->getState()];
            $where  = [
                'id'      => $this->conversation['id'],
                'status'  => 'active',
                'user_id' => $this->user_id,
                'chat_id' => $this->chat_id,
            ];

            MartinConversationDB::updateConversation($fields, $where);
        }
    }

    protected function load(): bool
    {
        //Select an active conversation
        $conversation = MartinConversationDB::selectConversation($this->user_id, $this->chat_id, 1);
        if (isset($conversation[0])) {
            //Pick only the first element
            $this->conversation = $conversation[0];
            $this->setState($conversation[0]['state']);
            //Load the command from the conversation if it hasn't been passed
            $this->command = $this->command ?: $this->conversation['handler'];

            if ($this->command !== $this->conversation['handler']) {
                $this->cancel();
                return false;
            }
        }

        return $this->exists();
    }

    protected function updateStatus(string $status): bool
    {
        if ($this->exists()) {
            $fields = ['status' => $status];
            $where  = [
                'id'      => $this->conversation['id'],
                'status'  => 'active',
                'user_id' => $this->user_id,
                'chat_id' => $this->chat_id,
            ];
            MartinConversationDB::updateConversation($fields, $where);

            return true;
        }

        return false;
    }
    public function update(): bool
    {
        return true;
    }

    public function sendMessage(string $message): void
    {

        Request::sendMessage([
            'chat_id' => $this->getChatId(),
            'text' => $message
        ]);
    }

    public function getId(): int
    {
        return $this->conversation['id'];
    }

    public function sendMessageToAdmins(string $message): void
    {
        $admins = MartinBotAdmin::get();

        foreach ($admins as $admin) {
            Request::sendMessage([
                'chat_id' => $admin['chat_id'],
                'text' => $message
            ]);
        }
    }


}