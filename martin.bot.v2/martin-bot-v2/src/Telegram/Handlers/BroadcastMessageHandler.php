<?php

namespace App\Telegram\Handlers\Admin;

use App\Config;
use App\Telegram\Commands\MartinCommand\MartinSystemCommand;
use App\Telegram\Conversations\Admin\BroadcastMessageConversation;
use App\Telegram\Handlers\Actions\Admin\BackToAdminMenuAction;
use App\Telegram\Handlers\Actions\Admin\BroadcastMessage\AskMessageContentAction;
use App\Telegram\Handlers\Actions\Admin\BroadcastMessage\SendBroadcastMessageAction;
use App\Telegram\Handlers\Actions\Admin\BroadcastMessage\ShowBroadcastMessageAction;
use App\Telegram\Handlers\Actions\Admin\CancelledAction;
use App\Telegram\Handlers\Actions\FinishedAction;
use App\Telegram\Handlers\BaseMartinBotConversationHandler;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Request;

class BroadcastMessageHandler extends BaseMartinBotConversationHandler
{
    public static string $name = 'broadcast-message-handler';
    public function __construct(MartinSystemCommand $command)
    {
        parent::__construct($command);

        $actions = [
            'admin_menu' => BackToAdminMenuAction::class,
            'input_message' => AskMessageContentAction::class,
            'show_message' => ShowBroadcastMessageAction::class,
            'send_message' => SendBroadcastMessageAction::class,
            'finished' => FinishedAction::class,
            'handler_cancelled' => CancelledAction::class,
            'cancelled' => \App\Telegram\Handlers\Actions\CancelledAction::class
        ];

        $this->actions = array_merge($this->actions, $actions);

        $config = Config::get('telegram.state_machine.broadcast_message');

        $this->loadConversation(
            BroadcastMessageConversation::class,
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