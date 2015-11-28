
LinkNode = class("LinkNode", nil)
LinkNode.__index = LinkNode
LinkNode.first = nil
LinkNode.next = nil
LinkNode.node = nil

function LinkNode:append(node)
    if (not iskindof(node, "LinkNode")) then return end
    
    local endNode = self:findEndNode()
    endNode.next = node
    node.first = self.first
    node.next = self.first
    
end

function LinkNode:setFirst()
    local first = self
    local node = self
    
    while (first ~= node.first) do
        node.first = self
        node = node.next
    end
end

function LinkNode:findEndNode()
    local node = self
    while (node.next ~= node.next.first) do
        node = node.next
    end
    
    return node
end

function LinkNode:init(data)
    self.first = self
    self.next = self
    self.node = data
    return self
end
