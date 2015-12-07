local skynet = require "skynet"
local log = require "syslog"
local databases = require("db.databases")
local sharedata = require "sharedata"

require("framework")

---------------------------------------------

local COMMONDATA = {}

function COMMONDATA.server_list()
    local db = databases:get("account")

    local sql = string.format([[
    SELECT `zzb_game_server`.`Fserverid` as `id`,
        `zzb_game_server`.`Fplatid` as `platform`,
        `zzb_game_server`.`Findex` as `index`,
        `zzb_game_server`.`Fname` as `name`,
        `zzb_game_server`.`Fhost` as `host`,
        `zzb_game_server`.`Fport` as `port`,
        `zzb_game_server`.`Fstate` as `state`
    FROM `zzb_user_center`.`zzb_game_server`;
    ]])
    local res = db:query(sql)

    if not res.badresult then
        if not res or #res == 0 then
            log.warningf("There is no server list data in database.")
            return
        end
    else
        log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %d", sql, res.err, res.errno, res.sqlstate)
        return
    end

    sharedata.new("server_list", res)
end

---------------------------------------------

local CMD = {}

function CMD.init()
    local databaseConfig = require("config.database")
    databases:init("account", databaseConfig.account)

    for k, v in pairs(COMMONDATA) do
        if (type(v) == "function") then
            v()
        end
    end
end

skynet.start(function()
    skynet.dispatch("lua", function(_, _, command, ...)
        local f = assert(CMD[command])
        if (f) then
            skynet.ret(f(...))
        end
    end)
end)
