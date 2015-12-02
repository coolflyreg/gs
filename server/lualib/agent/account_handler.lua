local skynet = require("skynet")
local handler = require("agent.handler")

local REQUEST = {}
handler = handler.new(REQUEST)

function REQUEST.account_register(args)
    --error("<Request.skill_all> Not Implemented")
    return { username = args.username }
end

function REQUEST.account_auth(args)
    error("<Request.skill_one> Not Implemented")
end

function REQUEST.account_auth_platform(args)
    error("<Request.skill_upgrade> Not Implemented")
end


return handler
