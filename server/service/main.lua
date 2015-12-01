require("framework")
local skynet = require "skynet"
local sprotoloader = require "sprotoloader"

local max_client = 64

skynet.start(function()
    skynet.newservice ("debug_console", 8000)
    skynet.uniqueservice("protocolsd")
    local sessiond = skynet.uniqueservice("sessiond")

    local sobj = skynet.call(sessiond, "lua", "save", "fdfake", "gaoxiang")

    dump(sobj)

  	skynet.exit()
end)
