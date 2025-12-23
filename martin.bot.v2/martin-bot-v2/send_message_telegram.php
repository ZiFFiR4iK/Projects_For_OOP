<?php
require __DIR__ . '/vendor/autoload.php';

use App\Env;
use Dotenv\Dotenv;
use GuzzleHttp\Client;

function sendTelegramMessage(int $chatId, string $text): bool {
    Dotenv::create(
        Env::getRepository(),
        __DIR__,
        '.env'
    )->load();

    $token = env('TELEGRAM_BOT_TOKEN');
    if (!$token) throw new RuntimeException('Missing TELEGRAM_BOT_TOKEN');

    $text = trim($text);
    if ($text === '') return false;

    $url = "https://api.telegram.org/bot{$token}/sendMessage";

    $client = new Client(['timeout' => 5.0]);

    try {
        $resp = $client->post($url, [
            'json' => [
                'chat_id' => $chatId,
                'text'    => $text,
                'parse_mode' => 'HTML'
            ],
        ]);

        $body = json_decode((string)$resp->getBody(), true);
        // log result without token
        error_log("Telegram sendMessage status={$resp->getStatusCode()} ok=" . ($body['ok'] ? '1' : '0'));
        return isset($body['ok']) && $body['ok'] === true;
    } catch (\Throwable $e) {
        error_log("Telegram API error: " . $e->getMessage());
        return false;
    }
}

# 1854044544 - Я
$chatId = $argv[1];
$text = $argv[2];

sendTelegramMessage($chatId, $text);