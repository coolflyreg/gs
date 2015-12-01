local skynet = require("skynet")
local handler = require("agent.handler")

local REQUEST = {}
handler = handler.new(REQUEST)

function REQUEST.equipment_all()
    error("<Request.equipment_all> Not Implemented")
end

function REQUEST.equipment_one(args)
    error("<Request.equipment_one> Not Implemented")
end

function REQUEST.equipment_sell(args)
    error("<Request.equipment_sell> Not Implemented")
end

function REQUEST.equipment_upgrade(args)
    error("<Request.equipment_upgrade> Not Implemented")
end

function REQUEST.equipment_renew(args)
    error("<Request.equipment_renew> Not Implemented")
end

return handler