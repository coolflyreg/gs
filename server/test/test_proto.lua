require("framework")

local json = require "cjson"

local skynet = require("skynet")
local proto = require("protocols.proto")

echoInfo("in test_proto")

--echoInfo(proto.types)

local fightReport = require("fightReport")

local round = fightReport.reply:newRound()
local action1 = round:addAction()
local action2 = round:addAction()
local action3 = round:addAction()
round.angry = 200
round.eangry = 100


--dump(fightReport, "fightReport")

echoInfo("")
echoInfo("------------------------------------------")
echoInfo("")
echoInfo("fightReport : "..fightReport:toJson())


local file = nil
--[[
file = io.open("json.txt", "w");
file:write(fightReport:toJson())
file:flush()
file:close()
]]

file = io.open("json.txt");
file:seek("set")
local content = file:read("a")

fightReport = require("fightReport")
fightReport:fromJson(content)

--dump(fightReport, "fightReport")
echoInfo("")
echoInfo("------------------------------------------")
echoInfo("")

echoInfo("fightReport : "..fightReport:toJson())

skynet.start (function ()
    

    skynet.exit()

end)
