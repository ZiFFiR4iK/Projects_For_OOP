<?php

namespace App\Telegram\Handlers;

use App\Telegram\Commands\MartinCommand\MartinSystemCommand;
use App\Telegram\Conversations\MartinConversation;
use App\Telegram\Exception\MartinBotException;
use App\Telegram\Handlers\Actions\CancelledAction;
use App\Telegram\Handlers\Actions\FinishedAction;
use Longman\TelegramBot\Entities\ServerResponse;
use SM\StateMachine\StateMachine;

abstract class BaseMartinBotConversationHandler
{
    protected array $actions = [
        'cancelled' => CancelledAction::class,
        'finished' => FinishedAction::class
    ];

    public static string $name;

    protected ?MartinConversation $conversation = null;

    protected ?StateMachine $stateMachine = null;

    protected bool $resetText = false;

    public function __construct(
        private MartinSystemCommand $command
    )
    {
    }

    public function getCommand(): MartinSystemCommand
    {
        return $this->command;
    }

    /**
     * @template T of MartinConversation
     * @param class-string<T> $className
     * @return MartinConversation
     */
    protected function makeConversation(string $className): MartinConversation
    {
        /** @var MartinConversation $conv */
        $conv = new $className(
            $this->getCommand()->getMessage()->getFrom()->getId(),
            $this->getCommand()->getMessage()->getChat()->getId(),
            static::$name
        );
        return $conv;
    }

    /**
     * @template T of MartinConversation
     * @param class-string<T> $className
     * @param array{initial_state:string} $config
     */
    public function loadConversation(string $className, array $config): void
    {
        $this->conversation = $this->makeConversation($className);

        if (! $this->conversation->getState()) {
            $this->conversation->setState($config['initial_state']);
            $this->conversation->persistState();
        }
    }

    public function loadStateMachine(array $config): void
    {
        if (!$this->conversation) {
            throw new \LogicException('Conversation must be loaded before StateMachine.');
        }

        $this->stateMachine = new StateMachine($this->conversation, $config);
    }

    protected function handleTransition(string $transition): ServerResponse
    {
        if (!$this->stateMachine || !$this->conversation) {
            throw new \LogicException('StateMachine and Conversation must be initialized.');
        }

        if (! $this->stateMachine->can($transition)) {
            throw new MartinBotException('Невозможно сделать дальнейший переход. Сбой сервера.');
        }

        $this->stateMachine->apply($transition);
        $this->conversation->persistState();
        $this->resetText = true;

        return $this->handleUpdate();

    }

    public function handleConversationAction(string $state)
    {
        return (new $this->actions[$state]($this))->getResponse($this->getCommand()->getMessage());
    }

    public function addActions(array $actions)
    {

    }
    public function transition(string $to): ServerResponse
    {
        return $this->handleTransition($to);
    }

    public function stopConversation(): void
    {
        $this->conversation?->stop();
    }

    public function getConversation(): ?MartinConversation
    {
        return $this->conversation;
    }

    public function shouldResetText(): void
    {
        $this->setResetText(true);
    }

    protected function setResetText(bool $value): void
    {
        $this->resetText = $value;
    }

    public function resetText(): bool
    {
        return $this->resetText;
    }
    public function execute(): ServerResponse
    {
        try {
            return $this->handleUpdate();
        } catch (MartinBotException $e) {
            $this->getConversation()->sendMessage($e->getMessage());

            $this->transition('to_cancelled');
            throw $e;
        } catch (\Throwable $e) {
            $this->getConversation()->sendMessage('Произошла серверная ошибка');

            $this->transition('to_cancelled');
            throw $e;
        }
    }
    abstract public function handleUpdate(): ServerResponse;
}