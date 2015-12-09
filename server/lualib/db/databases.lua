local skynet = require("skynet")
local log = require "syslog"
local mysql = require "mysql"

local service

skynet.init(function()
    service = skynet.uniqueservice("databased")
end)

local databases = {}

function databases.init(self, name, config, poolsize)
    if (not poolsize) then
        poolsize = 5
    end
    skynet.call(service, "lua", "init", name, config, poolsize)
end

function databases.get(self, name)
    local dbProxy = { name = name }
    dbProxy.query = function(self, sql)
        return skynet.call(service, "lua", "query", self.name, sql)
    end

    return dbProxy
end

return databases
