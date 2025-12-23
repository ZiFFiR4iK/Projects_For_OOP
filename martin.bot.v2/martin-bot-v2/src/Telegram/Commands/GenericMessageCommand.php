<?php

namespace App\Telegram\Commands;

use App\Telegram\Commands\MartinCommand\MartinSystemCommand;
use App\Telegram\Conversations\MartinConversation;
use App\Telegram\Enums\MartinButtonMessages;
use App\Telegram\Handlers\Admin\AdminConversationsActionsHandler;
use App\Telegram\Handlers\ApplicationHandler\CheckApplicationStatusConversationHandler;
use App\Telegram\Handlers\ApplicationHandler\MacApplicationConversationHandler;
use App\Telegram\Handlers\ApplicationHandler\PaymentApplicationConversationHandler;
use App\Telegram\Handlers\SupportHandler\HelpdeskTicketConversationHandler;
use App\Telegram\Handlers\SupportHandler\UserInstructionsConversationHandler;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Exception\TelegramException;
use Longman\TelegramBot\Request;

class GenericMessageCommand extends MartinSystemCommand
{
    /**
     * @var string
     */
    protected $name = 'genericmessage';

    /**
     * @var string
     */
    protected $description = 'Handle generic message';

    /**
     * @var string
     */
    protected $version = '1.0.0';

    /**
     * @var bool
     */
    protected $need_mysql = true;

    /**
     * Command execute method if MySQL is required but not available
     *
     * @return ServerResponse
     */
    public function executeNoDb(): ServerResponse
    {
        // Do nothing
        return Request::emptyResponse();
    }

    /**
     * Main command execution
     *
     * @return ServerResponse
     * @throws TelegramException
     */
    public function execute(): ServerResponse
    {
        $message = $this->getMessage();

        $conversation = new MartinConversation(
            $message->getFrom()->getId(),
            $message->getChat()->getId()
        );

        if ($conversation->exists() && $handler = $conversation->getCommand()) {
            return $this->executeHandler($handler);
        }

        switch (trim($message->getText(true))):
            case MartinButtonMessages::MAC_APPLICATION->value;
                return (new MacApplicationConversationHandler($this))->execute();
            case MartinButtonMessages::PAYMENT->value;
                return (new PaymentApplicationConversationHandler($this))->execute();
            case MartinButtonMessages::CHECK_APPLICATION_STATUS->value;
                return (new CheckApplicationStatusConversationHandler($this))->execute();
            case MartinButtonMessages::CREATE_TICKET->value;
                return (new HelpdeskTicketConversationHandler($this))->execute();
            case MartinButtonMessages::SHOW_INSTRUCTIONS->value;
                return (new UserInstructionsConversationHandler($this))->execute();
            case MartinButtonMessages::SHOW_ADMIN_MENU->value;
                if ($this->telegram->isAdmin()) {
                    return (new AdminConversationsActionsHandler($this))->execute();
                }
            default;

        endswitch;


        return Request::emptyResponse();
    }
}