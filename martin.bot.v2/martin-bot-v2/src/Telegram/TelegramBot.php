<?php

namespace App\Telegram;

use App\Config;
use App\Logger\Logger;
use App\Telegram\Exception\MartinBotException;
use Longman\TelegramBot\Telegram;

class TelegramBot
{

    public function create(): Telegram
    {
        $telegram = new Martin(config('telegram.token'), config('telegram.username'));

        $telegram->addCommandsPaths(config('telegram.commands.paths'));

        $telegram->enableMySql(
            $this->transformToTelegramBotMySqlCredentialsFormat(Config::get('database.credentials'))
        );
        $admins = Config::get('telegram.admins');

        $telegram->enableAdmins(
            array_map(function ($admin) { return $admin['telegram_id']; }, $admins)
        );


        return $telegram;
    }

    public function start(): void
    {
        $logger = new Logger('/var/log');
        $telegram = $this->create();
        while (true) {
            try {
                $telegram->handleGetUpdates();
            } catch (MartinBotException $e) {
                $logger->logException($e, 'martin_errors.log.txt');
            } catch (\Throwable $e) {
                $logger->logException($e, 'php_errors.log.txt');
            }
        }
    }

    private function transformToTelegramBotMySqlCredentialsFormat(array $credentials): array
    {
        return [
            'host' => $credentials['host'],
            'port' => $credentials['port'],
            'user' => $credentials['user'],
            'password' => $credentials['password'],
            'database' => $credentials['dbname'],
        ];
    }
}