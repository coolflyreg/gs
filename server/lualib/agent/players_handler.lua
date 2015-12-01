local skynet = require("skynet")
local handler = require("agent.handler")

local REQUEST = {}
handler = handler.new(REQUEST)

function REQUEST.player_names()
    error("<Request.player_names> Not Implemented")
end

function REQUEST.player_create(args)
    error("<Request.player_create> Not Implemented")
end

function REQUEST.player_init(args)
    error("<Request.player_init> Not Implemented")
end

function REQUEST.player_changeName(args)
    error("<Request.player_changeName> Not Implemented")
end

function REQUEST.player_reset()
    error("<Request.player_reset> Not Implemented")
end

function REQUEST.player_restoreAP()
    error("<Request.player_restoreAP> Not Implemented")
end

function REQUEST.player_restoreMP()
    error("<Request.player_restoreMP> Not Implemented")
end

function REQUEST.player_refreshAPMP()
    error("<Request.player_refreshAPMP> Not Implemented")
end

function REQUEST.player_info()
    error("<Request.player_info> Not Implemented")
end

function REQUEST.player_allinfo(args)
    error("<Request.player_allinfo> Not Implemented")
end

function REQUEST.player_vipdata()
    error("<Request.player_vipdata> Not Implemented")
end

return handler