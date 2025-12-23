<?php

namespace App\Telegram\Enums;

enum ApplicationState: string
{
    case APPLICATION_CREATED = 'created';
    case APPLICATION_REJECTED = 'rejected';
    case APPLICATION_ACCEPTED = 'accepted';
}
