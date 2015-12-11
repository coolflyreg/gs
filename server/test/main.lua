local skynet = require "skynet"
local socket = require("clientsocket")
require ("framework")


local function testSplit(str)
    print(string.format("split %s", str))
    dump(string.split(str, "."))
end

skynet.start(function()

    -- skynet.newservice ("test_proto")
    testSplit("player")
    testSplit("player.names")
    testSplit("player.names.123")
end)
