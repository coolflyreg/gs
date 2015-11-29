-- 装备信息（17XX）

local equipment = {}

equipment.types = [[


]]

equipment.c2s = [[

equipment_all 1701 {    # 获取全部装备信息 - 1701
    request {

    }
    response {
        equipments 0 : *equipment # 装备列表
    }
}


equipment_one 1702 {    # 获取单个装备信息 - 1702
    request {
        id 0 : integer # 玩家装备ID
    }
    response {
        equipment 0 : equipment # 装备信息
    }
}

equipment_sell 1703 {    # 出售装备 - 1703
    request {
        id 0 : integer # 玩家装备ID
    }
    response {
        money 0 : integer # 获得的钱币。
    }
}
equipment_upgrade 1704 {    # 升级（强化）装备 - 1704
    request {
        id 0 : integer # 玩家装备ID
    }
    response {
        equipment 0 : equipment # 装备信息
        money     1 : integer # 剩余货币
        character 2 : character # 角色信息
    }
}
equipment_renew 1705 {    # 重铸装备 - 1705
    request {
        id 0 : integer # 玩家装备ID
    }
    response {
        equipment 0 : equipment # 装备信息
        money     1 : integer # 剩余货币
        itemCount 2 : integer # 剩余道具数量
        character 3 : character # 角色信息
    }
}


]]

equipment.s2c = [[


]]


return equipment