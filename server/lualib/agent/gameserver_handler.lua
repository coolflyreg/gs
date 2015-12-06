local skynet = require("skynet")
local handler = require("agent.handler")
local sharedata = require "sharedata"

local REQUEST = {}
local RESPONSE = {}
handler = handler.new(REQUEST, RESPONSE)

local server_list = nil

function REQUEST.gameserver_list()
    if (not server_list) then
        server_list = sharedata.query("server_list")
    end

    local result = { servers = server_list }

    return result
end

function REQUEST.gameserver_login(args)
    error("<Request.gameserver_login> Not Implemented")
end

function REQUEST.gameserver_heartbeat(args)
    error("<Request.gameserver_heartbeat> Not Implemented")
end

function RESPONSE.gameserver_kick(args)
    error("<Request.gameserver_heartbeat> Not Implemented")
end


return handler
