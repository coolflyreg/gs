local skynet = require("skynet")

local sessions = {}  -- Saved Sessions
local CMD = {} -- Command list

function CMD.save(fd, uid, uname, sessionid)
    sessions[uid] = { fd = fd, uid = uid, uname = uname, sessionid = sessionid, beginTime = skynet.now() }
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











