local skynet = require("skynet")
local syslog = require("syslog")

local sessions = {}  -- Saved Sessions
local CMD = {} -- Command list

function CMD.save(uid, uname, sessionid)
    syslog.infof("sessiond.save uid = %s", uid)
    sessions[uid] = {
        uid = uid,
        uname = uname,
        sessionid = sessionid,
        beginTime = skynet.time()
    }

    return sessions[uid]
end

function CMD.delete(uid)
    sessions[uid] = nil
    return true
end

function CMD.get(uid)
    return sessions[uid]
end

function CMD.exists(uid)
    return (sessions[uid] ~= nil)
end

function CMD.clear()
    sessions = {}
    return true
end

skynet.start(function()
    skynet.dispatch("lua", function(addr, typename, command, ...)
        local f = assert(CMD[command])
        skynet.ret(skynet.pack(f(...)))
    end)
end)
