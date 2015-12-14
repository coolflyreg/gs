local skynet = require "skynet"
local socket = require("clientsocket")
local md5 = require "md5"
require ("framework")


local function testSplit(str)
    print(string.format("split %s", str))
    dump(string.split(str, "."))
end

skynet.start(function()
    local md5code = md5.sum("asdfs")
    -- printHex(md5code)
    print (md5String(md5code))

    -- skynet.newservice ("test_proto")
    testSplit("player")
    testSplit("player.names")
    testSplit("player.names.123")
end)
