local skynet = require "skynet"

local service

skynet.init(function()
    service = skynet.uniqueservice("cachedatad")
end)

local cachedata = {}
--
-- function cachedata.register(key, func_get, func_update, func_remove)
--     skynet.call(service, "lua", "register", key, func_get, func_update, func_remove)
-- end

function cachedata.exists(key)
    return skynet.call(service, "lua", "exists", key)
end

function cachedata.get(key)
    return skynet.call(service, "lua", "get", key)
end

function cachedata.set(key, value)
    return skynet.call(service, "lua", "set", key, value)
end

function cachedata.remove(key)
    return skynet.call(service, "lua", "remove", key)
end

return cachedata
