local skynet = require("skynet")
local handler = require("agent.handler")

local REQUEST = {}
handler = handler.new(REQUEST)

function REQUEST.contest_info()
    error("<Request.contest_info> Not Implemented")
end

function REQUEST.contest_playerCharacters()
    error("<Request.contest_playerCharacters> Not Implemented")
end

function REQUEST.contest_refresh(args)
    error("<Request.contest_refresh> Not Implemented")
end

function REQUEST.contest_reward()
    error("<Request.contest_reward> Not Implemented")
end

function REQUEST.contest_ranklist(args)
    error("<Request.contest_ranklist> Not Implemented")
end

function REQUEST.contest_rankCombat(args)
    error("<Request.contest_rankCombat> Not Implemented")
end

function REQUEST.contest_achievementInfo()
    error("<Request.contest_achievementInfo> Not Implemented")
end

function REQUEST.contest_rankReward(args)
    error("<Request.contest_rankReward> Not Implemented")
end

function REQUEST.contest_rankLevelReward(args)
    error("<Request.contest_rankLevelReward> Not Implemented")
end

function REQUEST.contest_combat(args)
    error("<Request.contest_combat> Not Implemented")
end

return handler