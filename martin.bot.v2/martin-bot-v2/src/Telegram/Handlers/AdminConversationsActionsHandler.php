<?php

namespace App\Telegram\Handlers\Admin;

use App\Config;
use App\Telegram\Commands\MartinCommand\MartinSystemCommand;
use App\Telegram\Conversations\Admin\AdminMenuConversation;
use App\Telegram\Handlers\Actions\Admin\CancelledAction;
use App\Telegram\Handlers\Actions\CancelledAction as GenericCancelAction;
use App\Telegram\Handlers\Actions\Admin\ShowAdminMenuAction;
use App\Telegram\Handlers\Actions\Admin\StartAction;
use App\Telegram\Handlers\BaseMartinBotConversationHandler;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Request;

class AdminConversationsActionsHandler extends BaseMartinBotConversationHandler
{
    public static string $name = 'admin-conversations-actions-handler';
    public function __construct(MartinSystemCommand $command)
    {
        parent::__construct($command);

        $actions = [
            'start' => StartAction::class,
            'admin_menu' => ShowAdminMenuAction::class,
            'handler_cancelled' => CancelledAction::class,
            'cancelled' => GenericCancelAction::class,
        ];
        $this->actions = array_merge($this->actions, $actions);

        $config = Config::get('telegram.state_machine.admin_menu');

        $this->loadConversation(
            AdminMenuConversation::class,
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