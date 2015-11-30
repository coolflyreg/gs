-- 乾坤袋（23XX）

local package = {}

package.types = [[

.user_fragment {    # 玩家碎片
    id     0 : string # 碎片ID    
    count  1 : integer # 碎片数量    
}

]]

package.c2s = [[

package_all 2301 {    # 获取所有物品列表 - 2301
    request {

    }
    response {
        items 0 : *user_item # 物品数组
    }
}

package_useItem 2302 {    # 使用物品 - 2302
    request {
        id 0 : string # 物品ID
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

package.s2c = [[


]]


return package