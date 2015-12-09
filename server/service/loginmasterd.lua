local skynet = require "skynet"
local log = require "syslog"
local socket = require "socket"

local loginslaveds = {}

local CMD = {}

function CMD.init(config)
    local slaveCount = config.count
    log.infof("Starting %d loginslaved", slaveCount)

    for i = 1, slaveCount do
        local slave = skynet.newservice("loginslaved")
        skynet.call(slave, "lua", "init", skynet.self(), i, config, "account")
        table.insert(loginslaveds, slave)
    end

    local host = config.host or "0.0.0.0"
    local port = assert(tonumber(config.port))
    local sock = socket.listen(host, port)

    local balance = 1
    socket.start(sock, function(fd, address)
        local slave = loginslaveds[balance]
        balance = balance + 1
        if (balance > slaveCount) then balance = 1 end

        skynet.call(slave, "lua", "listen", fd, address)
    end)
end

skynet.start(function()
    skynet.dispatch("lua", function(_, _, command, ...)
        local f = assert(CMD[command])
        skynet.retpack(f(...));
    end)
end)
