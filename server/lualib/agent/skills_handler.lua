local skynet = require("skynet")
local handler = require("agent.handler")

local REQUEST = {}
handler = handler.new(REQUEST)

function REQUEST.skill_all()
    error("<Request.skill_all> Not Implemented")
end

function REQUEST.skill_one(args)
    error("<Request.skill_one> Not Implemented")
end

function REQUEST.skill_upgrade(args)
    error("<Request.skill_upgrade> Not Implemented")
end


return handler