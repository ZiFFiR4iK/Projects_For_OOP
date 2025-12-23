<?php

namespace App\Telegram\Handlers\SupportHandler;

use App\Config;
use App\Telegram\Commands\MartinCommand\MartinSystemCommand;
use App\Telegram\Conversations\HelpdeskTicketConversation;
use App\Telegram\Handlers\Actions\Applications\AskNameAction;
use App\Telegram\Handlers\Actions\Applications\AskRoomAction;
use App\Telegram\Handlers\Actions\Applications\AskSurnameAction;
use App\Telegram\Handlers\Actions\Applications\AskUserDataAction;
use App\Telegram\Handlers\Actions\Applications\FinishedAction;
use App\Telegram\Handlers\Actions\Applications\HelpdeskTicket\AskContentTicketAction;
use App\Telegram\Handlers\Actions\Applications\HelpdeskTicket\AskPhotoTicketAction;
use App\Telegram\Handlers\Actions\Applications\HelpdeskTicket\ShowCreatedTicketAction;
use App\Telegram\Handlers\Actions\Applications\StartAction;
use App\Telegram\Handlers\ApplicationHandler\MartinBotApplicationHandler;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Exception\TelegramException;
use Longman\TelegramBot\Request;

class HelpdeskTicketConversationHandler extends MartinBotApplicationHandler
{
    public static string $name = 'helpdesk-ticket-conversation-handler';
    public function __construct(MartinSystemCommand $command)
    {
        parent::__construct($command);

        $actions = [
            'start' => StartAction::class,
            'ask_user_data' => AskUserDataAction::class,
            'ask_name' => AskNameAction::class,
            'ask_surname' => AskSurnameAction::class,
            'ask_room' => AskRoomAction::class,
            'ask_content' => AskContentTicketAction::class,
            'ask_photo' => AskPhotoTicketAction::class,
//            'show_tickets_menu' => ShowTicketsMenuAction::class,
//            'show_all_tickets' => ShowAllTicketsAction::class,
//            'show_one_ticket' => ShowOneTicketAction::class,
            'show_created_ticket' => ShowCreatedTicketAction::class,
            'finished' => FinishedAction::class
        ];

        $this->actions = array_merge($this->actions, $actions);

        $config = Config::get('telegram.state_machine.helpdesk_ticket');

        $this->loadConversation(
            HelpdeskTicketConversation::class,
            $config
        );
        $this->loadStateMachine($config);
    }

    /**
     * Main command execution
     *
     * @return ServerResponse
     * @throws TelegramException
     */
    public function handleUpdate(): ServerResponse
    {
        $emptyResponse = Request::emptyResponse();

        return $this->handleConversationAction($this->stateMachine->getState()) ?? $emptyResponse;
    }
}