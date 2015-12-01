local baseTypes = require("protocols.types")

local protocols = {
    require("protocols.account"),      -- 10XX
    require("protocols.gameserver"),   -- 11XX
    require("protocols.userguide"),    -- 12XX
    require("protocols.player"),       -- 13XX
    require("protocols.campaign"),     -- 14XX
    require("protocols.characters"),   -- 15XX
    require("protocols.formation"),    -- 16XX
    require("protocols.equipment"),    -- 17XX
    require("protocols.skill"),        -- 18XX
    require("protocols.beast"),        -- 19XX
    require("protocols.social"),       -- 20XX
    require("protocols.fragment"),     -- 21XX
    require("protocols.contest"),      -- 22XX
    require("protocols.package"),      -- 23XX
    require("protocols.shop"),         -- 24XX
    require("protocols.assistant"),    -- 25XX
    require("protocols.messages"),     -- 26XX
    require("protocols.gifts"),        -- 27XX
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

proto.types = sparser.parse(types)
proto.c2s = sparser.parse (c2s)
proto.s2c = sparser.parse (s2c)

return proto

