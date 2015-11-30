-- 角色信息（15XX）


local characters = {}

characters.types = [[

.soul {    # 魂魄
    cid     0 : string # 角色ID
    count   1 : integer # 魂魄数量
}

.attr {    # 变更了的属性
    attribute 0 : integer # 属性类别
    amount    1 : integer # 属性值变更量
}

.attrs {    # 变更了的属性数组
    attrs 0 : *attr # 属性数组
}

.attrStatus {    # 变更的属性状态
    attribute 0 : integer # 属性类别
    up        1 : integer # 上升或降低
    limit     2 : integer # 是否达到界限
}

.recuritInfo {    # 招募信息	
    type      0 : integer # 招募类型	
    count     1 : integer # 剩余免费次数	
    itemCount 2 : integer # 金仙抽奖所需香火	
    time      3 : integer # 距离下次免费剩余时间秒数
    first     4 : integer # 是否首次付费抽取	"0 - 非首次 1 - 首次"
}

]]

characters.c2s = [[

characters_all 1501 {    # 获取全部角色信息 - 1501
    request {

    }
    response {
        characters 0 : *character # 角色列表
        souls      1 : *soul # 魂魄列表
        stars      2 : *starPos # 星宿信息数组
    }
}
characters_one 1502 {    # 获取单个角色信息 - 1502
    request {
        id        0 : integer # 玩家角色ID
    }
    response {
        character 1 : character # 角色信息
    }
}

characters_transferExp 1503 {    # 角色传功 - 1503
    request {
        targetId 0 : integer # 传功目标玩家角色ID
        cid      1 : integer # 选中传功玩家角色ID
        itemId   2 : string # 使用的道具ID
    }
    response {
        character 0 : *character # 传功后的角色信息
        itemCount 1 : integer # 道具剩余数量
        stars     2 : *starPos # 星宿信息数组
    }
}

characters_assignEquip 1504 {    # 穿戴装备 - 1504
    request {
        id    0 : integer # 玩家角色ID
        eid   1 : integer # 玩家装备ID
        etype 2 : integer # 装备类型
    }
    response {
        characters   0 : *character # 装备后的角色信息
        updatedAttrs 1 : *attrs # 多个角色变更后的数组
        attrs        2 : *attr # 变更了的属性数组
    }
}

characters_changeEquip 1505 {    # 变更装备 - 1505
    request {
        id    0 : integer # 玩家角色ID
        oid   1 : integer # 旧的玩家装备ID
        eid   2 : integer # 要更换的玩家装备ID
        etype 3 : integer # 装备类型
    }
    response {
        characters    0 : *character # 装备后的角色信息
        updatedAttrs  1 : *attrs # 多个角色变更后的数组
        attrs         2 : *attr # 变更了的属性数组
    }
}

characters_UnassignEquip 1506 {    # 卸下装备 - 1506
    request {
        id    0 : integer # 玩家角色ID
        eid   1 : integer # 玩家装备ID
        etype 2 : integer # 装备类型
    }
    response {
        characters    0 : *character # 更新后的角色信息
        updatedAttrs  1 : *attr # 变更了的属性数组
    }
}

characters_assignSkill 1507 {    # 装备法宝 - 1507
    request {
        id    0 : integer # 玩家角色ID
        sid   1 : integer # 玩家法宝ID
        index 2 : integer # 法宝槽索引位
    }
    response {
        characters    0 : *character # 装备后的角色信息
        updatedAttrs  1 : *attrs # 多个角色变更后的数组
    }
}

characters_changeSkill 1508 {    # 更换法宝 - 1508
    request {
        id    0 : integer # 玩家角色ID
        sid   1 : integer # 要更换的玩家法宝ID
        index 2 : integer # 法宝槽索引位
    }
    response {
        characters    0 : *character # 装备后的角色信息
        updatedAttrs  1 : *attrs # 多个角色变更后的数组
    }
}

characters_UnassignSkill 1509 {    # 卸下法宝 - 1509
    request {
        id    0 : integer # 玩家角色ID
        sid   1 : integer # 玩家法宝ID
        index 2 : integer # 法宝槽索引位
    }
    response {
        characters     0 : *character # 更新后的角色信息
        updatedAttrs   1 : *attr # 变更了的属性数组
    }
}

characters_newStarPos 1510 {    # 刷新星宿 - 1510
    request {
        id    0 : integer # 玩家角色ID
        index 1 : integer # 玩家星宿位置
    }
    response {
        star         0 : starPos # 星宿信息
        itemCount    1 : integer # 所消耗道具的剩余数量
        characters   2 : *character # 更新后的角色信息
        updatedAttrs 3 : *attr # 变更了的属性数组
    }
}

characters_upgradeStarPos 1511 {    # 升级星宿 - 1511
    request {
        id          0 : integer # 玩家角色ID
        index       1 : integer # 玩家星宿位置
        characters  2 : *string # 升级消耗的角色数组
        characterId 3 : integer # 升级消耗的玩家角色ID
        souls       4 : *soul # 升级消耗的魂魄数组
    }
    response {
        star         0 : starPos # 星宿信息
        characters   1 : *character # 更新后的角色信息
        updatedAttrs 2 : *attr # 变更了的属性数组
    }
}

characters_train 1512 {    # 角色培养 - 1512
    request {
        id        0 : integer # 玩家角色ID
        type      1 : integer # 培养方式
    }
    response {
        wuli        0 : integer # 武力
        lingli      1 : integer # 灵力
        minjie      2 : integer # 敏捷
        qixue       3 : integer # 气血
        fangyu      4 : integer # 防御
        golden      5 : integer # 剩余黄金
        itemCount   6 : integer # 剩余道具总数
        qianli      7 : integer # 即将消耗的潜力点
        status      8 : *attrStatus # 变更属性状态数组
    }
}

characters_acceptTrain 1513 {    # 接受培养值 - 1513
    request {
        id 0 : integer # 玩家角色ID
    }
    response {
        character 0 : character # 更新后的角色信息
    }
}

characters_declineTrain 1514 {    # 不接受培养值 - 1514
    request {
        id 0 : integer # 玩家角色ID
    }
    response {

    }
}

characters_breakThroughs 1515 {    # 魂魄突破 - 1515
    request {
        id 0 : string # 角色ID
    }
    response {
        count     0 : integer # 角色魂魄剩余数量
        character 1 : character # 突破后的角色信息
    }
}

characters_recruit 1516 {    # 魂魄招募 - 1516
    request {
        id 0 : string # 角色ID
    }
    response {
        count     0 : integer # 角色魂魄剩余数量
        character 1 : character # 招募后的角色信息
        skill     2 : skill # 招募到的角色的本命法宝信息
    }
}

characters_recruitInfo 1517 {    # 获取神仙招募信息 - 1517
    request {

    }
    response {
        infos 0 : *recuritInfo # 招募信息数组	
    }
}

characters_shopRecruit 1518 {    # 抽取角色（聚仙榜） - 1518
    request {
        type 0 : integer # 招募类型
    }
    response {
        character     0 : character # 角色信息
        skill         1 : skill # 抽取到的角色本命法宝信息
        soul          2 : soul # 魂魄
        characterId   3 : string # 角色ID
        count         4 : integer # 魂魄数量
        itemCount     5 : integer # 香火数量
        money         6 : integer # 银两
        golden        7 : integer # 元宝
    }
}


]]

characters.s2c = [[


]]


return characters