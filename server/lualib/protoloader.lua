local sprotoloader = require "gssprotoloader"


local loader = {
    TYPES = 0,
    GAME = 1,
    C2S = 1,
    S2C = 2,
    LOGIN = 3,
    LOGIN_C2S = 3,
    LOGIN_S2C = 4
}

function loader.init ()
    local proto = require("protocols.proto")
    sprotoloader.save (proto.types, loader.TYPES)
    sprotoloader.save (proto.c2s, loader.C2S)
    sprotoloader.save (proto.s2c, loader.S2C)
    sprotoloader.save (proto.login.c2s, loader.LOGIN_C2S)
    sprotoloader.save (proto.login.s2c, loader.LOGIN_S2C)
    -- don't call skynet.exit() , because sproto.core may unload and the global slot become invalid
end

function loader.load (index)
    local host = sprotoloader.load (index):host "package"
    local request = host:attach (sprotoloader.load (index + 1))
    return host, request
end

function loader.getProto (index)
    return sprotoloader.load (index)
end

return loader
