
EventHandler = class("EventHandler")
EventHandler.__index = EventHandler

EventHandler.handlers = {}


function EventHandler:add(func)
    if (func == nil or type(func) ~= "function") then return false end
    
    if (self:indexOfHandler(func) > 0) then return false end
    
    local list = self.handlers
    list[#list + 1] = func
    
    return true
end

function EventHandler:remove(func)
    local index = self:indexOfHandler(func)
    if (index == 0) then return end
    
    local list = self.handlers
    table.remove(list, index)
end

function EventHandler:clear()
    local list = self.handlers
    while (#list > 0) do
        list[1] = nil
    end
end

function EventHandler:indexOfHandler(handler) -- Integer 0,1,2.....
    local list = self.handlers
    local i = 1
    
    for i = 1, #list do
        if (list[i] == handler) then return i end
    end
    
    return 0
end

function EventHandler:raiseEvent(event, args)
    local list = self.handlers
    
    for i = 1, #list do
        if (list[i] ~= nil) then
            list[i](event, args)
        end
    end
end