local skynet = require("skynet")
local handler = require("agent.handler")
local errorcode = require("protocols.errorcode")
local validator = require("protocols.validator")
local databases = require("db.databases")

--------------------------------------------------------------

-- //return: -1参数错误; -3无缓存; 0正确; -2uid不存在
-- static int cache_player_get(int uid, s_player_t *s_player)
-- {
--
-- 	if(uid<=0 || !s_player) {
-- 		return -1;
-- 	}
--
-- 	if(g_cache_player_valid != 1) {
-- 		return -3;
-- 	}
--
-- 	int iret = 0;
--
-- 	if(memcache_get_data(g_cache_player, (void *)&uid, sizeof(int), 0, (void *)s_player) < 0) {
--
-- 		s_player_t *s_tmp = (s_player_t *)GCALLOC(1, sizeof(s_player_t));
-- 		s_tmp->uid = uid;
--
-- 		iret = get_player_data_from_db(uid, s_tmp);
-- 		if(iret == 0) {
--
-- 			if(memcache_append_data(g_cache_player, (void *)&s_tmp->uid, sizeof(int), (void *)s_tmp, sizeof(s_player_t)) < 0) {
-- 				JOB_LOGGING(LOG_ERROR, "add uid(%d) player data to cache error, uid:%d", s_tmp->uid, uid);
-- 				return -1;
-- 			}
--
-- 			memcpy((void *)s_player, (void *)s_tmp, sizeof(s_player_t));
-- 		}
-- 	}
--
-- 	return iret;
-- }

--------------------------------------------------------------

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
