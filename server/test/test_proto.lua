require("framework")

local skynet = require("skynet")
local proto = require("protocols.proto")

echoInfo("in test_proto")

echoInfo(proto.types)

skynet.start (function ()
    

    skynet.exit()

end)
