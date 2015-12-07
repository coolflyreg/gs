local skynet = require("skynet")
local handler = require("agent.handler")
local errorcode = require("protocols.errorcode")
local validator = require("protocols.validator")
local databases = require("db.databases")

local REQUEST = {}
handler = handler.new(REQUEST)

function REQUEST.formation_all()
    error("<Request.equipment_all> Not Implemented")
end

function REQUEST.formation_one(args)
    error("<Request.formation_one> Not Implemented")
end

function REQUEST.formation_setup(args)
    error("<Request.formation_setup> Not Implemented")
end

function REQUEST.formation_characters()
    error("<Request.formation_characters> Not Implemented")
end

function REQUEST.formation_setcharacter(args)
    error("<Request.formation_setcharacter> Not Implemented")
end

function REQUEST.formation_upgrade(args)
    error("<Request.formation_upgrade> Not Implemented")
end

function REQUEST.formation_friends()
    error("<Request.formation_friends> Not Implemented")
end

function REQUEST.formation_setFriend(args)
    error("<Request.formation_setFriend> Not Implemented")
end

function REQUEST.formation_newFriendPos(args)
    error("<Request.formation_newFriendPos> Not Implemented")
end

function REQUEST.formation_setBeast(args)
    error("<Request.formation_setBeast> Not Implemented")
end

function REQUEST.formation_unlockFriendPos(args)
    error("<Request.formation_unlockFriendPos> Not Implemented")
end

return handler