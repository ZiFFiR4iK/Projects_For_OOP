<?php

namespace App\Telegram\Commands;

use App\Config;
use App\Telegram\Commands\MartinCommand\MartinSystemCommand;
use App\Telegram\Conversations\MartinConversation;
use App\Telegram\Enums\MartinButtonMessages;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Exception\TelegramException;
use Longman\TelegramBot\Request;

class StartBotCommand extends MartinSystemCommand
{
    public static string $commandName = 'start';
    /**
     * @var string
     */
    protected $name = 'start';

    /**
     * @var string
     */
    protected $description = 'Start bot conversation';

    /**
     * @var string
     */
    protected $usage = '/start';

    /**
     * @var string
     */
    protected $version = '0.4.0';

    /**
     * @var bool
     */
    protected $need_mysql = true;

    /**
     * @var bool
     */
    protected $private_only = true;

    /**
     * Conversation Object
     *
     * @var MartinConversation
     */
    protected ?MartinConversation $conversation;

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


        Request::sendPhoto([
            'chat_id' => $message->getChat()->getId(),
            'photo' => Request::encodeFile(Config::get('app.kernel_path') . '/storage/martin.jpeg'),
        ]);

        return $this->replyToChat(
            "Привет, меня зовут Мартин.\nЯ бот сети II AMPERA\nТеперь я знаю о тебе и буду помогать тебе взаимодействовать с админами.\n\nДЛЯ СВЯЗИ С АДМИНАМИ ОБРАЩАТЬСЯ СЮДА: @llampera_adm",
            [
                'reply_markup' => json_encode([
                    'keyboard' => $this->getMainKeyboard(),
                    'resize_keyboard' => true,   // подгоняет по размеру
                    'one_time_keyboard' => false // оставить клавиатуру открытой
                ]),
            ]
        );
    }
}