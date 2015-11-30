-- 神兽信息（19XX）

local beast = {}

beast.types = [[
]]

beast.c2s = [[


beast_all 1901 {    # 获取全部神兽和灵珠信息 - 1901
    request {

    }
    response {
        beasts       0 : *beast # 神兽信息数组
        magicballs   1 : *magicBall # 灵珠信息数组
        mballPiece   2 : integer # 灵珠碎片数量
        freeUpPoint  3 : integer # 免费升级次数
        buyCount     4 : integer # 双修剩余购买次数
        actMBId      5 : integer # 选中激活的灵珠ID
        mbCD         6 : integer # 灵珠扫荡冷却时间
    }
}
beast_one 1902 {    # 获取单个神兽信息 - 1902
    request {
        id 0 : integer # 玩家神兽ID
    }
    response {
        beast 0 : beast # 神兽信息
    }
}
magicball_one 1903 {    # 获取单个灵珠信息 - 1903
    request {
        id 0 : integer # 玩家灵珠ID
    }
    response {
        magicball 0 : magicBall # 灵珠信息
    }
}
beast_activate 1904 {    # 激活神兽 - 1904
    request {
        id 0 : string # 神兽ID
    }
    response {
        beast 0 : beast # 神兽信息
    }
}
beast_practice 1905 {    # 神兽双修 - 1905
    request {
        id 0 : integer # 玩家神兽ID
    }
    response {
        beast 0 : beast # 神兽信息
        point 1 : integer # 双修点数
    }
}
beast_buyPracticePoint 1906 {    # 购买神兽双修点数 - 1906
    request {

    }
    response {
        point     0 : integer # 更新后的双修点数
        golden    1 : integer # 剩余仙晶
        buyCount  2 : integer # 每日剩余购买次数
    }
}
beast_upgrade 1907 {    # 升级（喂养）神兽 - 1907
    request {
        id 0 : integer # 玩家神兽ID
    }
    response {
        beast         0 : beast # 神兽信息    
        exp           1 : integer # 额外增加的经验序号 1 ～ 5
        upgradePoint  2 : integer # 剩余精魂
        freeUpPoint   3 : integer # 剩余免费升级次数
    }
}
beast_activateBuff 1908 {    # 激活神兽的Buff技能 - 1908
    request {
        id    0 : integer # 玩家神兽ID    
        type  1 : integer # 激活类型    "0 - 无 1 - 1天 2 - 3天 3 - 5天"
    }
    response {
        remainTime 0 : integer # 剩余时间
        point      1 : integer # 剩余双修点数
    }
}
magicball_Combat 1909 {    # 获得灵珠的副本战斗 - 1909
    request {
        id 0 : string # 灵珠ID
    }
    response {
        # TODO to finish this
    }
}
magicball_Upgrade 1910 {    # 升级灵珠 - 1910
    request {
        id    0 : integer # 玩家灵珠ID    
        type  1 : integer # 升级类型    "0 - 安配置升级1次 1 - 直接升1级，如果数量不够，用掉剩余所有碎片"
    }
    response {
        magicball 0 : magicBall # 灵珠信息
        count     1 : integer # 剩余灵珠碎片数量
    }
}
magicball_activate 1911 {    # 选择生效的灵珠技能 - 1911
    request {
        id 0 : integer # 玩家灵珠ID
    }
    response {
        success 0 : integer # 是否成功    "0 - 成功 1 - 不成功"
    }
}
magicball_multipleCombat 1912 {    # 灵珠关卡扫荡 - 1912
    request {
        id    0 : string # 灵珠ID    
        type  1 : integer # 扫荡类型    "0 - 普通扫荡 1 - VIP扫荡"
    }
    response {
        campaign    0 : campaignLevel # 扫荡后的关卡信息
        mballPiece  1 : integer # 灵珠碎片数量，此字段只在灵珠战斗中有效
        time        2 : integer # 灵珠扫荡冷却时间
        golden      3 : integer # 玩家剩余元宝
        ap          4 : integer # 玩家剩余体力
    }
}


]]

beast.s2c = [[


]]


return beast