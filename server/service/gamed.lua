local skynet = require "skynet"
local pool = require "pool"
local gameserver = require "servers.gameserver"
local log = require "syslog"
require("framework")

-----------------------------------------------------

local agentPool = nil
local online_account = {}

-----------------------------------------------------

local gamed = {}

function gamed.open(config)
    log.notice ("gamed opened")

    local self = skynet.self ()

    local function poolAgent_oncreate()
        return skynet.newservice("agent", self)
    end

    local poolConfig = {
        init_count = config.agentPoolSize or 256,
        on_create = poolAgent_oncreate
    }

    agentPool = pool.create(poolConfig)
end

function gamed.command_handler(cmd, ...)
    local CMD = {}
    function CMD.close (agent, account)
        log.debugf ("agent %d recycled", agent)

        online_account[account] = nil
        agentPool:destory(agent)
    end

    function CMD.kick (agent, fd)
        gameserver.kick (fd)
    end

    local f = assert (CMD[cmd])
    return f (...)
end

function gamed.auth (session, token)
	return skynet.call (logind, "lua", "verify", session, token)
end

function gamed.login (fd, account)
	local agent = online_account[account]
	if agent then
		log.warningf ("multiple login detected for account %d", account)
		skynet.call (agent, "lua", "kick", account)
	end

	-- if #pool == 0 then
	-- 	agent = skynet.newservice ("agent", skynet.self ())
	-- 	syslog.noticef ("pool is empty, new agent(%d) created", agent)
	-- else
	-- 	agent = table.remove (pool, 1)
	-- 	syslog.debugf ("agent(%d) assigned, %d remain in pool", agent, #pool)
	-- end
    agent = agentPool:new()
	online_account[account] = agent

	skynet.call (agent, "lua", "open", fd, account)
	gameserver.forward (fd, agent)
	return agent
end
-----------------------------------------------------

-----------------------------------------------------

gameserver.start(gamed)
