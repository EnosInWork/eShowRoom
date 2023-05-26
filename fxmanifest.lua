fx_version 'adamant'
game 'gta5'
author 'Enøs'
version '1.0.0'

shared_scripts {
    "config.lua",
}

client_scripts {
    --- RageUI
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
    --- Cl side
    "client/*.lua",
}

server_scripts {
    '@es_extended/locale.lua',
    '@mysql-async/lib/MySQL.lua',
}
