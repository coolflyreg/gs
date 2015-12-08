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
    SELECT `Fserverid` as `id`,
        `Fplatid` as `platform`,
        `Findex` as `index`,
        `Fname` as `name`,
        `Fhost` as `host`,
        `Fport` as `port`,
        `Fstate` as `state`
    FROM `zzb_game_server`
    ]])

-- local status, err = pcall(mysqldb.query,mysqldb,sqlstr) 记的捕获错误,有可能查询的时候链接已经断开.
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

    log.debugf("Loads %d Server Addresses.", #res)
    return "server_list", res
end

function COMMONDATA.team_names()
    local db = databases:get("gameinfo")

    local sql = [[
    SELECT `Fname` as `name`, `Fpos` as `pos` FROM `zzb_info_team_name` ORDER BY `Fpos`
    ]]

    local res = db:query(sql)

    if res.badresult or not res or #res == 0 then
        if res.badresult then
            log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %s", sql, res.err, res.errno, res.sqlstate)
        else
            log.warningf("There is no team's name data in database.")
        end
        return
    end

    local first = {}
    local second = {}
    local third = {}

    for k, v in pairs(res) do
        if (v.pos == 0) then
            table.insert(first, v.name)
        elseif (v.pos == 1) then
            table.insert(second, v.name)
        else
            table.insert(third, v.name)
        end
    end

    log.debugf("Loads %d First Names, %d Middle Names, %d Given Names.", #first, #second, #third)
    return "team_names", { first = first, second = second, third = third }
end

function COMMONDATA.player_levels()
    local db = databases:get("gameinfo")

    local sql = [[
    SELECT
        `Flevel` as `level`,
        `Fprestige_upgrade` as `prestige_upgrade`,
        `Fprestige_gain` as `prestige_gain`,
        `Fpvp_exp` as `pvp_exp`,
        `Fpvp_money` as `pvp_money`,
        `Fcharacter_max_level` as `character_max_level`,
        `Fstronger_max_level` as `stronger_max_level`,
        `Fbeast_max_level` as `beast_max_level`,
        `Fgold_gain` as `gold_gain`,
        `Fmoney_gain` as `money_gain`,
        `Fstrength_max` as `strength_max`,
        `Fpneuma_max` as `pneuma_max`,
        `Fbattle_num` as `battle_num`,
        `Fbeast_exp1` as `beast_exp1`,
        `Fbeast_exp2` as `beast_exp2`,
        `Fbeast_exp3` as `beast_exp3`,
        `Fbeast_exp4` as `beast_exp4`,
        `Fbeast_exp5` as `beast_exp5`
    FROM `zzb_info_level_data`
    ]]

    local res = db:query(sql)

    if res.badresult or not res or #res == 0 then
        if res.badresult then
            log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %s", sql, res.err, res.errno, res.sqlstate)
        else
            log.warningf("There is no player level data in database.")
        end
        return
    end

    local data = {}

    local count = 0
    for k, v in pairs(res) do
        data[v.level] = v
        count = count + 1
    end

    log.debugf("Load %d Player Level Infos", count)
    return "player_levels", data
end

function COMMONDATA.vip_levels()
    local db = databases:get("gameinfo")

    local sql = [[
    SELECT
        `Fvip_level` as `vip_level`,
        `Fgolden` as `golden`,
        `Fdesc` as `desc`,
        `Fstrength_max` as `strength_max`,
        `Fpneuma_max` as `pneuma_max`,
        `Fbeast_point_buy_max` as `beast_point_buy_max`,
        `Fequip_upgrade_max` as `equip_upgrade_max`,
        `Fequip_upgrade_min` as `equip_upgrade_min`,
        `Fstrength_count` as strength_count,
        `Fpneuma_count` as pneuma_count,
        `Fcompetition_max` as `competition_max`,
        `Fcompetition_add_max` as `competition_add_max`,
        `Fcombat_refresh_max` as `combat_refresh_max`,
        `Fcombat_add_exp` as `combat_add_exp`,
        `Fcombat_add_money` as `combat_add_money`,
        `Fcombat_skip` as `combat_skip`,
        `Fcombat_skip_mopup` as `combat_skip_mopup`,
        `Fequip_renew_ratio` as `equip_renew_ratio`,
        `Fgift_item_id` as `gift_item_id`,
        `Fpost_gift_gold_max` as `post_gift_gold_max`,
        `Fpost_gift_gold_min` as `post_gift_gold_min`,
        `Fenyuan_max` as `enyuan_max`,
        `Flottery_bd_num` as `lottery_bd_num`,
        `Flottery_bai_max` as `lottery_bai_max`,
        `Flottery_bai_min` as `lottery_bai_min`,
        `Flottery_qian_max` as `lottery_qian_max`,
        `Flottery_qian_min` as `lottery_qian_min`
    FROM `zzb_info_vip_level_data`
    ]]

    local res = db:query(sql)

    if res.badresult or not res or #res == 0 then
        if res.badresult then
            log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %s", sql, res.err, res.errno, res.sqlstate)
        else
            log.warningf("There is no vip level data in database.")
        end
        return
    end

    local data = {}

    local count = 0
    for k, v in pairs(res) do
        data[v.vip_level] = v
        count = count + 1
    end

    log.debugf("Load %d Player VIP Level Infos", count)
    return "vip_levels", data
end

function COMMONDATA.system_params ()
    local db = databases:get("gameinfo")

    local sql = [[
    SELECT `Fid` as `id`, `Fvalue` as `value` FROM `zzb_info_system_para`
    ]]

    local res = db:query(sql)

    if res.badresult or not res or #res == 0 then
        if res.badresult then
            log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %s", sql, res.err, res.errno, res.sqlstate)
        else
            log.warningf("There is no system params data in database.")
        end
        return
    end

    log.debugf("Load %d System Params.", #res)
    return "system_params", res
end

---------------------------------------------

local CMD = {}

function CMD.init()
    local databaseConfig = require("config.database")
    databases:init("account", databaseConfig.account)
    databases:init("gameinfo", databaseConfig.gameinfo)

    for k, v in pairs(COMMONDATA) do
        if (type(v) == "function") then
            local name, data = v()
            sharedata.new(name, data)
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
