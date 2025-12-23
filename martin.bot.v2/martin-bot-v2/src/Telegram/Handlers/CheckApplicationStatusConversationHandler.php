<?php

namespace App\Telegram\Handlers\ApplicationHandler;

use App\Config;
use App\Telegram\Conversations\ApplicationStatusConversation;
use App\Telegram\Handlers\Actions\ApplicationStatus\CheckHelpDeskTicketApplicationStatus;
use App\Telegram\Handlers\Actions\ApplicationStatus\CheckMacApplicationStatusAction;
use App\Telegram\Handlers\Actions\ApplicationStatus\CheckPaymentApplicationStatusAction;
use App\Telegram\Handlers\Actions\ApplicationStatus\StartAction;
use App\Telegram\Handlers\Actions\CancelledAction;
use App\Telegram\Handlers\Actions\FinishedAction;
use App\Telegram\Handlers\MartinBotConversationHandler;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Exception\TelegramException;
use Longman\TelegramBot\Request;

class CheckApplicationStatusConversationHandler extends MartinBotConversationHandler
{
    public static string $name = 'check-status-handler';
    /**
     * Main command execution
     *
     * @return ServerResponse
     * @throws TelegramException
     */
    public function handleUpdate(): ServerResponse
    {
        if (! $this->conversation) {
            $config = Config::get('telegram.state_machine.check_application_status');

            $this->loadConversation(
                ApplicationStatusConversation::class,
                $config
            );
            $this->loadStateMachine($config);
        }

        $response = Request::emptyResponse();

        switch ($this->stateMachine->getState()):
            case 'start':
                $response = (new StartAction($this))->getResponse($this->getCommand()->getMessage());

                break;

            case 'check_payment_application':
                $response = (new CheckPaymentApplicationStatusAction($this))->getResponse($this->getCommand()->getMessage());

                break;

            case 'check_mac_application':
                $response = (new CheckMacApplicationStatusAction($this))->getResponse($this->getCommand()->getMessage());

                break;

            case 'check_helpdesk_application':
                $response = (new CheckHelpDeskTicketApplicationStatus($this))->getResponse($this->getCommand()->getMessage());

                break;

            case 'cancelled':
                $this->stopConversation();
                $response = (new CancelledAction($this))->getResponse($this->getCommand()->getMessage());

                break;

            case 'finished':
                $this->stopConversation();
                $response = (new FinishedAction($this))->getResponse($this->getCommand()->getMessage());

                break;

        endswitch;

        return $response;
    }
}