<?php

namespace App\Telegram;

use App\Config;
use App\Telegram\Db\MartinConversationDB;
use App\Telegram\Handlers\Admin\AdminConversationsActionsHandler;
use App\Telegram\Handlers\Admin\BroadcastMessageHandler;
use App\Telegram\Handlers\Admin\ViewHelpdeskTicketHandler;
use App\Telegram\Handlers\ApplicationHandler\CheckApplicationStatusConversationHandler;
use App\Telegram\Handlers\ApplicationHandler\MacApplicationConversationHandler;
use App\Telegram\Handlers\ApplicationHandler\PaymentApplicationConversationHandler;
use App\Telegram\Handlers\SupportHandler\HelpdeskTicketConversationHandler;
use App\Telegram\Handlers\SupportHandler\UserInstructionsConversationHandler;
use Longman\TelegramBot\Telegram;

class Martin extends Telegram
{
    public function __construct(string $api_key, string $bot_username = '')
    {
        parent::__construct($api_key, $bot_username);

        $this->initializeMartin();
    }

    public function initializeMartin(): void
    {
        MartinConversationDB::initializeConversation();


        # TODO: scan all available handlers automatically
        Config::set('telegram.handlers', [
            'payment-application-handler' => PaymentApplicationConversationHandler::class,
            'mac-application-handler' => MacApplicationConversationHandler::class,
            'check-status-handler' => CheckApplicationStatusConversationHandler::class,
            HelpdeskTicketConversationHandler::$name => HelpdeskTicketConversationHandler::class,
            AdminConversationsActionsHandler::$name => AdminConversationsActionsHandler::class,
            BroadcastMessageHandler::$name => BroadcastMessageHandler::class,
            ViewHelpdeskTicketHandler::$name => ViewHelpdeskTicketHandler::class,
            UserInstructionsConversationHandler::$name => UserInstructionsConversationHandler::class
        ]);

    }
}
