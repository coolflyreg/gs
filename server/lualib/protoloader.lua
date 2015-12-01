local sprotoloader = require "sprotoloader"

local proto = require("protocols.proto")

local loader = {
    TYPES = 0,
    C2S = 1,
    S2C = 2
}

function loader.init ()
    sprotoloader.save (proto.types, loader.TYPES)
    sprotoloader.save (proto.c2s, loader.C2S)
    sprotoloader.save (proto.s2c, loader.S2C)
    -- don't call skynet.exit() , because sproto.core may unload and the global slot become invalid
end

function loader.load (index)
    local host = sprotoloader.load (index):host "package"
    local request = host:attach (sprotoloader.load (index + 1))
    return host, request
end

return loader
