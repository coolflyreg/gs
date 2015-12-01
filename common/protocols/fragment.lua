-- 碎片掠夺（21XX）

local fragment = {}

fragment.types = [[

.rob_player {    # 掠夺玩家信息    
    uid         0 : integer # 玩家信息    <0 - 机器人
    characters  1 : *string # 角色ID列表    
    level       2 : integer # 玩家级别    
    name        3 : string # 玩家队伍名称    
}

.rob_item {    # 掠夺物品    
    id     0 : string # 物品ID    
    count  1 : integer # 剩余拼合次数    
    time   2 : integer # 拼合次数减少时间    "0 - 无效 >0 - 剩余多少时间"
    frags  3 : *fragment # 物品碎片    
}

]]

fragment.c2s = [[

fragment_all 2101 {    # 获取全部碎片信息 - 2101
    request {

    }
    response {
        items 0 : *rob_item #     
    }
}

fragment_players 2102 {    # 获取掠夺玩家列表 - 2102
    request {
        id 0 : string # 碎片ID
    }
    response {
        players 0 : *rob_player # 玩家信息列表    

    }
}

fragment_combat 2103 {    # 开始掠夺战斗 - 2103
    request {
        fid   0 : string # 碎片ID
        pid   1 : integer # 玩家ID
        name  2 : string # 玩家队伍名称
    }
    response {
        result 0 : string # 战斗结果json -- firghtReport
    }
}

fragment_compose 2104 {    # 拼合碎片 - 2104
    request {
        id 0 : string # 物品ID    装备，法宝或阵法ID
    }
    response {
        equip      0 : equipment # 获得的装备    没有，则不传
        skill      1 : skill # 获得的技能    没有，则不传
        formation  2 : formation # 获得的阵法    没有，则不传
    }
}



]]

fragment.s2c = [[

fragment_x 2105 {    # 碎片被掠夺通知 - 2105
    request {
        id    0 : string # 碎片ID    
        count 1 : integer # 剩余数量    
        time  2 : integer # 拼合次数减少时间    "0 - 无效 > 0 剩余时间"
    }
    response {
        ok 0 : integer #     1
    }
}

]]


return fragment