<?php

namespace App\Telegram\Handlers\ApplicationHandler;

use App\Config;
use App\Telegram\Conversations\PaymentApplicationConversation;
use App\Telegram\Handlers\Actions\Applications\AskNameAction;
use App\Telegram\Handlers\Actions\Applications\AskRoomAction;
use App\Telegram\Handlers\Actions\Applications\AskSurnameAction;
use App\Telegram\Handlers\Actions\Applications\AskUserDataAction;
use App\Telegram\Handlers\Actions\Applications\FinishedAction;
use App\Telegram\Handlers\Actions\Applications\PaymentApplication\AskPaymentAction;
use App\Telegram\Handlers\Actions\Applications\StartAction;
use App\Telegram\Handlers\Actions\CancelledAction;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Exception\TelegramException;
use Longman\TelegramBot\Request;

class PaymentApplicationConversationHandler extends MartinBotApplicationHandler
{
    public static string $name = 'payment-application-handler';
    /**
     * Main command execution
     *
     * @return ServerResponse
     * @throws TelegramException
     */
    public function handleUpdate(): ServerResponse
    {
        if (! $this->conversation) {
            $config = Config::get('telegram.state_machine.payment_application');

            $this->loadConversation(
                PaymentApplicationConversation::class,
                $config
            );
            $this->loadStateMachine($config);
        }

        $response = Request::emptyResponse();

        switch ($this->stateMachine->getState()):
            case 'start':
                $response = (new StartAction($this))->getResponse($this->getCommand()->getMessage());

                break;

            case 'ask_user_data':
                $response = (new AskUserDataAction($this))->getResponse($this->getCommand()->getMessage());

                break;

            case 'ask_name':
                $response = (new AskNameAction($this))->getResponse($this->getCommand()->getMessage());

                break;

            case 'ask_surname':
                $response = (new AskSurnameAction($this))->getResponse($this->getCommand()->getMessage());

                break;

            case 'ask_room':
                $response = (new AskRoomAction($this))->getResponse($this->getCommand()->getMessage());

                break;

            case 'ask_payment':
                $response = (new AskPaymentAction($this))->getResponse($this->getCommand()->getMessage());

                break;


            case 'finished':
                $response = (new FinishedAction($this))->getResponse($this->getCommand()->getMessage());
                $this->stopConversation();

                break;

            case 'cancelled':

                $response = (new CancelledAction($this))->getResponse($this->getCommand()->getMessage());
                $this->stopConversation();

                break;

        endswitch;

        return $response;
    }
}