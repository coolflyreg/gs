local json = require("cjson")

local function createFightDamage() 
    local damage = {0,0,0,0,0}
    local mt = {
        __index = function(t,k)
            if (type(k) == "integer") then
                return t[k]
            elseif (type(k) == "string") then
                if (k == "cindex") then return t[1]
                elseif (k == "amount") then return t[2]
                elseif (k == "life") then return t[3]
                elseif (k == "maxLife") then return t[4]
                elseif (k == "feedback") then return t[5]
                end
            end
                return rawget(t, k)
        end,
        __newindex = function(t,k,v)
            if (type(k) == "integer") then
                t[k] = v
            elseif (type(k) == "string") then
                if (k == "cindex") then t[1] = v 
                elseif (k == "amount") then t[2] = v 
                elseif (k == "life") then t[3] = v 
                elseif (k == "maxLife") then t[4] = v 
                elseif (k == "feedback") then t[5] =v 
                else rawset(t,k,v) end
            else
                rawset(t,k,v)
            end
        end
    }
    
    setmetatable(damage, mt)
    
    damage.toObject = function(self)
        return {self[1], self[2], self[3], self[4], self[5]}
    end
    
    damage.fromObject = function(self, array)
        self[1] = array[1]
        self[2] = array[2]
        self[3] = array[3]
        self[4] = array[4]
        self[5] = array[5]
    end
    
    return damage
    
end


