local skynet = require("skynet")
local log = require("syslog")
local databases = require("db.databases")
require("framework")

local cachedata = require "cachedata"

------------------------------------------------------------

local CACHE_KEY_PLAYERNAMES = "playernames"

------------------------------------------------------------

local cache = {}

local function getPlayerNamesFromDatabase()

    local sql = [[
    SELECT
        `Fteam_name` as `name`
    FROM `zzb_player`
    ]]

    local db = databases:get("game")

    local res = db:query(sql)

    -- dump(res)

    if (res.badresult or #res == 0) then
        if res.badresult then
            log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %d", sql, res.err, res.errno, res.sqlstate)
        else
            log.warningf("Load 0 names")
        end

        return nil
    end

    local names = res

    local result = {}

    local k
    local v
    for k, v in pairs(names) do
        -- print (k, v.name)
        result[v.name] = 1
    end

    log.debugf("Cached %d player names", #names)
    return result
end

function cache.getPlayerNames()
    local exists = cachedata.exists(CACHE_KEY_PLAYERNAMES)
    if (not exists) then
        local names = getPlayerNamesFromDatabase()
        cachedata.set(CACHE_KEY_PLAYERNAMES, names)
    end

    return cachedata.get(CACHE_KEY_PLAYERNAMES)
end

return cache
