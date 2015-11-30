-- 关卡信息（14XX） Not Done

local campaign = {}

campaign.types = [[

.fight_result {    # 战斗结果战报
}

]]

campaign.c2s = [[

campaign_x 1401 {    # 获取玩家关卡信息 - 1401
    request {

    }
    response {
campaigns		[CampaignLevel]	关卡信息
time		Integer	关卡扫荡冷却时间
    }
}

campaign_x 1402 {    # 执行关卡任务 - 1402
    request {
campaignId		String	关卡ID	
rousing		Integer	是否鼓舞	"0-不鼓舞 1-鼓舞"
    }
    response {

    }
}
   
campaign_x 1403 {    # 花费元宝刷新关卡 - 1403
    request {
id		String	关卡ID
    }
    response {
campaign		CampaignLevel	刷新后的关卡信息
    }
}
campaign_x 1404 {    # 扫荡关卡 - 1404
    request {
id		String	关卡ID
count		Integer	扫荡次数
    }
    response {
campaign		CampaignLevel	扫荡后的关卡信息	
playerBonus		JsonObject		
money	playerBonus	Integer	玩家获得游戏币	
exp	playerBonus	Integer	玩家获得经验	
charExp		Integer	单个角色此次扫荡获得的总经验值	
playerLevelUp		Integer	玩家升级量	"0 - 没有升级 >= 1 - 升了多少级"
player		Player	玩家信息	
charLevelUps		[Character]	更新后的角色信息	[]
charStars		[StarPos]	星宿信息数组	只传递有变化的角色的星宿。如无变化，此项不传。
partner		Partner	开启的护法位置	
rewards		JsonObject	奖励	奖励结构里的item,equip,formation,skill,magicball,fragment,soul,box在没有的情况下不传递
items	rewards	[item]	道具数组	
item	items	JsonObject	道具信息	
id	item	String	道具ID	
count	item	Integer	道具数量	
equips	rewards	[Equipment]	装备信息数组	
formations	rewards	[Formation]	阵法信息数组	
skills	rewards	[Skill]	法宝信息数组	
frags	rewards	[fragment]	碎片数组	
fragment	frags	JsonObject	碎片	
id	fragment	String	碎片ID	
count	fragment	Integer	碎片数量	
souls	rewards	[soul]	魂魄数组	
soul	souls	JsonObject	魂魄	
cid	soul	String	角色ID	
count	soul	Integer	魂魄数量	
mballPiece	rewards	Integer	灵珠碎片数量，此字段只在灵珠战斗中有效	
time		Integer	关卡扫荡冷却时间	
    }
}

]]

campaign.s2c = [[


]]


return campaign