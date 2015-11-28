
local types = [[

.package {
    type 0 : integer
    session 1 : integer
}

.player {    # 2.1.1 玩家信息
    id            0 : string # 玩家ID    
    level         1 : integer # 玩家级别    
    exp           2 : integer # 经验    
    vipLevel      3 : integer # VIP等级    
    ap            4 : integer # 行动点数    
    mp            5 : integer # 元神点数    
    bup           6 : integer # 神兽精魂    
    bpp           7 : integer # 神兽双修点数    
    mbfc          8 : integer # 灵珠碎片数量    
    lastAPTime    9 : integer # 下次行动点恢复时间    
    lastMPTime   10 : integer # 下次元神点恢复时间    
    name         11 : string # 队伍名称    
    money        12 : integer # 游戏货币    
    golden       13 : integer # 游戏代币    
    boughtG      14 : integer # 玩家总充值量    
    rousing      15 : integer # 今日鼓舞次数    
    first        16 : integer # 玩家是否完成首冲    0 - 未完成  1 - 完成
    init         17 : integer # 玩家是否创建了队伍    0 - 未创建 1 - 创建了
}

.character {    # 2.1.2 角色信息
    id             0 : integer # 玩家角色ID # 
    tid            1 : string # 角色ID # 
    level          2 : integer # 角色级别 # 
    exp            3 : integer # 经验 # 
    wuli           4 : integer # 武力 # 
    lingli         5 : integer # 灵力 # 
    minjie         6 : integer # 敏捷 # 
    qixue          7 : integer # 气血 # 
    fangyu         8 : integer # 防御 # 
    mingzhong      9 : integer # 命中 # 
    shanbi        10 : integer # 闪避 # 
    baoji         11 : integer # 暴击 # 
    kangbao       12 : integer # 抗暴 # 
    huixin        13 : integer # 会心 # 
    skillCapability    14 : integer # 神识 # 
    price         15 : integer # 战斗力 # 
    breakLevel    16 : integer # 突破级别 # 
    potential     17 : integer # 剩余潜力值 # 
    relation1     18 : integer # 姻缘1是否开启 # "0 - 未开启 1 - 开启"
    relation2     19 : integer # 姻缘2是否开启 # "0 - 未开启 1 - 开启"
    relation3     20 : integer # 姻缘3是否开启 # "0 - 未开启 1 - 开启"
    relation4     21 : integer # 姻缘4是否开启 # "0 - 未开启 1 - 开启"
    relation5     22 : integer # 姻缘5是否开启 # "0 - 未开启 1 - 开启"
    relation6     23 : integer # 姻缘6是否开启 # "0 - 未开启 1 - 开启"
}

.equipment {    # 2.1.3 装备信息
    id               0 : integer # 玩家装备ID # 
    tid              1 : string # 装备ID # 
    cid              2 : integer # 玩家角色ID # 
    level            3 : integer # 装备级别 # 
    money            4 : integer # 升级所需货币 # 
    mainAttrValue    5 : integer # 主属性值 # 
    initValue        6 : integer # 初始 # 
    strongerValue    7 : string # Float  # 成长 # 
    price            8 : integer # 战斗力 # 
    sprice           9 : integer # 已计算好的出售价格 # 
}

.skill {    # 2.1.4 法宝信息
    id            0 : integer # 玩家法宝ID # 
    tid           1 : string # 法宝ID # 
    cid           2 : integer # 玩家角色ID # 
    index         3 : integer # 法宝装备位置 # 
    level         4 : integer # 法宝级别 # 
    exp           5 : integer # 经验 # 
    money         6 : integer # 升级所需货币 # 
    mainAttrValue 7 : integer # 主属性值 # 
    mainAttrPercent 8 : string # Float  # 主属性百分比值 # 
    price         9 : integer # 战斗力 # 
}

.formation {    # 2.1.5 阵法信息
    id                0 : integer # 玩家阵法ID # 
    tid               1 : string # 阵法ID # 
    level             2 : integer # 阵法级别 # 
    exp               3 : integer # 经验 # 
    money             4 : integer # 升级所需货币 # 
    frontAttrPercent  5 : integer # 阵首属性百分比值 # 
    frontAttrValue    6 : integer # 阵首属性固定数值 # 
    middleAttrPercent 7 : integer # 阵中属性百分比值 # 
    middleAttrValue   8 : integer # 阵中属性固定数值 # 
    tailAttrPercent   9 : integer # 阵尾属性百分比值 # 
    tailAttrValue    10 : integer # 阵尾属性固定数值 # 
    price            11 : integer # 战斗力 # 
}

.partner {    # 2.1.6 护法信息
    index         0 : integer # 护法位置 # 
    characterId   1 : string # 护法角色ID # 
    rank          2 : integer # 护法位置品级 # 
    attribute     3 : integer # 属性类型 # 
    percentValue  4 : string # Float  # 属性百分比值 # 
    numberValue   5 : string # Float  # 属性固定值 # 
    cid           6 : string # 专属角色ID # 
}

.campaignLevel {    # 2.1.7 关卡信息
    id            0 : string # 关卡ID # 
    stars         1 : integer # 关卡得星 # 0 - 表示本关未胜利
    combatCount   2 : integer # 战斗剩余次数 # 
    refreshCount  3 : integer # 刷新剩余次数 # 
    gotReward     4 : integer # 是否获得奖励 # "0 - 表示未领取 1 - 表示已领取"
}

.campaign {    # 2.1.8 地点信息
    id              0 : string # 地点ID # 
    beginnerLevels  1 : *campaignLevel # 普通关卡数组 # 
    advanceLevels   2 : *campaignLevel # 高级关卡列表 # 
    expertLevels    3 : *campaignLevel # 宗师关卡列表 # 
    passed          4 : integer # 是否通关 # "0 - 未通关 1 - 通关"
}

.starPos {    # 2.1.9 星宿信息
    id             0 : integer # 玩家星宿ID # 
    cid            1 : integer # 玩家角色ID # 
    spid           2 : string # 星宿ID # 
    index          3 : integer # 星宿位置 # 
    level          4 : integer # 星宿级别 # 
    exp            5 : integer # 星宿经验 # 
    numberValue    6 : string # Float  # 星宿属性的数字值 # 
}

.beast {    # 2.1.10 神兽信息
    id        0 : integer # 玩家神兽ID # 
    tid       1 : string # 神兽ID # 
    level     2 : integer # 级别 # 
    exp       3 : integer # 经验 # 
    price     4 : integer # 战斗力 # 
    wuli      5 : integer # 武力 # 
    lingli    6 : integer # 灵力 # 
    minjie    7 : integer # 敏捷 # 
    baoji     8 : integer # 暴击 # 
    huixin    9 : integer # 会心 # 
    chuantou 10 : integer # 穿透 # 
    angry    11 : integer # 怒气值 # 
    actTime  12 : integer # Buff技能有效剩余时间 # "0 - 未激活 >0 剩余激活时间"
    practice 13 : integer # 是否可以双修 # "0 - 不可以 1 - 可以"
}

.magicBall {    # 2.1.11 灵珠信息
    id           0 : integer # 玩家灵珠ID # 
    tid          1 : string # 灵珠ID # 
    level        2 : integer # 级别 # 
    exp          3 : integer # 经验 # 
    upValue      4 : integer # 增溢属性值 # 
    downValue    5 : integer # 减溢属性值 # 
    downPercent  6 : integer # 减溢属性百分比 # 
}

.fragment {    # 2.1.12 碎片信息
    tid      0 : string # 碎片ID # 
    count    1 : integer # 数量 # 
}

.item {    # 2.1.13 物品信息
    id              0 : string # 物品ID # 
    icon            1 : string # 物品图标 # 
    name            2 : string # 物品名称 # 
    category        4 : integer # 物品类别 # "0 - 商品 1 - 礼包"
    note            5 : string # 物品描述 # 
    price           6 : integer # 价格 # 
    discountPrice   7 : integer # 打折后的价格 # 0 - 不打折
    count           8 : integer # 单次购买所得数量 # 
    state           9 : integer # 物品状态 # "0 - 无 1 - 新品 2 - 热卖 3 - 售馨"
    count4Player   10 : integer # 每玩家限购数量 # 
    count4Service  11 : integer # 全服限购数量 # 
    countPerDay    12 : integer # 每玩家每天限购数量 # 
    remainCount    13 : integer # 剩余可购买次数 # 
}

.product {    # 2.1.14 商品信息
    id    0 : string # 商品ID # 
    icon  1 : string # 商品图标 # 
    name  2 : string # 商品名称 # 
    price 3 : integer # 商品价格 # 
    count 4 : integer # 单次购买所得数量 # 
}

.beastTouch {    # 2.1.15 神兽缠绵信息
    id            0 : integer # 缠绵ID # 
    time          1 : integer # 缠绵倒计时 # 
    exp           2 : integer # 缠绵单倍经验 # 
    itemId        3 : string # 缠绵兜售的物品ID # 
    count         4 : integer # 兜售数量 # 
    price         5 : integer # 兜售价格 # 
    characterId   6 : string # 角色id # 
    useCount      7 : integer # 所需道具数量 # 
}

]]

return types

