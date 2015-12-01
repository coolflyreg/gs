-- 锦囊系统 - (27XX)

local gifts = {}

gifts.types = [[

.gift_reward {    # 锦囊数据    
    actId       0 : string # 活动ID    
    date        1 : string # 发放时间    格式：2014-xx-xx
    text        2 : string # 奖励信息    
    items       3 : *user_item # 道具数组    
    equips      4 : *equipment # 装备数组    
    formations  5 : *formation # 阵法数组    
    skills      6 : *skill # 法宝数组    
    magicball   7 : magicBall # 灵珠信息    
    frags       8 : *user_fragment # 碎片数组    
    souls       9 : *soul # 魂魄数组    
    ap         10 : integer # 行动点数    
    mp         11 : integer # 元神点数    
    money      12 : integer # 银币    
    golden     13 : integer # 金币    
    fame       14 : integer # 声望    
    mpt        15 : integer # 魔晶    
}

]]

gifts.c2s = [[

gifts_all 2701 {    # 获取锦囊列表数据 - 2701
    request {

    }
    response {
        rewards 0 : *gift_reward # 锦囊数据数组    
    }
}

gifts_receive 2703 {    # 领取锦囊所有物品 2703
    request {

    }
    response {
        useCount     0 : integer # 当日使用次数    仅道具是人参果，仙桃，至尊令的情况下，此属性有效。
        items        1 : *user_item # 道具数组    
        equips       2 : *equipment # 装备数组    
        formations   3 : *formation # 阵法数组    
        skills       4 : *skill # 法宝数组    
        magicball    5 : magicBall # 灵珠信息    
        frags        6 : *user_fragment # 碎片数组
        souls        7 : *soul # 魂魄数组    
        ap           8 : integer # 行动点数    
        mp           9 : integer # 元神点数    
        money       10 : integer # 银币    
        golden      11 : integer # 金币    
        fame        12 : integer # 声望    
        mpt         13 : integer # 魔晶 
    }
}



]]

gifts.s2c = [[

gifts_notifyNewGift 2702 {    # 锦囊新物品下发通知 - 2702
    request {
        rewards 0 : *gift_reward # 锦囊数据数组    
    }
    response {

    }
}

]]


return gifts