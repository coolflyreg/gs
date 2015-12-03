local skynet = require "skynet"
local socket = require("clientsocket")

skynet.start(function()
    skynet.newservice ("test_proto")
end)
