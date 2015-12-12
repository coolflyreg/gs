local skynet = require("skynet")
local log = require("syslog")
local databases = require("db.databases")
require("framework")

local cachedata = require "cachedata"

------------------------------------------------------------

local CACHE_KEY_PLAYERS = "players"

------------------------------------------------------------

local cache = {}

function cache.getPlayerFromDatabase(uid)

    local sql = string.format([[
    SELECT
        `Fuid` as `id`,
        `Fteam_name` as `name`,
        `Flevel` as `level`,
        `Fvip_level` as `vipLevel`,
        `Fprestige` as `exp`,
        `Fmoney` as `money`,
        `Fgold` as `gold`,
        `Fgift_gold` as `gift_gold`,
		`Fgold` + `Fgift_gold` as `golden`,
        `Ftotal_gold` as `total_gold`,
        `Ftotal_gold` as `boughtG`,
        `Ftotal_gift_gold` as `total_gift_gold`,
        `Ftotal_sign_gold` as `total_sign_gold`,
        `Fstrength` as `strength`,
        `Fpneuma` as `pneuma`,
        `Fstrength_restore_time` as `strength_restore_time`,
        `Fpneuma_restore_time` as `pneuma_restore_time`,
        `Frecharge_num` as `recharge_num`,
        `Finit` as `init`,
        `Ffirst` as `first`,
        NOW() as `now_time`,
        UNIX_TIMESTAMP() as `int_now_time`,
        `Fbup` as `bup`,
        `Fbpp` as `bpp`,
        `Fmbfc` as `mbfc`,
        `Fmojing` as `mojing`,
        `Ffame` as `fame`,
        `Frouse_num` as `rousing`,
        `Frouse_last_time` as `rouse_last_time`,
        DATE(FROM_UNIXTIME(Frouse_last_time))+0 as `rouse_last_time_date`,
        CURDATE()+0 as `current_date`,
        `Fcreate_time` as `create_time`
    FROM `zzb_player`
    WHERE `Fuid`=%d  ]], uid)

    local db = databases.get("game")

    local res = db:query(sql)

    if (res.badresult or #res == 0) then
        return nil
    end

    local player = res[1]

    local k
    local v
    for k, v in pairs(player) do
        if (k ~= "name" and k ~= "now_time" and k ~= "create_time") then
            player[k] = tonumber(v)
        end
    end

    return player
end

function cache.getPlayer(uid)
    if (uid == nil or uid <= 0) then
        return nil
    end

    local key = CACHE_KEY_PLAYERS.."."..uid
    local exists = cachedata.exists(key)
    if (not exists) then
        local player = getPlayerFromDatabase(uid)
        cachedata.set(key, player)
    end

    return cachedata.get(key)
end

return cache
