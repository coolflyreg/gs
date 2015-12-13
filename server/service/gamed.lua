local skynet = require "skynet"
local pool = require "pool"
local gameserver = require "serves.gameserver"
require("framework")

-----------------------------------------------------

local agentPool = nil
local online_account = {}

-----------------------------------------------------

local gamed = {}

function gamed.open(config)
    syslog.notice ("gamed opened")

    local self = skynet.self ()

    local function poolAgent_oncreate()
        return skynet.newservice("agent", self)
    end

    local poolConfig = {
        init_count = config.agentPoolSize or 1024,
        on_create = poolAgent_oncreate
    }

    agentPool = pool.create(poolConfig)
end

function gamed.command_handler(cmd, ...)
    local CMD = {}
    function CMD.close (agent, account)
        syslog.debugf ("agent %d recycled", agent)

        online_account[account] = nil
        agentPool:destory(agent)
    end

    function CMD.kick (agent, fd)
        gameserver.kick (fd)
    end

    local f = assert (CMD[cmd])
    return f (...)
end

-----------------------------------------------------

-----------------------------------------------------

gameserver.start(gamed)
