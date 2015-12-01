-- 关卡信息（14XX） Not Done

local campaign = {}

campaign.types = [[

.rewards {    # 数据    
    items       1 : *user_item # 道具数组    
    equips      2 : *equipment # 装备数组    
    formations  3 : *formation # 阵法数组    
    skills      4 : *skill # 法宝数组    
    magicball   5 : magicBall # 灵珠信息    
    frags       6 : *user_fragment # 碎片数组    
    souls       7 : *soul # 魂魄数组    
    mballPiece  8 : integer # 灵珠碎片数量，此字段只在灵珠战斗中有效
}

.playerBonus {        
    money 0 : integer # 玩家获得游戏币    
    exp   1 : integer # 玩家获得经验    
}

]]

campaign.c2s = [[

campaign_all 1401 {    # 获取玩家关卡信息 - 1401
    request {

    }
    response {
        campaigns 0 : *campaignLevel # 关卡信息
        time      1 : integer # 关卡扫荡冷却时间
    }
}

campaign_execute 1402 {    # 执行关卡任务 - 1402
    request {
        campaignId 0 : string # 关卡ID    
        rousing    1 : integer # 是否鼓舞    "0-不鼓舞 1-鼓舞"
    }
    response {
        result 0 : string # 战斗结果json -- firghtReport
    }
}
   
campaign_reset 1403 {    # 花费元宝刷新关卡 - 1403
    request {
        id 0 : string # 关卡ID
    }
    response {
        campaign 0 : campaignLevel # 刷新后的关卡信息
    }
}
campaign_multipleExecute 1404 {    # 扫荡关卡 - 1404
    request {
        id    0 : string # 关卡ID
        count 1 : integer # 扫荡次数
    }
    response {
        campaign      0 : campaignLevel # 扫荡后的关卡信息    
        playerBonus   1 : playerBonus #     
        charExp       2 : integer # 单个角色此次扫荡获得的总经验值    
        playerLevelUp 3 : integer # 玩家升级量    "0 - 没有升级 >= 1 - 升了多少级"
        player        4 : player # 玩家信息    
        charLevelUps  5 : *character # 更新后的角色信息    *
        charStars     6 : *starPos # 星宿信息数组    只传递有变化的角色的星宿。如无变化，此项不传。
        partner       7 : partner # 开启的护法位置    
        rewards       8 : rewards # 奖励    奖励结构里的item,equip,formation,skill,magicball,fragment,soul,box在没有的情况下不传递
        time          9 : integer # 关卡扫荡冷却时间    
    }
}

]]

campaign.s2c = [[


]]


return campaign