local skynet = require "skynet"

local service

skynet.init(function()
    service = skynet.uniqueservice("cachedatad")
end)

local cachedata = {}

function cachedata.register(key, func_get, func_update, func_remove)
    skynet.call(service, "lua", "register", key, func_get, func_update, func_remove)
end

function cachedata.exists(key)
    return skynet.call(service, "lua", "exists", key)
end

function cachedata.get(key)
    local proxy = { key = key }

    proxy.get = function(self, ...)
        skynet.call(service, "lua", "get", self.key, ...)
    end

    proxy.update = function(self, ...)
        skynet.call(service, "lua", "update", self.key, ...)
    end

    proxy.remove = function(self, ...)
        skynet.call(service, "lua", "remove", self.key, ...)
    end
end


return cachedata
