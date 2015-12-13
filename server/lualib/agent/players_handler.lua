local skynet = require("skynet")
local handler = require("agent.handler")
local errorcode = require("protocols.errorcode")
local validator = require("protocols.validator")
local sharedata = require("sharedata")
local databases = require("db.databases")
local cache = require("cachedata")
local playernamesCache = require("cache.playernames")
local playerCache = require("cache.players")
local log = require("syslog")
require "Constants"

-- Constants ------------------------------------------------------------

local NEW_TEAM_NUM = 10

-- Vars ------------------------------------------------------------

local __team_names = nil
local __system_params = nil

-- Functions ------------------------------------------------------------

local function getSystemParam()
    if (__system_params == nil) then
        __system_params = shareda.query("system_params")
    end

    return __system_params
end

local function getTeamNamesInfo()
    if (__team_names == nil) then
        __team_names = sharedata.query("team_names")
    end

    return __team_names
end

--获取初始黄金、银两、体力、元气等
local function getSystemInitData()
    local params = getSystemParam()

    return {
        gold = tonumber(params[SYSTEM_INIT_GOLD]) or SYSTEM_INIT_GOLD_V,
        money = tonumber(params[SYSTEM_INIT_MONEY]) or SYSTEM_INIT_MONEY_V,
        pneuma = tonumber(params[SYSTEM_INIT_PNEUMA]) or SYSTEM_INIT_PNEUMA_V,
        strength = tonumber(params[SYSTEM_INIT_STRENGTH]) or SYSTEM_INIT_STRENGTH_V
    }
end

local function insertPlayerDataToDatabase(uid, playername)
    local initdata = getSystemInitData()
    local sql = string.format([[
    INSERT INTO zzb_player (Fuid, Fteam_name, Flevel, Fmoney, Fgift_gold, Ftotal_gift_gold, Fstrength, Fpneuma, Fcreate_time)
					VALUES (%d, '%s', 1, %d, %d, %d, %d, %d, NOW())
    ]], uid, playername, initdata.money, initdata.gold, initdata.strength, initdata.pneuma)

    local db = databases:get("game")

    local res = db:query(sql)
    if (res.badresult) then
        log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %d", sql, res.err, res.errno, res.sqlstate)
        return
    end

    -- insert_db_sign_in(uid) -- TODO to finish this
end

-- Handlers ------------------------------------------------------------

local REQUEST = {}
handler = handler.new(REQUEST)

function REQUEST.player_names()
    local playerNames = playernamesCache.getPlayerNames()

    local allNames = getTeamNamesInfo()

    math.randomseed(os.time())

    local inum_new = 0
    local newNames = {}
    while (#newNames < NEW_TEAM_NUM) do

        local irand_f = math.random(1, #allNames.first)
        local irand_s = math.random(1, #allNames.second)
        local irand_t = math.random(1, #allNames.third)

        local first = allNames.first[irand_f]
        local second = allNames.second[irand_s]
        local third = allNames.third[irand_t]

        local newName = string.format("%s%s%s", first, second, third)

        if playerNames[newName] == nil then
            table.insert(newNames, newName)
        end
    end

    return { names = newNames }
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
        log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %d", sql, res.err, res.errno, res.sqlstate)
        return { success = 9 }
--    elseif (keywords:containsIn(team_name) then -- TODO to finish the keyword system
--        return { success = 2 }
    end

    local player = playerCache.getPlayerFromDatabase(uid)

    if (player == nil) then
        insertPlayerDataToDatabase(uid, team_name)
    else
        player.name = team_name
        playerCache.savePlayer(player)
    end

    return { success = 0 }
end

function REQUEST.player_init(args)
    local characterId = args.characterId

    playerCache.getPlayer()

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
