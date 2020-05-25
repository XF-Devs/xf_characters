--[[ SCRIPTED BY Xander1998 ]]--

fx_version "adamant"

game { "gta5" }

ui_page "client/html/index.html"

files {
  "client/html/index.html",
  "client/html/events.js",
  "client/html/script.js",
  "client/html/css/_vars.css",
  "client/html/css/manager.css",
  "client/html/css/creator.css"
}

-- Shared Scripts
shared_script "shared/shared.lua"

-- Shared Imports
shared_script "@xf_core/shared/models/utils/thread.lua"
shared_script "@xf_core/shared/models/networkcallbacks.lua"

-- Server Imports
server_script "@xf_core/server/models/player.lua"

-- Server Scripts
server_script "server/managers/*.lua"
server_script "server/models/*.lua"
server_script "server/server.lua"

-- Client Scripts
client_script "client/models/*.lua"
client_script "client/manager.lua"
client_script "client/creator.lua"