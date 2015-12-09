local skynet = require "skynet"

local service

skynet.start(function()
    service = skynet.uniqueservice("cachedatad")
end)

local cachedata = {}

function cachedata.register(key, func_get, func_update, func_remove)
    --skynet.call(service, "lua", "register", key, )
end

function cachedata.get(key)
end

function cachedata.update(key, obj)
end

function cachedata.remove(key)
end


return cachedata