local function createFightAction()

    local action = {0,0,"",0,0,{}}
    local mt = {
        __index = function(t,k)
            if (type(k) == "integer") then
                return t[k]
            elseif (type(k) == "string") then
                if (k == "side") then return t[1]
                elseif (k == "cindex") then return t[2]
                elseif (k == "skillId") then return t[3]
                elseif (k == "counter") then return t[4]
                elseif (k == "restore") then return t[5]
                elseif (k == "damages") then return t[6]
                end
            end
                return rawget(t, k)
        end,
        __newindex = function(t,k,v)
            if (type(k) == "integer") then
                t[k] = v
            elseif (type(k) == "string") then
                if (k == "side") then t[1] = v 
                elseif (k == "cindex") then t[2] = v 
                elseif (k == "skillId") then t[3] = v 
                elseif (k == "counter") then t[4] = v 
                elseif (k == "restore") then t[5] =v 
                elseif (k == "damages") then t[6] = v 
                else rawset(t,k,v) end
            else
                rawset(t,k,v)
            end
        end
    }
    
    setmetatable(action, mt)
    
    action.createDamage = createFightDamage
    
    action.addDamage = function(self)
        local damage = self.createDamage()
        self[6][(#self[6] + 1)] = damage
        
        return damage
    end
    
    action.getDamages = function(self)
        return self[6]
    end
    
    action.toObject = function(self)
        local damages = {}
        local index
        for index = 1, #self.damages, 1 do
            damages[index] = self.damages[index]:toObject()
        end
        return {self[1], self[2], self[3], self[4], self[5], damages }
    end
    
    action.fromObject = function(self, array)
        self[1] = array[1]
        self[2] = array[2]
        self[3] = array[3]
        self[4] = array[4]
        self[5] = array[5]
        local damages = {}
        local index
        for index = 1, #array[6], 1 do
            local damage = self.createDamage()
            damage:fromObject(array[6][index])
            damages[index] = damage
        end
        self[6] = damages
    end
    
    return action

end
--------------------------------------------------

local function createFightRound()
    local round = {0,0}
    local mt = {
        __index = function(t,k)
            if (type(k) == "integer") then
                return t[k]
            elseif (type(k) == "string") then
                if (k == "actions") then 
                    local actions = {}
                    local index = 0
                    for index = 1, #t - 2, 1 do
                        actions[index] = t[index]
                    end
                elseif (k == "angry") then return t[2]
                elseif (k == "eangry") then return t[3]
                end
            end
                return rawget(t, k)
        end,
        __newindex = function(t,k,v)
            if (type(k) == "integer") then
                t[k] = v
            elseif (type(k) == "string") then
                if (k == "actions") then table.insert(t, #t - 1, v)  -- TODO to finish this
                elseif (k == "angry") then t[#t - 1] = v 
                elseif (k == "eangry") then t[#t] = v 
                else rawset(t,k,v) end
            else
                rawset(t,k,v)
            end
        end
    }
    
    setmetatable(round, mt)
    
    round.createAction = createFightAction
    
    round.addAction = function(self)
        local action = self.createAction()
        table.insert(self, #self - 1, action)
        
        return action
    end
    
    round.toObject = function(self)
        local obj = {}
        if (#self > 2) then
            local index = 0
            for index = 1, #self - 2, 1 do
                obj[index] = self[index]:toObject()
            end
        end
        obj[#obj + 1] = self[#self - 1]
        obj[#obj + 1] = self[#self]
        return obj
    end
    
    round.fromObject = function(self, array)
        if (#array > 2) then
            local index = 0
            for index = 1, #array - 2, 1 do
                local action = self:addAction()
                action:fromObject(array[index])
            end
        end
        
        self[#array - 1] = array[#array - 1]
        self[#array] = array[#array]
    end
    
    return round
end

--------------------------------------------------

local function createFightReply()
    local reply = {
    }
    reply.rounds = {}

    reply.createRound = createFightRound

    reply.getRounds = function(self)
        return self.rounds
    end

    reply.newRound = function(self)
        local round = self.createRound()
        self.rounds[(#self.rounds + 1)] = round
        
        return round
    end
    
    reply.toObject = function(self)
        local rounds = {}
        local index = 0
        for index = 1, #self.rounds, 1 do
            rounds[index] = self.rounds[index]:toObject()
        end
        
        return rounds;
    end
    
    reply.fromObject = function(self, array)
        local index = 0
        if (array ~= nil) then
            for index = 1, #array, 1 do
                local round = self:newRound()
                round:fromObject(array[index])
            end
        end
    end
    
    return reply
end

---------------------------------------------------

local fightReport = {}

fightReport.createReply = createFightReply

fightReport.createFightPlayer = function()
    return {
           id        = "",
           level     = 0,
           exp       = 0,
           vipLevel  = 0,
           ap        = 0,
           mp        = 0,
           bup       = 0,
           bpp       = 0,
           mbfc      = 0,
           lastAPTime= 0,
           lastMPTime= 0,
           name      = "",
           money     = 0,
           golden    = 0,
           boughtG   = 0,
           rousing   = 0,
           first     = 0,
           init      = 0,
    } 
end

fightReport.createUpdateChar = function()
    return { tid = "", exp = 0, levelUp = 0}
end

fightReport.createCharacter = function()
    return {    
        id            = 0,
        tid           = "",
        level         = 0,
        exp           = 0,
        wuli          = 0,
        lingli        = 0,
        minjie        = 0,
        qixue         = 0,
        fangyu        = 0,
        mingzhong     = 0,
        shanbi        = 0,
        baoji         = 0,
        kangbao       = 0,
        huixin        = 0,
        skillCapability= 0,
        price         = 0,
        breakLevel    = 0,
        potential     = 0,
        relation1     = 0,
        relation2     = 0,
        relation3     = 0,
        relation4     = 0,
        relation5     = 0,
        relation6  = 0
    }   
end

fightReport.createStarPos = function()
    return {
        id           = 0,
        cid          = 0,
        spid         = "",
        index        = 0,
        level        = 0,
        exp          = 0,
        numberValue  = 0.0
    }
end

fightReport.createBeast = function()
return {
    id      = 0,
    tid     = "",
    level   = 0,
    exp     = 0,
    price   = 0,
    wuli    = 0,
    lingli  = 0,
    minjie  = 0,
    baoji   = 0,
    huixin  = 0,
    chuantou= 0,
    angry   = 0,
    actTime = 0,
    practice= 0
}
end

fightReport.createItem = function()
    return {id = "", count = 0}
end

fightReport.createFragment = function()
    return {id = "", count = 0}
end

fightReport.createSoul = function()
    return {cid = "", count = 0}
end

fightReport.createEquipment = function()
return {
    id           = 0,
    tid          = "",
    cid          = 0,
    level        = 0,
    money        = 0,
    mainAttrValue= 0,
    initValue    = 0,
    strongerValue= 0.0,
    price        = 0,
    sprice       = 0,
}
end

fightReport.createFormation = function()

return {
    id               = 0,
    tid              = "",
    level            = 0,
    exp              = 0,
    money            = 0,
    frontAttrPercent = 0,
    frontAttrValue   = 0,
    middleAttrPercent= 0,
    middleAttrValue  = 0,
    tailAttrPercent  = 0,
    tailAttrValue    = 0,
    price            = 0,
}
    
end

fightReport.createPartner = function()
    return {
        index       = 0,
        characterId = "",
        rank        = 0,
        attribute   = 0,
        percentValue= 0.0,
        numberValue = 0.0,
        cid         = "",
    }
end

fightReport.createCampaignLevel = function()
    return {
        id          = "",
        stars       = 0,
        combatCount = 0,
        refreshCount= 0,
        gotReward   = 0
    }
end

fightReport.createMagicBall = function()
    return {
        id         = 0,
        tid        = "",
        level      = 0,
        exp        = 0,
        upValue    = 0,
        downValue  = 0,
        downPercent= 0,
    }
end

fightReport.createSkill = function()
    return {
        id            = 0,
        tid           = "",
        cid           = 0,
        index         = 0,
        level         = 0,
        exp           = 0,
        money         = 0,
        mainAttrValue = 0,
        mainAttrPercent= 0.0,
        price         = 0,
    }
end

fightReport.createBeastTouch = function()
    return {
        id         = 0,
        time       = 0,
        exp        = 0,
        itemId     = "",
        count      = 0,
        price      = 0,
        characterId= 0,
        useCount   = 0,
    }
end


fightReport.playerName = ""
fightReport.enemyName = ""
fightReport.characters={{"","","","","","",""},{"","","","","","",""}}
fightReport.reply = fightReport.createReply()
fightReport.dual = 0
fightReport.win = 0
fightReport.stars = 0
fightReport.partner = nil
fightReport.playBonus = {money = 0, exp = 0}
fightReport.playerLevelUp = 0
fightReport.player = nil
fightReport.charUpdated = { } 
fightReport.charLevelUps = { } 
fightReport.charStars = { } 
fightReport.beast = nil
fightReport.rewards = {
    item = nil,
    equip = nil,
    formation = nil,
    skill = nil,
    fragment = nil,
    soul = nil,
    magicball = nil,
    mballPiece = 0,
}
fightReport.beastToudn = nil
fightReport.campaign = nil
fightReport.serverTime = 0


function fightReport:combine(userdata, basedata, ignoreFunction)
    
    local k, v
    if (basedata ~= nil) then
        for k, v in pairs(basedata) do
            if ((ignoreFunction and type(v) == "function") ~= true) then
                self[k] = v
            end
        end
    end
    if (userdata ~= nil) then
        for k, v in pairs(userdata) do
            if ((ignoreFunction and type(v) == "function") ~= true) then
                self[k] = v
            end
        end
    end
end

function fightReport:toJson()
    return json.encode(self:toObject());
end

function fightReport:fromJson(jsonString)
	local jsonObj = json.decode(jsonString)
    self:combine(jsonObj, {}, true)
    local reply = self.createReply()
    if (jsonObj ~= nil and jsonObj.reply ~= nil) then
    	reply:fromObject(jsonObj.reply)
    end
    self.reply = reply
end

function fightReport:toObject()
	local obj = {}
	
	self.combine(obj, self, {}, true)
    if (self.reply ~= nil) then
	    obj.reply = self.reply:toObject()
    end
	
	return obj
end


return fightReport






