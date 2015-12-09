local databases = require("databases")

local function getPlayerFromDatabase(uid)

    local sql = string.format([[
    SELECT
        Fuid,
        Fteam_name,
        Flevel,
        Fvip_level,
        Fprestige,
        Fmoney,
        Fgold,
        Fgift_gold,
        Ftotal_gold,
        Ftotal_gift_gold,
        Ftotal_sign_gold,
        Fstrength,
        Fpneuma,
        Fstrength_restore_time,
        Frecharge_num,
        Fbup,
        Fbpp,
        Fmbfc,
        Fmojing,
        Ffame,
        Frouse_num,
        Frouse_last_time,
        DATE(FROM_UNIXTIME(Frouse_last_time))+0,
        CURDATE()+0
        Fcreate_time
    FROM zzb_player WHERE Fuid=%d ]], uid);

    local db = databases.get("game")

    local res = db:query(sql)
    
end


return getPlayerFromDatabase
