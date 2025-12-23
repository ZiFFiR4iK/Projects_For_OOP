<?php

namespace App\Telegram\Enums;

enum MartinButtonMessages: string
{
    case MAC_APPLICATION = '💻 Оставить заявку на изменение/добавление MAC-адресов';
    case PAYMENT = '💸 Оставить заявку на оплату';

    case CHECK_MAC_APPLICATION = '💻 Проверить заявку на МАК';
    case CHECK_PAYMENT_APPLICATION = '💸 Проверить заявку на оплату';

    case FORWARD = '➡️ Продолжить';
    case BACK = '⬅️ Назад';

    case CANCEL_COMMAND = '/start';
    case CANCEL = '🚫 Отмена';

    case MANUAL_INPUT = '✍️ Ввести вручную';
    case IMPORT_USER_DATA = '⬇️ Импортировать';

    case SHOW_PAYMENT_DATA = '💳 Показать реквизиты';
    case SEND_CONNECTION_INSTRUCTIONS_FILE = '📝 Отправить инструкции по подключению';
    case SHOW_INSTRUCTIONS = '📋 Посмотреть инструкции';

    case ADD_MAC = '➕ Добавить МАК';
    case NOT_ADD_MAC = '☑️ Завершить';

    case CHECK_APPLICATION_STATUS = '👀 Проверить статус заявки';
    case USER_CONFIGURATION = '⚙️ Настройки пользователя';

    case CREATE_TICKET = '⚠️ Сообщить о проблеме';
    case SHOW_ALL_TICKETS = '🎫 Посмотреть все мои тикеты';
    case SHOW_ONE_TICKET = '🏷️ Показать тикет';

    case CHECK_TICKET_STATUS = '🏷️ Проверить заявку на сообщение о проблеме';
    case REPLY_TICKET = '💬 Ответить по тикету';
    case ACCEPT_TICKET = '✅ Принять заявку';
    case REJECT_TICKET = '⛔️ Отклонить заявку';

    case SHOW_ADMIN_MENU = '👨🏻‍💻 Показать меню администратора';
    case MAKE_BROADCAST_MESSAGE = '📢 Отправить сообщение всем пользователям';
}
