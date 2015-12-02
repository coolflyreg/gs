-- 用户信息（10XX）done

local account = {}

account.types = [[
]]

account.c2s = [[

account_register 1001 {    # 用户注册 - 1001
    request {
        username 0 : string # 账号名
        password 1 : string # 密码
    }
    response {
        username 0 : string # 账号名
    }
}

account_auth 1002 {    #用户认证 - 1002
    request {
        username 0 : string # 账号名
        password 1 : string # 密码
    }
    response {
        username 0 : string # 账号名
    }
}

account_auth_platform 1003 {    # 用户登录平台 - 1003
    request {
        code     0 : string # 平台授权code
        appkey   1 : string # 平台appkey
        platform 2 : integer # 平台标识
        username 3 : string # 平台账户名
        userid   4 : string # 平台账户id
        token    5 : string # token
    }
    response {
        username     0 : string # 平台账户名
        userid       1 : string # 平台账户id
        refreshtoken 2 : string # 刷新token
    }
}

]]

account.s2c = [[

]]


return account
