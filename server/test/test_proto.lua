require("framework")

local skynet = require("skynet")
local proto = require("protocols.proto")

echoInfo("in test_proto")


skynet.start (function ()
    

    skynet.exit()

end)
