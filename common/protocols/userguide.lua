-- 用户向导信息（12XX） done

local userguide = {}

userguide.types = [[


]]

userguide.c2s = [[

userguide_get 1201 {    # 获取所有向导信息 - 1201
    request {

    }
    response {
        guide 0 : string # 用户向导信息
    }
}
userguide_update 1202 {    # 更新向导状态 - 1202
    request {
        key 0 : integer # 用户向导标识
    }
    response {
        guide 0 : string # 用户向导信息
    }
}


]]

userguide.s2c = [[


]]


return userguide