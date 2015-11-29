local baseTypes = require("protocols.types")

local protocols = {
    require("protocols.account"),      -- 10XX
    require("protocols.gameserver"),   -- 11XX
    require("protocols.userguide"),    -- 12XX
    require("protocols.player"),       -- 13XX
    require("protocols.characters"),   -- 15XX
    require("protocols.equipment"),     -- 17XX
    require("protocols.skill"),         -- 18XX
}
--protocols[count++] = require("protocols.campaign")

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
proto.s2c = sparser.parse (s2c)

return proto

