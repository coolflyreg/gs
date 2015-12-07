local skynet = require("skynet")
local handler = require("agent.handler")
local errorcode = require("protocols.errorcode")
local validator = require("protocols.validator")
local databases = require("db.databases")

local REQUEST = {}
handler = handler.new(REQUEST)

function REQUEST.social_all()
    error("<Request.social_all> Not Implemented")
end

function REQUEST.social_searchFriend(args)
    error("<Request.social_searchFriend> Not Implemented")
end

function REQUEST.social_connect(args)
    error("<Request.social_connect> Not Implemented")
end

function REQUEST.social_disconnect(args)
    error("<Request.social_disconnect> Not Implemented")
end

function REQUEST.social_combatReport(args)
    error("<Request.social_combatReport> Not Implemented")
end

function REQUEST.social_chatList(args)
    error("<Request.social_chatList> Not Implemented")
end

function REQUEST.social_chatSend(args)
    error("<Request.social_chatSend> Not Implemented")
end

function REQUEST.social_friendRequest(args)
    error("<Request.social_friendRequest> Not Implemented")
end

function REQUEST.social_playerPK(args)
    error("<Request.social_playerPK> Not Implemented")
end

return handler