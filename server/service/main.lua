require("framework")
local skynet = require "skynet"
local sprotoloader = require "sprotoloader"

local max_client = 64

skynet.start(function()
    skynet.newservice ("debug_console", 8000)
    skynet.uniqueservice("protocolsd")

	skynet.exit()
end)
