local skynet = require "skynet"
local queue = require "skynet.queue"
local sharemap = require "sharemap"
local socket = require "socket"

local syslog = require "syslog"
local protoloader = require "protoloader"


local beasts_handler = require "agent.beasts_handler"
local contests_handler = require "agent.contests_handler"
local equipments_handler = require "agent.equipments_handler"
local formations_handler = require "agent.formations_handler"
local fragments_handler = require "agent.fragments_handler"
local gameserver_handler = require "agent.gameserver_handler"
local players_handler = require "agent.players_handler"
local skills_handler = require "agent.skills_handler"
local socials_handler = require "agent.socials_handler"


local gamed = tonumber (...)
local database

local host, proto_request = protoloader.load (protoloader.GAME)

--[[
.user {
	fd : integer
	account : integer

	character : character
	world : integer
	map : integer
}
]]

local user

local function send_msg (fd, msg)
	local package = string.pack (">s2", msg)
	socket.write (fd, package)
end

local user_fd
local session = {}
local session_id = 0
local function send_request (name, args)
	session_id = session_id + 1
	local str = proto_request (name, args, session_id)
	send_msg (user_fd, str)
	session[session_id] = { name = name, args = args }
end

local function kick_self ()
	skynet.call (gamed, "lua", "kick", skynet.self (), user_fd)
end

local last_heartbeat_time
local HEARTBEAT_TIME_MAX = 0 -- 60 * 100
local function heartbeat_check ()
	if HEARTBEAT_TIME_MAX <= 0 or not user_fd then return end

	local t = last_heartbeat_time + HEARTBEAT_TIME_MAX - skynet.now ()
	if t <= 0 then
		syslog.warning ("heatbeat check failed")
		kick_self ()
	else
		skynet.timeout (t, heartbeat_check)
	end
end

local traceback = debug.traceback
local REQUEST
local function handle_request (name, args, response, err_response)
	local f = REQUEST[name]
	if f then
		local ok, ret = xpcall (f, traceback, args)
		if not ok then
			syslog.warningf ("handle message(%s) failed : %s", name, ret)
			kick_self ()
		else
			last_heartbeat_time = skynet.now ()
			if response and ret then
                if (ret.errno ~= nil) then
                    send_msg (user_fd, err_response(ret))
                else
    				send_msg (user_fd, response (ret))
                end
			end
		end
	else
		syslog.warningf ("unhandled message : %s", name)
		kick_self ()
	end
end

local RESPONSE
local function handle_response (id, args)
	local s = session[id]
	if not s then
		syslog.warningf ("session %d not found", id)
		kick_self ()
		return
	end

	local f = RESPONSE[s.name]
	if not f then
		syslog.warningf ("unhandled response : %s", s.name)
		kick_self ()
		return
	end

	local ok, ret = xpcall (f, traceback, s.args, args)
	if not ok then
		syslog.warningf ("handle response(%d-%s) failed : %s", id, s.name, ret)
		kick_self ()
	end
end

skynet.register_protocol {
	name = "client",
	id = skynet.PTYPE_CLIENT,
	unpack = function (msg, sz)
		return host:dispatch (msg, sz)
	end,
	dispatch = function (_, _, type, ...)
		if type == "REQUEST" then
			handle_request (...)
		elseif type == "RESPONSE" then
			handle_response (...)
		else
			syslog.warningf ("invalid message type : %s", type)
			kick_self ()
		end
	end,
}

local CMD = {}

function CMD.open (fd, login_result)
	local name = string.format ("agent:uid:%d", login_result.uid)
	syslog.debug ("agent opened")

	user = {
		fd = fd,
		account = login_result,
		REQUEST = {},
		RESPONSE = {},
		CMD = CMD,
		send_request = send_request,
	}
	user_fd = user.fd
	REQUEST = user.REQUEST
	RESPONSE = user.RESPONSE

	character_handler:register (user)

	last_heartbeat_time = skynet.now ()
	heartbeat_check ()
end

function CMD.close ()
	syslog.debug ("agent closed")

	local account
	if user then
		account = user.account

		user = nil
		user_fd = nil
		REQUEST = nil
	end

	skynet.call (gamed, "lua", "close", skynet.self (), account)
end

function CMD.kick ()
	error ()
	syslog.debug ("agent kicked")
	skynet.call (gamed, "lua", "kick", skynet.self (), user_fd)
end

skynet.start (function ()
	skynet.dispatch ("lua", function (_, _, command, ...)
		local f = CMD[command]
		if not f then
			syslog.warningf ("unhandled message(%s)", command)
			return skynet.ret ()
		end

		local ok, ret = xpcall (f, traceback, ...)
		if not ok then
			syslog.warningf ("handle message(%s) failed : %s", command, ret)
			kick_self ()
			return skynet.ret ()
		end
		skynet.retpack (ret)
	end)
end)
