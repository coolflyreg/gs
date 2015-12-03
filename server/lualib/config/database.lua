local config = {}

-- 账号数据库
config.account = {
    host = "127.0.0.1",
    port = 3306,
    database = "zzb_account",
    user = "root",
    password = "root",
    max_packet_size = 1024 * 1024
}

-- 游戏数据库
config.game = {
    host = "127.0.0.1",
    port = 3306,
    database = "zzb_game",
    user = "root",
    password = "root",
    max_packet_size = 1024 * 1024
}

-- 支付数据库
config.pay = {
    host = "127.0.0.1",
    port = 3306,
    database = "zzb_pay",
    user = "root",
    password = "root",
    max_packet_size = 1024 * 1024
}


return config