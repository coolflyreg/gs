local skynet = require("skynet")

local databases

skynet.init(function()
    databases = require("db.databases")
end)

local function getPlayerNamesFromDatabase(...)

    local log = require("syslog")
    require("framework")

    local sql = [[
    SELECT
        `Fteam_name` as `name`
    FROM `zzb_player`
    ]]

    local db = databases.get("game")

    local res = db:query(sql)

    dump(res)

    if (res.badresult or #res == 0) then
        if res.badresult then
            log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %d", sql, res.err, res.errno, res.sqlstate)
        else
            log.warningf("Load 0 names")
        end

        return nil
    end

    local names = res[1]

    local result = {}

    local k
    local v
    for k, v in pairs(player) do
        result[v] = 1
    end

    log.debugf("Cached %d player names", #names)
    return result
end


return getPlayerNamesFromDatabase
