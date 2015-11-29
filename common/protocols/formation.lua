-- 阵法信息（16XX）

local formation = {}

formation.types = [[
]]

formation.c2s = [[

formation_all 1601 {    # 获取全部阵法信息 - 1601
    request {

    }
    response {
        formations 0 : *formation # 阵法数组
    }
}

formation_one 1602 {    # 获取单个阵法信息 - 1602
    request {
        id 0 : integer # 玩家阵法ID
    }
    response {
        formation 0 : formation # 阵法信息
    }
}

formation_setup 1603 {    # 设置阵法 - 1603
    request {
        id 0 : integer # 玩家阵法ID
    }
    response {
        characters 0 : *character # 更新的角色数组
    }
}

formation_characters 1604 {    # 获取全部上阵角色 - 1604
    request {

    }
    response {
        characterIds 0 : *integer # 角色ID列表
        beastId      1 : integer # 神兽ID
    }
}

formation_setcharacter 1605 {    # 设置上阵角色 - 1605
    request {
        index         0: integer # 阵法位置
        characterId   1 : integer # 角色ID
    }
    response {
        characterIds 0 : *integer # 角色ID列表
        characters   1 : *character # 更新的角色数组
        partner      2 : partner # 更新的护法位置
    }
}

formation_upgrade 1606 {    # 升级阵法 - 1606
    request {
        id            0: integer # 玩家阵法ID
        formationIds  1 : *integer # 消耗的阵法ID数组
    }
    response {
        formation 0 : formation # 阵法信息
        money     1 : integer # 剩余货币
    }
}

formation_friends 1607 {    # 获取全部护法信息 - 1607
    request {

    }
    response {
        partners 0 : *partner # 护法信息数组
    }
}

formation_setFriend 1608 {    # 设置护法 - 1608
    request {
        index         0 : integer # 护法位置
        characterId   1 : integer # 玩家角色ID
    }
    response {
        partners     0 : *partner # 有关的护法位置属性数组
        characters   1 : *character # 影响的角色数组
    }
}

formation_newFriendPos 1609 {    # 刷新护法位置属性 - 1609
    request {
        index 0 : integer # 护法位置
    }
    response {
        partner     0 : partner # 护法位置属性
        characters  1 : *character # 影响的角色数组
        itemCount   2 : integer # 剩余道具数量
    }
}

formation_setBeast 1610 {    # 设置上阵神兽 - 1610
    request {
        id 0 : integer # 神兽ID
    }
    response {
        success 0 : integer # 是否成功
    }
}

formation_unlockFriendPos 1611 {    # 开启护法位置 - 1611
    request {
        index 0 : integer # 护法位置
    }
    response {
        partner     0 : partner # 护法位置属性
        characters  1 : *character # 影响的角色数组
        golden      2 : integer # 仙晶
    }
}



]]

formation.s2c = [[


]]


return formation