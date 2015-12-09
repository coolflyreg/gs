local skynet = require("skynet")
require("framework")

-----------------------------------------------------

local _functions = {}

-----------------------------------------------------

local CMD = {}

local function buildFunction(func)
    if (func and func ~= "") then
        return require(func)
    end

    return nil
end

function CMD.register(key, func_get, func_update, func_remove)

    local get = buildFunction(func_get)
    local update = buildFunction(func_update)
    local remove = buildFunction(func_remove)

    _functions[key] = {
        get = get,
        update = update,
        remove = remove
    }
end

function CMD.exists(key)
    return (not _functions[key])
end

function CMD.get(key, ...)
    local fs = _functions[key]
    if (fs and fs.get) then
        return fs.get(...)
    end

    return nil
end

function CMD.update(key, ...)
    local fs = _functions[key]
    if (fs and fs.update) then
        fs.update(...)
    end
end

function CMD.remove(key, ...)
    local fs = _functions[key]
    if (fs and fs.remove) then
        fs.remove(...)
    end
end

skynet.start(function()
    skynet.dispatch("lua", function(_, _, command, ...)
        local f = assert(CMD[command])
        skynet.ret(skynet.pack(f(...)))
    end)
end)
