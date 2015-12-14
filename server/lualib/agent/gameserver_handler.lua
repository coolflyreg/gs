local skynet = require("skynet")
local handler = require("agent.handler")
local sharedata = require "sharedata"
local errorcode = require("protocols.errorcode")
local validator = require("protocols.validator")
local databases = require("db.databases")
local md5 = require "md5"
require("framework")


local REQUEST = {}
local RESPONSE = {}
handler = handler.new(REQUEST, RESPONSE)

local server_list = nil
local _sessionCounter = 1

function REQUEST.gameserver_list()
    if (not server_list) then
        server_list = sharedata.query("server_list")
    end

    local result = { servers = server_list }

    return result
end

function REQUEST.gameserver_login(args)
    local username = assert(args.username)
    local platform = assert(args.platform)
    local serverId = assert(args.serverId)

    local sql = string.format([[
    SELECT `Fuid` as `uid` FROM zzb_user_center WHERE Fname='%s' AND Fplatid=%d AND Fserverid=%d
    ]], username, platform, serverId)

    local db = databases:get("account")
    local res = db:query(sql)
    if (res.badresult) then
        log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %d", sql, res.err, res.errno, res.sqlstate)
        return { errno = errorcode.INTERNAL_ERROR }
    end

    local uid = res.uid
    if (#res == 0) then
        sql = string.format([[
        INSERT INTO zzb_user_center (Fname, Fserverid, Fplatid, Fcreate_time) VALUES
									('%s', %d, %d, UNIX_TIMESTAMP())
        ]], username, serverId, platform)

        res = db:query(sql)
        if (res.badresult) then
            log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %d", sql, res.err, res.errno, res.sqlstate)
            return { errno = errorcode.INTERNAL_ERROR }
        end

        uid = res.insert_id
    end

    local counter = _sessionCounter
    _sessionCounter = _sessionCounter + 1
    local session = md5String(md5.sum(args.username.."-"..args.serverId.."-"..tostring(os.date("[%F %T]")).."-"..counter))

    sql = string.format([[
    SELECT `Fid` as `id` FROM zzb_player_login WHERE Fuid=%d
    ]], uid)

    res = db:query(sql)
    if (#res == 0) then
        sql = string.format([[
        INSERT INTO zzb_player_login (Fuid, Fsession, Flogin_time) VALUES(%d, '%s', NOW())
        ]], uid, session)

        db:query(sql)
    else
        sql = string.format([[
        UPDATE zzb_player_login SET Fsession='%s' WHERE Fuid=%d
        ]], session, uid)

        db:query(sql)
    end

    return { uid = uid, sessionId = session, golden = 0 }
end

function REQUEST.gameserver_heartbeat(args)
    error("<Request.gameserver_heartbeat> Not Implemented")
end

function RESPONSE.gameserver_kick(args)
    error("<Request.gameserver_heartbeat> Not Implemented")
end


return handler
