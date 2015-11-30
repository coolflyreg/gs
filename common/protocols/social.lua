-- 恩怨关系（20XX）

local social = {}

social.types = [[

.social_user {    # 社交用户信息    
    id       0 : integer # 玩家ID    
    name     1 : string # 玩家队伍名称    
    level    2 : integer # 玩家级别        
    type     3 : integer # 关系类型    "0 - 好友 1 - 仇敌 2 - 好友请求"
    vipLevel 4 : integer # VIP等级
    time     5 : integer # 消息时间    
    cd       6 : integer # 复仇冷却倒计时    
}

.social_sys_msg {    # 社交系统消息    
    time     0 : integer # 消息发布时间    
    text     1 : string # 消息文字    
    rewardId 2 : integer # 系统发放的礼包ID    
}

.social_chat_msg {    # 对话
    time 0 : integer # 消息发送时间
    uid  1: integer # 玩家ID
    text 2 : string # 消息内容
}

.social_contest_msg {    # 斗法消息    
    time     0 : integer # 消息发布时间    
    win      1 : integer # 己方玩家是否胜利    "0 - 失败 1 - 胜利"
    uid      2 : string # 对方玩家uid    
    name     3 : string # 对方玩家队伍名    
    level    4 : integer # 对方玩家等级    
    report   5 : integer # 战报ID    
    exp      6 : integer # 获得或损失的经验    "复数为损失经验 正数为获得的经验"
}

.social_rob_msg {    # 掠夺战斗    
    time   0 : integer # 消息发布时间    
    win    1 : integer # 己方玩家是否胜利    "0 - 失败 1 - 胜利"
    uid    2 : string # 对方玩家uid    
    name   3 : string # 对方玩家队伍名    
    level  4 : integer # 对方玩家等级    
    escape 5 : integer # 是否逃跑成功    "0 - 不成功 1 - 成功"
    fid    6 : string # 碎片ID    
    report 7 : integer # 战报ID    
}

]]

social.c2s = [[

social_all 2001 {    # 获取恩怨关系 - 2001
    request {

    }
    response {
        users   0 : *social_user # 用户数组    
        msgs    1 : *social_sys_msg # 系统消息数组    
        pkmsgs  2 : *social_contest_msg # 斗法消息数组    
        fpks    3 : *social_rob_msg # 掠夺战斗数组    
    }
}

social_searchFriend 2002 {    # 搜索好友 - 2002
    request {
        search 0 : string # 要搜索的文本
    }
    response {
        users 0 : *social_user # 用户数组    

    }
}

social_connect 2003 {    # 添加恩怨关系 - 2003
    request {
        id   0 : integer # 玩家ID    
        type 1 : integer # 添加类型    "0 - 好友 1 - 仇敌"
    }
    response {
        success 0 : integer # 是否成功    "0 - 成功 1 - 失败"
    }
}

social_disconnect 2004 {    # 移除恩怨关系 - 2004
    request {
        id   0 : integer # 玩家ID    
        type 1 : integer # 添加类型    "0 - 好友 1 - 仇敌"
    }
    response {
        success 0 : integer # 是否成功    "0 - 成功 1 - 失败"
    }
}

social_combatReport 2005 {    # 获取战报战斗 - 2005
    request {
        id 0 : integer # 战报战斗ID
    }
    response {
        # TODO to finish this
    }
}

social_chatList 2006 {    # 获取与好友对话 - 2006
    request {
        id   0 : integer # 好友uid    
        flag 1 : integer # 最后一条消息的标志    -1 - 近期20条消息
    }
    response {
        msgs 0 : *social_chat_msg # 对话数组
        flag 1 : integer # 最后一条消息的标志
    }
}

social_chatSend 2007 {    # 向好友发送消息 - 2007
    request {
        id   0 : integer # 好友uid    
        text 1 : string # 发送的消息内容    
        flag 2 : integer # 最后一条消息的标志    -1 - 近期20条消息
    }
    response {
        msgs 0 : *social_chat_msg # 对话数组
        flag 1 : integer # 最后一条消息的标志
    }
}

social_friendRequest 2008 {    # 同意或拒绝添加好友 - 2008
    request {
        id     0 : integer # 好友uid    
        accept 1 : integer # 是否接受好友请求    "0 - 拒绝 1 - 接受"
    }
    response {
        user 0 : social_user # 用户信息    
    }
}

social_playerPK 2009 {    # 好友切磋和仇敌复仇 - 2009
    request {
        id   0 : integer # 好友或仇敌uid    
        type 1 : integer # PK方式    "0 - 切磋 1 - 复仇"
    }
    response {
        # TODO to finish this -- combat : Reference # 参见执行关卡 － 1402的响应部分。    
        cd 0 : integer # 复仇冷却倒计时    如果类型为切磋，则此值为0
    }
}

]]

social.s2c = [[

social_x 2010 {    # 恩怨信息推送 - 2010
    request {
        type 0 : integer # 恩怨消息类型    "0 - 系统 1 - 掠夺 2 - 斗法 3 - 好友"
    }
    response {

    }
}

]]


return social