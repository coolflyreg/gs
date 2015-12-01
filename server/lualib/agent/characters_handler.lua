local skynet = require("skynet")
local handler = require("agent.handler")

local REQUEST = {}
handler = handler.new(REQUEST)

function REQUEST.characters_all()
    -- TODO fetch all characters to array
    -- TODO fetch all souls to array
    -- TODO fetch all starPoses to array
    return { characters = {}, souls = {}, stars = {} }
end

function REQUEST.characters_one(args)
    error("<Request.characters_one> Not Implemented")
    local id = args.id or error("<Request.characters_one>'s arguments doesn't contain id.")
    
    return {character = {}}
end

function REQUEST.characters_transferExp(args)
    error("<Request.characters_transferExp> Not Implemented")
end

function REQUEST.characters_assignEquip(args)
    error("<Request.characters_assignEquip> Not Implemented")
end

function REQUEST.characters_changeEquip(args)
    error("<Request.characters_changeEquip> Not Implemented")
end

function REQUEST.characters_UnassignEquip(args)
    error("<Request.characters_UnassignEquip> Not Implemented")
end

function REQUEST.characters_assignSkill(args)
    error("<Request.characters_assignSkill> Not Implemented")
end

function REQUEST.characters_changeSkill(args)
    error("<Request.characters_changeSkill> Not Implemented")
end

function REQUEST.characters_unassignSkill(args)
    error("<Request.characters_unassignSkill> Not Implemented")
end

function REQUEST.characters_newStarPos(args)
    error("<Request.characters_newStarPos> Not Implemented")
end

function REQUEST.characters_upgradeStarPos(args)
    error("<Request.characters_upgradeStarPos> Not Implemented")
end

function REQUEST.characters_train(args)
    error("<Request.characters_train> Not Implemented")
end

function REQUEST.characters_acceptTrain(args)
    error("<Request.characters_acceptTrain> Not Implemented")
end

function REQUEST.characters_declineTrain(args)
    error("<Request.characters_declineTrain> Not Implemented")
end

function REQUEST.characters_breakThroughs(args)
    error("<Request.characters_breakThroughs> Not Implemented")
end

function REQUEST.characters_recruit(args)
    error("<Request.characters_recruit> Not Implemented")
end

function REQUEST.characters_recruitInfo()
    error("<Request.characters_recruitInfo> Not Implemented")
end

function REQUEST.characters_shopRecruit(args)
    error("<Request.characters_shopRecruit> Not Implemented")
end

return handler