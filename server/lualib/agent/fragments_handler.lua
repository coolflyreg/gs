local skynet = require("skynet")
local handler = require("agent.handler")
local errorcode = require("protocols.errorcode")
local validator = require("protocols.validator")
local databases = require("db.databases")

local REQUEST = {}
handler = handler.new(REQUEST)

function REQUEST.fragment_all()
    error("<Request.fragment_all> Not Implemented")
end

function REQUEST.fragment_players(args)
    error("<Request.fragment_players> Not Implemented")
end

function REQUEST.fragment_combat(args)
    error("<Request.fragment_combat> Not Implemented")
end

function REQUEST.fragment_compose(args)
    error("<Request.fragment_compose> Not Implemented")
end

return handler
