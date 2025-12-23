<?php

namespace App\Telegram\Conversations\Admin;

use App\Telegram\Db\AdminMessageDB;
use App\Telegram\Handlers\Admin\AdminConversationsActionsHandler;

class BroadcastMessageConversation extends AdminConversation
{
    public function returnToAdminMenu(): void
    {
        $this->setHandler(AdminConversationsActionsHandler::$name)->setState('admin_menu');
    }

    public function flushInputMessages(): void
    {
        AdminMessageDB::delete($this);
    }
}