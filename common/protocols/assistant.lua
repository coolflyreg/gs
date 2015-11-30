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
        player 0 : player # 玩家信息
        # TODO TO finish this  --         item : Reference # 参见2302响应结构
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