-- 服务器信息（11XX） done

local gameserver = {}

gameserver.types = [[

.server {
    id    0 : integer # 服务器编号
    host  1 : string # 主机地址或IP
    port  2 : integer # 端口
    name  3 : string # 服务器名称
    state 4 : integer # 服务器状态
}

]]

gameserver.c2s = [[

gameserver_register 1101 {    # 获取服务器列表 - 1101
    response {
        servers 0 : *server(id)
    }
}

gameserver_login 1102 {    # 登陆游戏逻辑服务器 - 1102
    request {
        username 0 : string # 用户帐号
        serverId 1 : integer # 服务器ID
        platform 2 : integer # 平台标识
    }
    response {
        uid         0 : integer # 逻辑服务器用户ID
        sessionId   1 : string # 会话ID
        golden      2 : integer # 内测期间，每日首次登陆赠送的元宝数
    }
}

gameserver_kick 1004 {    # 踢用户下线 - 1004
    request {
        uid 0 : integer # 用户uid
    }
    response {
        uid 0 : integer # 用户uid
    }
}

gameserver_heartbeat 1099 {    # 心跳包 - 1099
    request {
        uid       0 : integer # 用户中心uid
        sessionId 1 : string # 会话ID
    }
    response {
        sessionId  0 : string # 会话ID
        serverTime 1 : integer # 服务端时间
    }
}


]]

gameserver.s2c = [[


]]


return gameserver