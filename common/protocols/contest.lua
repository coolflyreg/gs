-- 神仙斗法（22XX）

local contest = {}

contest.types = [[

.contest_reward {    # 争霸奖励信息
    id    0 : integer # ID
    count 1 : integer # 剩余数量
    got   2 : integer # 是否已领取
}

.contest_rank_player_info {    #  斗法玩家排名信息
    id     0 : integer # 玩家ID    
    name   1 : string # 玩家名称    
    rank   2 : integer # 玩家排名    
    up     3 : integer # 上升或下降了多少名次    "> 0 - 上升 = 0 - 名次不变 < 0 - 下降"
    level  4 : integer # 玩家斗法等级    
    vip    5 : integer # 玩家VIP等级    
    exp    6 : integer # 玩家斗法经验    
}

.user_item {    # 玩家道具信息
    iid       0 : string # 道具ID
    count    1 : integer # 道具数量
    useCount 2 : integer # 当日使用次数    仅道具是人参果，仙桃，至尊令的情况下，此属性有效。
}

]]

contest.c2s = [[

contest_info 2201 {    # 获取玩家斗法信息 - 2201
    request {

    }
    response {
        level        0 : integer # 斗法级别    
        rank         1 : integer # 排名    
        exp          2 : integer # 斗法经验    
        remainCount  3 : integer # 剩余斗法次数    
        total        4 : integer # 斗法总场数    
        win          5 : integer # 胜利场数    
        fail         6 : integer # 失败场数    
        fame         7 : integer # 声望    
        fameTime     8 : integer # 下一次计算声望倒计时多少秒。    
        gotDaily     9 : integer # 是否已领取每日奖励    "0 - 未领取 1 - 已领取"
    }
}

contest_playerCharacters 2202 {    # 获取玩家上阵弟子列表 - 2202
    request {

    }
    response {

    }
}

contest_refresh 2203 {    # 刷新斗法玩家列表信息 - 2203
    request {
        count 0 : integer # 刷新个数    1或3
        uids  1 : *integer # 当前刷新出的玩家ID    只在count＝1的时候有效
    }
    response {
        players 0 : *other_player # 斗法玩家信息列表
    }
}


contest_reward 2204 {    # 领取斗法每日奖励 - 2204
    request {

    }
    response {
        money 0 : integer # 银币
        point 1 : integer # 魔晶点数
        box   2 : user_item # 宝箱

    }
}


contest_ranklist 2205 {    # 获取斗法排名 - 2205
    request {
        page 0 : integer # 获取第几页的排名    "-1 - 玩家当前排名页 >-1 -玩家指定排名页"
    }
    response {
        current 0 : integer # 当前页    
        total   1 : integer # 总页数    
        list    2 : *contest_rank_player_info # 排名列表    

    }
}

contest_rankCombat 2206 {    # 斗法排名战报战斗 - 2206
    request {
        id 0 : integer # 玩家ID
    }
    response {
        # TODO To finish this
    }
}



contest_achievementInfo 2207 {    # 获得排名和等级争霸的奖励数据 - 2207
    request {

    }
    response {
        time    0 : integer # 奖励领取开启剩余时间
        ranks   1 : *contest_reward # 排名争霸奖励列表
        levels  2 : *contest_reward # 等级争霸奖励列表
    }
}

contest_rankReward 2208 {    # 领取斗法争霸排名奖励 - 2208
    request {
        id 0 : integer # 排名奖励ID
    }
    response {
        items 0 : *user_item # 道具列表
    }
}


contest_rankLevelReward 2209 {    # 领取斗法争霸等级奖励 - 2209
    request {
        id 0 : integer # 排名奖励ID
    }
    response {
        items 0 : *user_item # 道具列表
    }
}

contest_combat 2210 {    # 斗法战斗 - 2210
    request {
        id 0 : integer # 玩家ID
    }
    response {
        # TODO To finish this
    }
}

]]

contest.s2c = [[


]]


return contest