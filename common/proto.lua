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

]]
