<?php

namespace App\Telegram\Handlers\SupportHandler;

use App\Config;
use App\Telegram\Commands\MartinCommand\MartinSystemCommand;
use App\Telegram\Conversations\UserInstructionsConversation;
use App\Telegram\Handlers\Actions\Instructions\StartAction;
use App\Telegram\Handlers\Actions\ShowInstructionsActions;
use App\Telegram\Handlers\MartinBotConversationHandler;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Request;

class UserInstructionsConversationHandler extends MartinBotConversationHandler
{

    public static string $name = 'user-instructions-conversation-handler';
    public function __construct(MartinSystemCommand $command)
    {
        parent::__construct($command);

        $actions = [
            'start' => StartAction::class,
            'show_instructions' => ShowInstructionsActions::class,
        ];

        $this->actions = array_merge($this->actions, $actions);

        $config = Config::get('telegram.state_machine.instructions');

        $this->loadConversation(
            UserInstructionsConversation::class,
            $config
        );
        $this->loadStateMachine($config);
    }
    public function handleUpdate(): ServerResponse
    {
        $emptyResponse = Request::emptyResponse();

        return $this->handleConversationAction($this->stateMachine->getState()) ?? $emptyResponse;
    }
}