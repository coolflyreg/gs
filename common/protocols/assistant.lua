-- 助手（25XX）

local assistant = {}

assistant.types = [[

.task {    # 每日任务    
    id       0 : string # 任务ID    
    done     1 : integer # 是否已完成    "0 - 未完成 1 - 已完成"
    got      2 : integer # 是否已领取奖励    "0 - 未领取 1 - 已领取"
    progress 3 : integer # 当前进度    已做任务的次数
}

.achievement {    # 成就信息    
    id       0 : string # 成就ID（任务ID）    
    done     1 : integer # 是否已完成    "0 - 未完成 1 - 已完成"
    progress 2 : integer # 当前进度    已做任务的次数
}

]]

assistant.c2s = [[

assistant_all 2501 {    # 获取每日任务和成就信息 - 2501
    request {

    }
    response {
        tasks    0 : *task # 每日任务数组    
        achieves 1 : *achievement # 成就信息数组    
    }
}

assistant_reward 2502 {    # 领取每日任务和成就的奖励 - 2502
    request {
        id 0 : string # 任务ID
    }
    response {
        player       0 : player # 玩家信息
        useCount     1 : integer # 当日使用次数    仅道具是人参果，仙桃，至尊令的情况下，此属性有效。
        items        2 : *user_item # 道具数组    
        equips       3 : *equipment # 装备数组    
        formations   4 : *formation # 阵法数组    
        skills       5 : *skill # 法宝数组    
        magicball    6 : magicBall # 灵珠信息    
        frags        7 : *user_fragment # 碎片数组
        souls        8 : *soul # 魂魄数组    
        ap           9 : integer # 行动点数    
        mp          10 : integer # 元神点数    
        money       11 : integer # 银币    
        golden      12 : integer # 金币    
        fame        13 : integer # 声望    
        mpt         14 : integer # 魔晶 
    }
}

]]

assistant.s2c = [[

assistant_doneNotify 2503 {    # 每日任务和奖励信息完成通知 - 2503
    request {
        tasks    0 : *task # 每日任务数组    
        achieves 1 : *achievement # 成就信息数组    
    }
    response {

    }
}

]]


return assistant