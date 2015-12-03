local skynet = require("skynet")
local mysql = require("mysql")

local CMD = {}

function CMD.init(config)
    
end

skynet.start(function()
    skynet.dispatch("lua", function(_, _, command, ...)
        
    end)
end)