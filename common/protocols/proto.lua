local baseTypes = require("protocols.types")

--[[]
local account = require("protocols.account")
local gameserver = require("protocols.gameserver")
local userguide = require("protocols.userguide")
local player = require("protocols.player")
]]

local protocols = {}
protocols[0] = require("protocols.account")
protocols[1] = require("protocols.gameserver")
protocols[2] = require("protocols.userguide")
protocols[3] = require("protocols.player")
--protocols[4] = require("protocols.campaign")

local sparser = require("sprotoparser")

local proto = {}

local types = [[]]
types = types .. baseTypes
for i, v in ipairs(protocols) do
    types = types .. v.types
end

local c2s = [[]]
c2s = c2s .. types
for i, v in ipairs(protocols) do
    c2s = c2s .. v.c2s
end

local s2c = [[]]
s2c = s2c .. types
for i, v in ipairs(protocols) do
    s2c = s2c .. v.s2c
end

proto.types = types
proto.c2s = sparser.parse (c2s)

return proto

