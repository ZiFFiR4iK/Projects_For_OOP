<?php

use App\Env;

return [
    'token' => env('TELEGRAM_BOT_TOKEN'),
    'username' => env('TELEGRAM_BOT_USERNAME'),

    'admins' => [
        [
            'name' => 'Евгений',
            'telegram_id' => '747099114',
            'permissions' => [

            ]
        ],
        [
            'name' => 'Владислав',
            'telegram_id' => '1854044544',
            'permissions' => [

            ]
        ],
        [
            'name' => 'Дмитрий',
            'telegram_id' => '1106110293',
            'permissions' => [

            ]
        ],
        [
            'name' => 'Яша',
            'telegram_id' => '1446309459',
            'permissions' => [

            ]
        ],

    ],

    'app_uri_api' => env('APPLICATION_ADDRESS') . ':' . env('APPLICATION_PORT') . '/api',

    'requisites' => [
        'Яков' => ['2202 2050 2545 9808'],
    ],

    'commands' => [
        'paths'   => [
            __DIR__.'/../src/Telegram/Commands',
            __DIR__ . '/../src/Telegram/Commands/ApplicationConversations',
        ],
    ],

    'state_machine' => [
        'instructions' => [
            'graph' => 'instructions',
            'property_path' => 'state',
            'initial_state' => 'start',
            'states'        => [
                'start',
                'show_instructions',
                'cancelled'
            ],
            'transitions' => [
                'to_start' => [
                    'from'  => ['show_instructions'],
                    'to'    => 'start'
                ],
                'to_show_instructions' => [
                    'from' => ['start'],
                    'to'   => 'show_instructions'
                ],
                'to_cancelled' => [
                    'from' => ['start', 'show_instructions'],
                    'to'   => 'cancelled'
                ],
            ]
        ],
        'admin_menu' => [
            'graph'         => 'admin_menu ',
            'property_path' => 'state',
            'initial_state' => 'start',
            'states'        => [
                'start',
                'admin_menu',
                'handler_cancelled',
                'cancelled'
            ],
            'transitions' => [
                'to_start' => [
                    'from'  => ['admin_menu'],
                    'to'    => 'start'
                ],
                'to_admin_menu' => [
                    'from' => ['start'],
                    'to'   => 'admin_menu'
                ],
                'to_handler_cancelled' => [
                    'from' => ['start', 'admin_menu'],
                    'to'   => 'handler_cancelled'
                ],
                'to_cancelled' => [
                    'from' => ['start', 'admin_menu'],
                    'to'   => 'cancelled'
                ],
            ]
        ],
        'broadcast_message' => [
            'graph'         => 'broadcast_message ',
            'property_path' => 'state',
            'initial_state' => 'input_message',
            'states'        => [
                'admin_menu',
                'input_message',
                'show_message',
                'send_message',
                'finished',
                'cancelled',
                'handler_cancelled'
            ],
            'transitions' => [
                'to_admin_menu' => [
                    'from' => ['input_message'],
                    'to'   => 'admin_menu'
                ],
                'to_input_message' =>  [
                    'from' => ['admin_menu', 'show_message'],
                    'to' => 'input_message'
                ],
                'to_show_message' => [
                    'from' => ['input_message'],
                    'to' => 'show_message'
                ],
                'to_send_message' => [
                    'from' => ['show_message'],
                    'to' => 'send_message'
                ],
                'to_finished' => [
                    'from' => [
                        'send_message'
                    ],
                    'to' => 'finished'
                ],
                'to_cancelled' => [
                    'from' => [
                        'admin_menu', 'input_message', 'show_message', 'send_message',
                    ],
                    'to' => 'cancelled'
                ],
                'to_handler_cancelled' => [
                    'from' => [
                        'admin_menu', 'input_message', 'show_message', 'send_message',
                    ],
                    'to' => 'handler_cancelled'
                ],
            ],
            'callbacks' => [
                'after' => [
                    'to_admin_menu' => [
                        'on' => ['to_admin_menu'],
                        'do' => ['object', 'returnToAdminMenu'],
                    ],
                    'to_input_message' => [
                        'on' => ['to_admin_menu'],
                        'do' => ['object', 'flushInputMessages'],
                    ],
                ]
            ]
        ],
        'view_helpdesk_ticket' => [
            'graph'         => 'view_helpdesk_ticket',
            'property_path' => 'state',
            'initial_state' => 'input_ticket_number',
            'states'        => [
                'admin_menu',
                'input_ticket_number',
                'reply_ticket',
                'change_ticket_status',
                'finished',
                'cancelled',
                'handler_cancelled',
            ],
            'transitions' => [
                'to_admin_menu' => [
                    'from' => ['input_ticket_number', 'reply_ticket', 'change_ticket_status'],
                    'to'   => 'admin_menu'
                ],
                'to_input_ticket_number' => [
                    'from' => ['admin_menu'],
                    'to' => 'input_ticket_number'
                ],
                'to_change_ticket_status' => [
                    'from' => ['input_ticket_number'],
                    'to' => 'change_ticket_status'
                ],
                'to_reply_ticket' => [
                    'from' => ['input_ticket_number'],
                    'to' => 'reply_ticket'
                ],
                'to_finished' => [
                    'from' => ['input_ticket_number', 'reply_ticket', 'change_ticket_status'],
                    'to' => 'finished'
                ],
                'to_cancelled' => [
                    'from' => [
                        'admin_menu', 'input_ticket_number', 'reply_ticket', 'change_ticket_status',
                    ],
                    'to' => 'cancelled'
                ],
                'to_handler_cancelled' => [
                    'from' => [
                        'admin_menu', 'input_ticket_number', 'reply_ticket', 'change_ticket_status',
                    ],
                    'to' => 'handler_cancelled'
                ],
            ],
            'callbacks' => [
                'after' => [
                    'to_admin_menu' => [
                        'on' => ['to_admin_menu'],
                        'do' => ['object', 'returnToAdminMenu'],
                    ],
                ]
            ],
        ],
        'helpdesk_ticket' => [
            'graph'         => 'helpdesk_ticket',
            'property_path' => 'state',
            'initial_state' => 'start',
            'states'        => [
                'start',
                'show_tickets_menu',
                'show_all_tickets',
                'show_one_ticket',
                'ask_user_data',
                'ask_name',
                'ask_surname',
                'ask_room',
                'ask_content',
                'ask_photo',
                'show_created_ticket',
                'finished',
                'cancelled'
            ],
            'transitions' => [
                'to_start' => [
                    'from' => ['ask_user_data', 'show_tickets_menu'],
                    'to'   => 'start'
                ],
                'to_show_tickets_menu' =>  [
                    'from' => ['start'],
                    'to' => 'show_tickets_menu'
                ],
                'to_show_all_tickets' => [
                    'from' => ['show_tickets_menu'],
                    'to' => 'show_all_tickets'
                ],
                'to_show_one_ticket' => [
                    'from' => ['show_tickets_menu'],
                    'to' => 'show_one_ticket'
                ],
                'to_ask_user_data' => [
                    'from' => ['start', 'ask_name'],
                    'to' => 'ask_user_data'
                ],
                'to_ask_name' => [
                    'from' => ['ask_surname', 'ask_user_data'],
                    'to'   => 'ask_name'
                ],
                'to_ask_surname' => [
                    'from' => ['ask_name', 'ask_room'],
                    'to'   => 'ask_surname'
                ],
                'to_ask_room' => [
                    'from' => ['ask_surname', 'ask_content'],
                    'to'   => 'ask_room'
                ],
                'to_ask_content' => [
                    'from' => ['start', 'ask_user_data', 'ask_room', 'ask_photo', 'show_created_ticket'],
                    'to'   => 'ask_content'
                ],
                'to_ask_photo' => [
                    'from' => ['ask_content', 'show_created_ticket'],
                    'to' => 'ask_photo'
                ],
                'to_show_created_ticket' => [
                    'from' => ['ask_photo'],
                    'to' => 'show_created_ticket'
                ],
                 'to_finished' => [
                    'from' => [
                        'show_all_tickets', 'show_one_ticket', 'show_created_ticket'
                    ],
                    'to' => 'finished'
                ],
                'to_cancelled' => [
                    'from' => [
                        'start', 'show_tickets_menu', 'show_all_tickets', 'ask_user_data', 'ask_name', 'ask_surname', 'ask_room',
                        'ask_content', 'ask_photo', 'show_created_ticket'
                    ],
                    'to' => 'cancelled'
                ],
            ],
            'callbacks' => [
                'after' => [
                    'to_ask_content' => [
                        'on' => ['to_ask_content'],
                        'do' => ['object', 'createHelpDeskApplicationIfNotExists'],
                    ],
                    'to_cancelled' => [
                        'on' => ['to_cancelled'],
                        'do' => ['object', 'removeContext'],
                    ],
                    'to_finished' => [
                        'on' => ['to_finished'],
                        'do' => ['object', 'afterFinish'],
                    ],
                ]
            ],
        ],
        'check_application_status' => [
            'graph'         => 'check_application_status',
            'property_path' => 'state',
            'initial_state' => 'start',
            'states'        => [
                'start',
                'check_mac_application',
                'check_payment_application',
                'check_helpdesk_application',
                'finished',
                'cancelled'
            ],
            'transitions' => [
                'to_start' => [
                    'from' => ['check_mac_application', 'check_payment_application', 'check_helpdesk_application'],
                    'to'   => 'start'
                ],
                'to_check_mac_application' => [
                    'from' => ['start'],
                    'to' => 'check_mac_application'
                ],
                'to_check_payment_application' => [
                    'from' => ['start'],
                    'to'   => 'check_payment_application'
                ],
                'to_check_helpdesk_application' => [
                    'from' => ['start'],
                    'to'   => 'check_helpdesk_application'
                ],
                'to_finished' => [
                    'from' => ['check_payment_application', 'check_mac_application', 'check_helpdesk_application'],
                    'to'   => 'finished'
                ],
                'to_cancelled' => [
                    'from' => ['start', 'check_mac_application', 'check_payment_application', 'check_helpdesk_application'],
                    'to' => 'cancelled'
                ],
            ],
        ],
        'mac_application' => [
            'graph'         => 'mac_application',
            'property_path' => 'state',
            'initial_state' => 'start',
            'states'        => [
                'start',
                'ask_user_data',
                'ask_name',
                'ask_surname',
                'ask_room',
                'ask_macs',
                'ask_macs_add',
                'macs_application_report',
                'finished',
                'cancelled'
            ],
            'transitions' => [
                'to_start' => [
                    'from' => ['ask_name', 'ask_surname', 'ask_room', 'ask_macs', 'ask_user_data'],
                    'to'   => 'start'
                ],
                'to_ask_user_data' => [
                    'from' => ['start', 'ask_name'],
                    'to' => 'ask_user_data'
                ],
                'to_ask_name' => [
                    'from' => ['ask_surname', 'ask_user_data'],
                    'to'   => 'ask_name'
                ],
                'to_ask_surname' => [
                    'from' => ['ask_name', 'ask_room'],
                    'to'   => 'ask_surname'
                ],
                'to_ask_room' => [
                    'from' => ['ask_surname', 'ask_macs'],
                    'to'   => 'ask_room'
                ],
                'to_ask_macs' => [
                    'from' => ['ask_room', 'ask_macs_add'],
                    'to'   => 'ask_macs'
                ],
                'to_ask_macs_add' => [
                    'from' => ['ask_macs'],
                    'to' => 'ask_macs_add'
                ],
                'to_macs_application_report' => [
                    'from'    => ['ask_macs', 'ask_macs_add'],
                    'to'      => 'macs_application_report'
                ],
                'to_finished' => [
                    'from' => ['macs_application_report'],
                    'to'   => 'finished'
                ],
                'to_cancelled' => [
                    'from' => ['start', 'ask_user_data', 'macs_application_report', 'ask_name', 'ask_surname', 'ask_room', 'ask_macs', 'ask_macs_add'],
                    'to' => 'cancelled'
                ],
            ],
            'callbacks' => [
                'after' => [
                    'to_ask_macs' => [
                        'on' => ['to_ask_macs'],
                        'do' => ['object', 'createMacApplicationIfNotExists'],
                    ],
                    'to_cancelled' => [
                        'on' => ['to_cancelled'],
                        'do' => ['object', 'removeContext'],
                    ],
                    'to_finished' => [
                        'on' => ['to_finished'],
                        'do' => ['object', 'afterFinish'],
                    ],
                ]
            ]
        ],
        'payment_application'  => [
            'graph'         => 'payment_application',
            'property_path' => 'state',
            'initial_state' => 'start',
            'states'        => [
                'start',
                'ask_user_data',
                'ask_name',
                'ask_surname',
                'ask_room',
                'ask_payment',
                'finished',
                'cancelled'
            ],
            'transitions' => [
                'to_start' => [
                    'from' => ['ask_user_data'],
                    'to'   => 'start'
                ],
                'to_ask_user_data' => [
                    'from' => ['start', 'ask_name'],
                    'to' => 'ask_user_data'
                ],
                'to_ask_name' => [
                    'from' => ['ask_surname', 'ask_user_data'],
                    'to'   => 'ask_name'
                ],
                'to_ask_surname' => [
                    'from' => ['ask_name', 'ask_room'],
                    'to'   => 'ask_surname'
                ],
                'to_ask_room' => [
                    'from' => ['ask_surname', 'ask_payment'],
                    'to'   => 'ask_room'
                ],
                'to_ask_payment' => [
                    'from' => ['ask_room'],
                    'to'   => 'ask_payment'
                ],
                'to_finished' => [
                    'from' => ['ask_payment'],
                    'to'   => 'finished'
                ],
                'to_cancelled' => [
                    'from' => ['start', 'ask_user_data', 'ask_name', 'ask_surname', 'ask_room', 'ask_payment'],
                    'to' => 'cancelled'
                ],
            ],
            'callbacks' => [
                'after' => [
                    'to_ask_macs' => [
                        'on' => ['to_ask_payment'],
                        'do' => ['object', 'createMacApplicationIfNotExists'],
                    ],
                    'to_cancelled' => [
                        'on' => ['to_cancelled'],
                        'do' => ['object', 'removeContext'],
                    ],
                    'to_finished' => [
                        'on' => ['to_finished'],
                        'do' => ['object', 'afterFinish'],
                    ],
                ]
            ]
        ]
    ],
];
