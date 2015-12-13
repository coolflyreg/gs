local skynet = require("skynet")
local log = require("syslog")
local databases = require("db.databases")
local sharedata = require("sharedata")
require("framework")

local cachedata = require "cachedata"

------------------------------------------------------------

local CACHE_KEY_PLAYERS = "players"

------------------------------------------------------------

local __system_params = nil
local __player_levels = nil
local __player_vip_levels = nil

------------------------------------------------------------

local function getSystemParam()
    if (__system_params == nil) then
        __system_params = shareda.query("system_params")
    end

    return __system_params
end

local function getPlayerLevels()
    if (__player_levels == nil) then
        __player_levels = shareda.query("player_levels")
    end

    return __player_levels
end

local function getVipLevels()
    if (__player_vip_levels == nil) then
        __player_vip_levels = shareda.query("vip_levels")
    end

    return __player_vip_levels
end

local function calculatePlayer(player)
    local levelData = getPlayerLevels()[player.level]
    local vipLevelData = getPlayerLevels()[player.vipLevel]
    local pneuma_interval = tonumber(getSystemParam()[SYSTEM_INIT_PNEUMA_INTERVAL]) or SYSTEM_INIT_PNEUMA_INTERVAL_V
    local strength_interval = tonumber(getSystemParam()[SYSTEM_INIT_STRENGTH_INTERVAL]) or SYSTEM_INIT_STRENGTH_INTERVAL_V

    local ap_max = math.max(vipLevelData.strength_max, player.ap_max)
    local mp_max = math.max(vipLevelData.pneuma_max, player.mp_max)
    player.ap_max = ap_max
    player.mp_max = mp_max

    local last_ap = player.ap
    local last_mp = player.mp

    local add_ap_num = math.max((player.int_now_time - player.ap_restore_time) / strength_interval, 0)
    if (last_ap < player.ap_max) then
        last_ap = last_ap + (add_ap_num * 1)
        last_ap = math.min(last_ap, player.ap_max)
        player.ap_restore_time = player.ap_restore_time + add_ap_num * strength_interval
    else
        player.ap_restore_time = player.int_now_time
    end
    if (last_ap >= player.ap_max) then
        player.ap = last_ap
        player.lastApTime = 0
        player.allApTime = 0
    else
        player.ap = last_ap
        player.lastApTime = math.max(strength_interval - (player.int_now_time - player.ap_restore_time), 0)
        player.allApTime = (player.ap_max - player.ap - 1) * strength_interval + player.lastApTime
    end

    local add_mp_num = math.max((player.int_now_time - player.mp_restore_time) / pneuma_interval, 0)
    if (last_mp < player.mp_max) then
        last_mp = last_mp + (add_mp_num * 1)
        last_mp = math.min(last_mp, player.mp_max)
        player.mp_restore_time = player.mp_restore_time + add_mp_num * pneuma_interval
    else
        player.mp_restore_time = player.int_now_time
    end
    if (last_mp >= player.mp_max) then
        player.mp = last_mp
        player.lastMpTime = 0
        player.allMpTime = 0
    else
        player.mp = last_mp
        player.lastMpTime = math.max(pneuma_interval - (player.int_now_time - player.mp_restore_time), 0)
        player.allMpTime = (player.mp_max - player.mp - 1) * pneuma_interval + player.lastMpTime
    end
end

local function calculatePlayerVipLevel(totalGolden, vipLevel)
    local i_level = vipLevel

	while (true) do

        local vipLevelData = getVipLevels()[i_level]

		if(vipLevelData == nil) then
			log.errf("get_vip_level_data invalid for %s!", vipLevel)
			i_level = i_level - 1
			break;
		end

		--充值黄金 小于 当前等级的所需黄金
		if (totalGolden < tonumber(vipLevelData.golden)) then
			i_level = i_level - 1
			break
		else

			i_level = i_level + 1
		end
	end

	i_level = math.max(i_level, 0)

	return i_level
end

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
        `Fstrength` as `ap`,
        `Fpneuma` as `mp`,
        `Fstrength_restore_time` as `ap_restore_time`,
        `Fpneuma_restore_time` as `mp_restore_time`,
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
        if (res.badresult) then
            log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %d", sql, res.err, res.errno, res.sqlstate)
        end
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

    player.select_level = player.level
    player.select_money = player.money
    player.ap_max = 0
    player.mp_max = 0

    calculatePlayer(player)

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

    local player = cachedata.get(key)
    calculatePlayer(player)

    return player
end

function cache.savePlayer(player)
    player.vipLevel = calculatePlayerVipLevel(player.total_gold, player.vipLevel)

    local key = CACHE_KEY_PLAYERS.."."..uid
    cachedata.set(key, player)

    local sql = string.format([[
    UPDATE zzb_player
    SET Fteam_name='%s',
        Flevel=%d,
        Fvip_level=%d,
        Fprestige=%d,
        Fmoney=%d,
        Ffame=%d,
        Fgold=%d,
        Fgift_gold=%d,
        Ftotal_gold=%d,
        Ftotal_gift_gold=%d,
        Ftotal_sign_gold=%d,
        Fstrength=%d,
        Fpneuma=%d,
        Fstrength_restore_time=%d,
        Fpneuma_restore_time=%d,
        Ffirst=%d,
        Finit=%d,
        Fmojing=%d,
        Frecharge_num=%d,
        Fbup=%d,
        Fbpp=%d,
        Fmbfc=%d,
        Frouse_num=%d,
        Frouse_last_time=%d
    WHERE Fuid=%d
    ]], player.name,
        player.level,
        player.vipLevel,
        player.exp,
        player.money,
        player.fame,
        player.gold,
        player.gift_gold,
        player.total_gold,
        player.total_gift_gold,
        player.total_sign_gold,
        player.ap,
        player.mp,
        player.ap_restore_time,
        player.mp_restore_time,
        player.first,
        player.init,
        player.mojing,
        player.recharge_num,
        player.bup,
        player.bpp,
        player.mbfc,
        player.rousing,
        player.rouse_last_time,
        player.uid
    )

    local db = databases:get("game")

    local res = db:query(sql)

    if (res.badresult) then
        log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %d", sql, res.err, res.errno, res.sqlstate)
    end

    -- TODO to finish this
    -- //银两成就
    -- if(s_player->money > s_player->select_money) {
    --     do_achieve(s_player->uid, CJ_HAVE_MONEY, s_player->money);
    -- }
    --
    -- //升级成就
    -- if(s_player->level > s_player->select_level) {
    --     do_achieve(s_player->uid, CJ_PLAYER_LEVELUP, 1);
    -- }
end

return cache
