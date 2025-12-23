<?php

namespace App\Telegram\Conversations\Admin;

use App\Telegram\Handlers\Admin\AdminConversationsActionsHandler;

class ViewHelpdeskTicketConversation extends AdminConversation
{
    public function returnToAdminMenu(): void
    {
        $this->setHandler(AdminConversationsActionsHandler::$name)->setState('admin_menu');
    }
}
