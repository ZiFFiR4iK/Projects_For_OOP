<?php

namespace App\Telegram\Handlers\Admin;

use App\Config;
use App\Telegram\Commands\MartinCommand\MartinSystemCommand;
use App\Telegram\Conversations\Admin\ViewHelpdeskTicketConversation;
use App\Telegram\Handlers\Actions\Admin\BackToAdminMenuAction;
use App\Telegram\Handlers\Actions\Admin\CancelledAction;
use App\Telegram\Handlers\Actions\Admin\HelpdeskTicket\ChangeStatusHelpdeskTicketAction;
use App\Telegram\Handlers\Actions\Admin\HelpdeskTicket\ReplyHelpdeskTicketAction;
use App\Telegram\Handlers\Actions\Admin\HelpdeskTicket\ViewHelpdeskTicketAction;
use App\Telegram\Handlers\Actions\FinishedAction;
use App\Telegram\Handlers\BaseMartinBotConversationHandler;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Request;

class ViewHelpdeskTicketHandler extends BaseMartinBotConversationHandler
{
    public static string $name = 'view-helpdesk-ticket-handler';

    public function __construct(MartinSystemCommand $command)
    {
        parent::__construct($command);

        $actions = [
            'admin_menu' => BackToAdminMenuAction::class,
            'input_ticket_number' => ViewHelpdeskTicketAction::class,
            'reply_ticket' => ReplyHelpdeskTicketAction::class,
            'change_ticket_status' => ChangeStatusHelpdeskTicketAction::class,
            'finished' => FinishedAction::class,
            'handler_cancelled' => CancelledAction::class,
            'cancelled' => \App\Telegram\Handlers\Actions\CancelledAction::class,
        ];

        $this->actions = array_merge($this->actions, $actions);

        $config = Config::get('telegram.state_machine.view_helpdesk_ticket');

        $this->loadConversation(
            ViewHelpdeskTicketConversation::class,
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
