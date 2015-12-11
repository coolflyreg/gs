local skynet = require("skynet")
local log = require("syslog")
require("framework")

-----------------------------------------------------

-- local function buildFunction(func)
--     if (func and func ~= "") then
--         return require(func)
--     end
--
--     return nil
-- end

-- local _functions = {}
-- local _functions_mt = {
--     __index = function(t, k)
--         local v = nil
--         if (k == "get" or k == "update" or k == "remove") then
--             v = rawget(t, k)
--             if (v ~= nil) then
--                 return v
--             else
--                 v = buildFunction(rawget(t, "func_"..k))
--                 rawset(t, k, v)
--                 return v
--             end
--         else
--             return rawget(t, k)
--         end
--     end,
--     __newindex = function(t, k, v)
--         rawset(t, k, v)
--     end
-- }
--setmetatable(_functions, _functions_mt)

local _data = {}
local _data_mt = {
    __index = function(t, k)
        if (rawget(t, k) == nil) then
            local newtable = {}
            setmetatable(newtable, _data_mt)
            rawset(t, k, newtable)
        end
        return rawget(t, k)
    end,
    __newindex = function(t, k, v)
        rawset(t, k, v)
    end
}
setmetatable(_data, _data_mt)

-----------------------------------------------------

local function findDataTable(key)
    local components = string.split(key, ".")
    if (#components == 1) then
        return _data, components
    end

    local index = 1
    local theTable = _data
    for index = 1, #components - 1 do
        theTable = _data[components[index]]
    end

    return theTable, components
end

-----------------------------------------------------

local CMD = {}

-- function CMD.register(key, func_get, func_update, func_remove)
--
--     -- local get = buildFunction(func_get)
--     -- local update = buildFunction(func_update)
--     -- local remove = buildFunction(func_remove)
--
--     _functions[key] = {
--         func_get = func_get,
--         func_update = func_update,
--         func_remove = func_remove
--     }
--     setmetatable(_functions[key], _functions_mt)
--     dump(_functions[key])
-- end

-- function CMD.exists(key)
--     return (_functions[key] ~= nil)
-- end



function CMD.exists(key)
    local theTable, components = findDataTable(key)

    return (rawget(theTable, components[#components]) ~= nil)
end

function CMD.get(key)
    local theTable, components = findDataTable(key)

    return rawget(theTable, components[#components])
end

function CMD.set(key, value)
    local theTable, components = findDataTable(key)

    theTable[components[#components]] = value
end

function CMD.remove(key)
    local theTable, components = findDataTable(key)

    theTable[components[#components]] = nil
end

skynet.start(function()
    skynet.dispatch("lua", function(_, _, command, ...)
        local f = assert(CMD[command])
        skynet.ret(skynet.pack(f(...)))
    end)
end)
