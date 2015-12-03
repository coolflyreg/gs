require("framework")
local skynet = require "skynet"
local sprotoloader = require "sprotoloader"

local max_client = 64

skynet.start(function()
    --local console = skynet.newservice("console")
    skynet.newservice ("debug_console", 8000)
    skynet.uniqueservice("protocolsd")
    local sessiond = skynet.uniqueservice("sessiond")

    --local databased = skynet.uniqueservice("")

    local loginmaster = skynet.newservice("loginmasterd")
    skynet.call(loginmaster, "lua", "init", {
        count = 8,
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
