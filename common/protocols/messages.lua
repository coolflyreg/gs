-- 消息 - (26XX)

local message = {}

message.types = [[

.chat_from {    # 消息来源    
    id   0 : integer # 用户ID    "-1 - 表示系统消息 > -1 - 表示用户ID"
    name 1 : string # 用户队伍名称    
    vip  2 : integer # 用户VIP级别    
}

.chat_msg {    # 聊天消息    
    from    0 : chat_from # 消息来源    
    type    1 : integer # 系统消息类别    "0 - 一般公告 1 - 充值消息 2 - 活动消息"
    content 2 : string # 消息内容    
    url     3 : string # 消息链接到的地址    
    time    4 : integer # 消息时间    
}

]]

message.c2s = [[

messages_all 2601 {    # 获取消息 - 2601
    request {
        flag 0 : integer # 消息标志位    "-1 - 最近10条消息 > 0 - 标志位之后的所有消息"
    }
    response {
        flag 0 : integer # 下次取消息的标志位    
        msgs 1 : *chat_msg # 消息数组    

    }
}

messages_send 2602 {    # 发送聊天消息 - 2602
    request {
        content 0 : string # 消息内容    
        flag    1 : integer # 消息标志位    "-1 - 最近10条消息 > 0 - 标志位之后的所有消息"
    }
    response {
        itemCount 0 : integer # 道具小喇叭的数量    
        flag      1 : integer # 下次取消息的标志位    
        msgs      2 : *chat_msg # 消息数组    

    }
}


]]

message.s2c = [[


]]


return message