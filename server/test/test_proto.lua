require("framework")

local skynet = require("skynet")
local proto = require("proto")

echoInfo("in test_proto")



skynet.start (function ()
    echoInfo ("there is "..#proto.." items in proto")
    
    
end)
