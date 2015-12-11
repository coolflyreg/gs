require("framework")
local skynet = require "skynet"
local sprotoloader = require "sprotoloader"
local cachedata = require "cachedata"
local databases = require "db.databases"
local databaseConfig = require("config.database")

local max_client = 64

skynet.start(function()
    --local console = skynet.newservice("console")
    skynet.newservice ("debug_console", 8000)
    skynet.uniqueservice("protocolsd")

    if (databaseConfig.account ~= nil) then
        databases:init("account", databaseConfig.account)
    end
    if (databaseConfig.gameinfo ~= nil) then
        databases:init("gameinfo", databaseConfig.gameinfo)
    end
    if (databaseConfig.game ~= nil) then
        databases:init("game", databaseConfig.game)
    end

    local sharedata = require "sharedata"
    local sessiond = skynet.uniqueservice("sessiond")
    local cachedatad = skynet.uniqueservice("cachedatad")
    local commondatad = skynet.uniqueservice("commondatad")
    skynet.call(commondatad, "lua", "init")

    local loginmaster = skynet.newservice("loginmasterd")
    skynet.call(loginmaster, "lua", "init", {
        count = 2,
        host = "0.0.0.0",
        port = 8888,
        session_timeout = 30, -- second
    })

    -- local watchdog = skynet.newservice("watchdog");
    -- skynet.call(watchdog, "lua", "start" {
    --     port = 8888,
    --     maxclient = max_client,
    --     nodelay = true
    -- })

  	skynet.exit()
end)
