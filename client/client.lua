--package.cpath = "luaclib/?.so"
--package.path = "lualib/?.lua;examples/?.lua"
package.cpath = package.cpath .. ";../3rd/skynet/luaclib/?.so;../server/luaclib/?.so"
package.path = package.path .. ";../3rd/skynet/lualib/?.lua;../common/?.lua;../common/lualib/?.lua"


if _VERSION ~= "Lua 5.3" then
	error "Use lua 5.3"
end

local socket = require "clientsocket"
local proto = require "protocols.proto"
local sproto = require "gssproto"
local sprotoCore = require "sproto.core"
local errorcode = require "protocols.errorcode"

require ("framework")

local host = sproto.new(proto.s2c):host "package"
local request = host:attach(sproto.new(proto.c2s))

local fd = assert(socket.connect("127.0.0.1", 8888))

local currentMessage = nil

local function send_package(fd, pack)
	local package = string.pack(">s2", pack)
	--print ("will send:", package)
	printHex(package)
	socket.send(fd, package)
end

local function unpack_package(text)
	local size = #text
	if size < 2 then
		return nil, text
	end
	local s = text:byte(1) * 256 + text:byte(2)
	if size < s+2 then
		return nil, text
	end

	return text:sub(3,2+s), text:sub(3+s)
end

local function recv_package(last)
	local result
	result, last = unpack_package(last)
	if result then
		return result, last
	end
	if not fd then
		return nil, last
	end

	local r = socket.recv(fd)
	if not r then
		return nil, last
	end
	if r == "" then
		-- error "Server closed"
		print "Server closed"
		fd = nil --assert(socket.connect("127.0.0.1", 8888))
	end
	return unpack_package(last .. r)
end

local session = 0

local function send_request(name, args)
	session = session + 1
	local str = request(name, args, session)
	send_package(fd, str)
	print("Request:", session)
end

local last = ""

local function print_request(name, args)
	print("REQUEST", name)
	if args then
		for k,v in pairs(args) do
			print(k,v)
		end
	end
end

local function print_response(session, args)
	print("RESPONSE", session)
	if args then
		-- for k,v in pairs(args) do
		-- 	if (k == "errno") then
		-- 		print(k, errorcode:getError(v))
		-- 	else
		-- 		print(k,v)
		-- 	end
		-- end
		dump(args)
	end
end

local function print_package(t, ...)
	if t == "REQUEST" then
		print_request(...)
	else
		assert(t == "RESPONSE")
		print_response(...)
	end
end

local function dispatch_package()
	while true do
		local v
		v, last = recv_package(last)
		if not v then
			break
		end

		printHex(v)
		local type, name, args, response, err_response = host:dispatch(v, 0, "error")
		print_package(type, name, args, response, err_response )
		if (currentMessage ~= nil) then
			currentMessage.response = args
		end
	end
end

local requests = {
	{ name = "account_register", value = { username = "gxte", password = "123456" } },
	{ name = "account_register", value = { username = "gxtest", password = "1234" } },
	{ name = "account_register", value = { username = "gxtest", password = "123456789012345678901" } },
	{ name = "account_register", value = { username = "gxtest", password = "123456" } },
	{ name = "account_register", value = { username = "gxte&^%$st", password = "123456" } },
	{ name = "account_auth", value = { username = "gxte", password = "123456" } },
	{ name = "account_auth", value = { username = "gxtest", password = "1234" } },
	{ name = "account_auth", value = { username = "gxtest", password = "123456789012345678901" } },
	{ name = "account_auth", value = { username = "gxtest", password = "123456" } },
	{ name = "account_auth", value = { username = "gxtest", password = "654321" } },
	{ name = "gameserver_list", value = nil },
	{ name = "player_names", value = nil },
}
-- while (#requests > 0) do
if (#requests > 0) then
	currentMessage = requests[1]
	table.remove(requests, 1)
	send_request(currentMessage.name, currentMessage.value)
end

while true do
	dispatch_package()
	if (currentMessage and currentMessage.response) then
		currentMessage = nil
	end
	if (currentMessage == nil) then
		if (#requests > 0) then
			currentMessage = requests[1]
			table.remove(requests, 1)
			if (fd == nil) then
				fd = assert(socket.connect("127.0.0.1", 8888))
			end
			send_request(currentMessage.name, currentMessage.value)
		else
			break
		end
	end
	socket.usleep(100)
end
