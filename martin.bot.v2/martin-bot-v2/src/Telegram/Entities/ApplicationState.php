<?php

namespace App\Telegram\Entities;

class ApplicationState
{
    public function __construct(
        public int $id,
        public string $title,
    )
    {
    }
}