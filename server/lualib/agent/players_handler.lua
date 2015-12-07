local skynet = require("skynet")
local handler = require("agent.handler")
local errorcode = require("protocols.errorcode")
local validator = require("protocols.validator")
local databases = require("db.databases")

local REQUEST = {}
handler = handler.new(REQUEST)

function REQUEST.player_names()
    error("<Request.player_names> Not Implemented")
end

function REQUEST.player_create(args)
    local uid = args.uid
    local team_name = args.name

    if not uid or not team_name then
        return { errno = errorcode.ARGUMENTS_ERROR }
    end

    local db = databases:get("game")

    local sql = string.format("SELECT Fuid FROM zzb_player WHERE Fteam_name = '%s' ", team_name)
    local res = db:query(sql)

    if (res and not res.badresult and #res > 0) then
        return { success = 1 }
    elseif (res.badresult) then
        return { success = 9 }
--    elseif (keywords:containsIn(team_name) then -- TODO to finish the keyword system
--        return { success = 2 }
    else 
        return { success = 0 }
    end
end

function REQUEST.player_init(args)
    local characterId = args.characterId
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