
local pool = {
}



local mt = { __index = pool }
--[[
config{
    init_count = 5,
    on_create = function() end
}
]]
function pool.create(config)
    local self = setmetatable( {}, mt )

    self._objects = {}
    self._objectsInUse = {}

    self.init_count = assert(config.init_count)
    self.on_create = assert(config.on_create)

    local i
    for i = 1, self.init_count do
        local poolObj = assert(self.on_create())
        table.insert(self._objects, poolObj)
    end

    return self
end

function pool.new(self)
    if (#self._objects > 0) then
        local poolObj = self._objects[1]
        table.remove(self._objects, 1)
        table.insert(self._objectsInUse, poolObj)
        return poolObj
    else
        local poolObj = assert(self.on_create())
        table.insert(self._objectsInUse, poolObj)
        return poolObj
    end
end

function pool.destroy(self, poolObj)
    local k = nil
    local v = nil
    local hasObj = false
    for k, v in pairs(self._objectsInUse) do
        if (poolObj == v) then
            hasObj = true
            break
        end
    end
    if (hasObj) then
        table.insert(self._objects, v)
        table.remove(self._objectsInUse, k)
    else
        error("Will destroy object that is not pool object.")
    end
end

function pool.size(self)
    return #self._objects + #self._objectsInUse
end

return pool
