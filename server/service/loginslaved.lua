local skynet = require "skynet"
local log = require "syslog"
local socket = require "socket"
local protoloader = require "protoloader"
local account_handler = require "agent.account_handler"

-----------------------------------------------------

local loginmasterd = 0
local slaveIndex = 0
local protohost = nil
local protorequest = nil
local session_timeout = 30
local connections = {}

-----------------------------------------------------

local function close (fd)
	if connections[fd] then
        connections[fd].close = true
		socket.close (fd)
        connections[fd].disconnected = true
		connections[fd] = nil
	end
end

local function read (fd, size)
	return socket.read (fd, size) or error ()
end

local function read_msg (fd)
	local s = read (fd, 2)
	local size = s:byte(1) * 256 + s:byte(2)
	local msg = read (fd, size)
	return protohost:dispatch (msg, size)
end

local function send_msg (fd, msg)
	local package = string.pack (">s2", msg)
	socket.write (fd, package)
end

----------------------------------------------------

local function request(name, args, response)
	local f = assert(account_handler.request[name])
	local r = f(args)
	if response then
		return response(r)
	end
end

----------------------------------------------------

skynet.register_protocol({
    name = "login",
    id = skynet.PTYPE_CLIENT,
    unpack = function (msg, sz)
        return protohost:dispatch(msg, sz)
    end,
    dispatch = function (_, _, type, ...)
        if type == "REQUEST" then
            local ok, result  = pcall(request, ...)
            if ok then
                if result then
                    send_msg(result)
                end
            else
                skynet.error(result)
            end
        else
            assert(type == "RESPONSE")
            error "There is no protocol support request client"
        end
    end
})
----------------------------------------------------

local CMD = {}

function CMD.init(master, index, config)
    loginmasterd = master
    slaveIndex = index
    session_timeout = config.session_timeout * 100
    protohost, protorequest = protoloader.load(protoloader.LOGIN)
end

function CMD.listen(fd, address)
    connections[fd] = { address = address, close = false, disconnected = false }
    log.infof("New Connection %d From %s", fd, addr)
	skynet.timeout (session_timeout, function ()
		if connections[fd] and connections[fd].address == address then
			log.warningf ("Connection %d From %s is TimeOut!", fd, address)
			close (fd)
		end
	end)

    socket.start(fd)
    socket.limit(fd, 8192)

    local type, name, args, response = read_msg (fd)
    assert (type == "REQUEST")
    log.infof("type = %s, name = %s, args = %s, response = %s", type, name, args, response)

    local f = account_handler.request[name]
    local msg = response(f(args))
    send_msg(fd, msg)

    close(fd)
    connections[fd] = nil
end

function CMD.stop()

end

-----------------------------------------------------
local traceback = debug.traceback

skynet.start(function()
    skynet.dispatch("lua", function(_, _, command, ...)
        local function pret (ok, ...)
            if not ok then
                log.warningf (...)
                skynet.ret ()
            else
                skynet.retpack (...)
            end
        end

        local f = assert(CMD[command])
        pret (xpcall (f, traceback, ...))
    end)
end)
