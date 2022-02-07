fx_version 'cerulean'
games { 'gta5' }

author '! Vilppu#0469'
description 'kxl-jengialueet elikkä esx frameworkkiin Jengialueet'
version '7.91'

client_scripts {
    'cl/cl_*.lua',
    'config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'sv/sv_*.lua',
    'config.lua'
}