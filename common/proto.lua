local sparser = require("sprotoparser")

local proto = {}

local types = [[

.package {
	type 0 : integer
	session 1 : integer
}

.player {
	id : string -- 玩家ID	
	level : integer -- 玩家级别	
	exp : integer -- 经验	
	vipLevel : integer -- VIP等级	
	ap : integer -- 行动点数	
	mp : integer -- 元神点数	
	bup : integer -- 神兽精魂	
	bpp : integer -- 神兽双修点数	
	mbfc : integer -- 灵珠碎片数量	
	lastAPTime : integer -- 下次行动点恢复时间	
	lastMPTime : integer -- 下次元神点恢复时间	
	name : string -- 队伍名称	
	money : integer -- 游戏货币	
	golden : integer -- 游戏代币	
	boughtG : integer -- 玩家总充值量	
	rousing : integer -- 今日鼓舞次数	
	first : integer -- 玩家是否完成首冲	0 - 未完成  1 - 完成
	init : integer -- 玩家是否创建了队伍	0 - 未创建 1 - 创建了
}

.character {
	id : integer -- 玩家角色ID -- 
	tid : string -- 角色ID -- 
	level : integer -- 角色级别 -- 
	exp : integer -- 经验 -- 
	wuli : integer -- 武力 -- 
	lingli : integer -- 灵力 -- 
	minjie : integer -- 敏捷 -- 
	qixue : integer -- 气血 -- 
	fangyu : integer -- 防御 -- 
	mingzhong : integer -- 命中 -- 
	shanbi : integer -- 闪避 -- 
	baoji : integer -- 暴击 -- 
	kangbao : integer -- 抗暴 -- 
	huixin : integer -- 会心 -- 
	skillCapability : integer -- 神识 -- 
	price : integer -- 战斗力 -- 
	breakLevel : integer -- 突破级别 -- 
	potential : integer -- 剩余潜力值 -- 
	relation1 : integer -- 姻缘1是否开启 -- "0 - 未开启 1 - 开启"
	relation2 : integer -- 姻缘2是否开启 -- "0 - 未开启 1 - 开启"
	relation3 : integer -- 姻缘3是否开启 -- "0 - 未开启 1 - 开启"
	relation4 : integer -- 姻缘4是否开启 -- "0 - 未开启 1 - 开启"
	relation5 : integer -- 姻缘5是否开启 -- "0 - 未开启 1 - 开启"
	relation6 : integer -- 姻缘6是否开启 -- "0 - 未开启 1 - 开启"
}

.equipment {
	id : integer -- 玩家装备ID -- 
	tid : String -- 装备ID -- 
	cid : integer -- 玩家角色ID -- 
	level : integer -- 装备级别 -- 
	money : integer -- 升级所需货币 -- 
	mainAttrValue : integer -- 主属性值 -- 
	initValue : integer -- 初始 -- 
	strongerValue : Float -- 成长 -- 
	price : integer -- 战斗力 -- 
	sprice : integer -- 已计算好的出售价格 -- 
}

]]

