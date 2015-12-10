local skynet = require("skynet")
local log = require("syslog")
require("framework")

-----------------------------------------------------

local function buildFunction(func)
    if (func and func ~= "") then
        return require(func)
    end

    return nil
end

local _functions = {}
local _functions_mt = {
    __index = function(t, k)
        local v = nil
        if (k == "get" or k == "update" or k == "remove") then
            v = rawget(t, k)
            if (v ~= nil) then
                return v
            else
                v = buildFunction(rawget(t, "func_"..k))
                rawset(t, k, v)
                return v
            end
        else
            return rawget(t, k)
        end
    end,
    __newindex = function(t, k, v)
        rawset(t, k, v)
    end
}
--setmetatable(_functions, _functions_mt)

local _data = {}
local _data_mt = {
    __index = function(t, k)
        if (rawget(t, k) == nil) then
            rawset(t, k, {})
        end
        return rawget(t, k)
    end,
    __newindex = function(t, k, v)
        rawset(t, k, v)
    end
}
setmetatable(_data, _data_mt)

-----------------------------------------------------

local CMD = {}

function CMD.register(key, func_get, func_update, func_remove)

    -- local get = buildFunction(func_get)
    -- local update = buildFunction(func_update)
    -- local remove = buildFunction(func_remove)

    _functions[key] = {
        func_get = func_get,
        func_update = func_update,
        func_remove = func_remove
    }
    setmetatable(_functions[key], _functions_mt)
    dump(_functions[key])
end

function CMD.exists(key)
    return (_functions[key] ~= nil)
end

function CMD.existsValue(key, objKey)
    return (not data[key][objKey])
end

function CMD.get(key, objKey, ...)
    log.infof("cachedatad.CMD.get(%s, %s)", key, objKey)
    local fs = _functions[key]
    local result = _data[key][objKey]
    if (result == nil and fs and fs.get) then
        result = fs.get(objKey, ...)
        _data[key][objKey] = result
    end

    return result
end

function CMD.update(key, ...)
    local fs = _functions[key]
    local result = _data[key][objKey]
    if (result == nil and fs and fs.update) then
        result = fs.update(...)
        _data[key][objKey] = result
    end
end

function CMD.remove(key, objKey, ...)
    local fs = _functions[key]
    if (fs and fs.remove) then
        _data[key][objKey] = nil
        fs.remove(objKey, ...)
    end
end

skynet.start(function()
    skynet.dispatch("lua", function(_, _, command, ...)
        local f = assert(CMD[command])
        skynet.ret(skynet.pack(f(...)))
    end)
end)
