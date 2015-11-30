-- 玩家信息（13XX） done

local player = {}

player.types = [[

.other_skill {    # 其他玩家技能信息
    sid     0 : string # 技能ID
    level   1 : integer # 技能级别
    idx     2 : integer # 法宝位置
}

.other_equip {    # 其他玩家装备信息
    eid     0 : string # 装备ID
    level   1 : integer # 装备级别
}

.other_star {    # 其他玩家星宿信息
    spid     0 : string # 星宿ID
    level    1 : integer # 星宿级别
}

.other_character {    # 其他玩家角色信息
    cid         0 : string # 角色ID
    level       1 : integer # 级别
    exp         2 : integer # 经验
    capability  3 : integer # 神识
    wuli        4 : integer # 武力
    lingli      5 : integer # 灵力
    minjie      6 : integer # 敏捷
    qixue       7 : integer # 气血
    fangyu      8 : integer # 防御
    mingzhong   9 : integer # 命中
    shanbi     10 : integer # 闪避
    baoji      11 : integer # 暴击
    kangbao    12 : integer # 抗暴
    huixin     13 : integer # 会心
    relation1  14 : integer # 姻缘1是否开启
    relation2  15 : integer # 姻缘2是否开启
    relation3  16 : integer # 姻缘3是否开启
    relation4  17 : integer # 姻缘4是否开启
    relation5  18 : integer # 姻缘5是否开启
    relation6  19 : integer # 姻缘6是否开启
    fidx       20 : integer # 角色所在的阵法位置
    equips     21 : *other_equip # 装备数组
    skills     22 : *other_skill # 技能数组
    stars      23 : *other_star # 星宿数组
    price      24 : integer # 角色身价
}

.other_formation {    # 其他玩家阵法信息
    fid     0 : string # 阵法ID
    level   1 : integer # 阵法级别
}

.other_player {    # 其他玩家信息
    id            0 : integer # 玩家ID
    name          1 : string  # 玩家名称
    level         2 : integer # 斗法等级
    exp           3 : integer # 经验值
    total         4 : integer # 斗法总场数
    win           5 : integer # 胜利场数
    fail          6 : integer # 失败场数
    price         7 : integer # 上阵总身价
    characters    8 : *other_character # 上阵角色列表
    formation     9 : other_formation # 阵法信息
    beast        10 : beast # 神兽信息
}

.viplevel {    # VIP级别信息
    level   0 : integer # VIP级别
    got     1 : integer # 是否已购买VIP礼包
}

]]

player.c2s = [[

player_names 1301 {    # 生成玩家队伍名称 - 1301
    request {

    }
    response {
        names 0 : string # 名称数组
    }
}

player_create 1302 {    # 创建玩家信息 - 1302
    request {
        uid      0 : integer # 用户中心uid
        name     1 : string # 队伍名称
    }
    response {
        success  0 : integer # 是否创建成功
    }
}

player_init 1303 {    # 创建初始角色信息 - 1303
    request {
        characterId 0 : string # 角色ID
    }
    response {
        success     0 : integer # 是否创建成功
    }
}

player_changeName 1304 {    # 修改玩家队伍名称 - 1304
    request {
        name     0 : string # 队伍名称
    }
    response {
        success  0 : integer # 是否修改成功
    }
}

player_reset 1305 {    # 重置玩家账号数据 - 1305
    request {

    }
    response {
        success 0 : integer # 是否重置成功
    }
}

player_restoreAP 1306 {    # 吃道具恢复体力 - 1306
    request {

    }
    response {
        success 0 : integer # 是否重置成功
        count   1 : integer # 道具剩余数量
        ap      2 : integer # 最终体力值
    }
}

player_restoreMP 1307 {    # 吃道具恢复元神 - 1307
    request {

    }
    response {
        success 0 : integer # 是否重置成功
        count   1 : integer # 道具剩余数量
        mp      2 : integer # 最终元气值
    }
}

player_refreshAPMP 1308 {    # 刷新体力和元神值 - 1308
    request {

    }
    response {
        ap        0 : integer # 行动点数
        mp        1 : integer # 元神点数
        apTime    2 : integer # 行动点恢复总时间
        mpTime    3 : integer # 元神点恢复总时间
    }
}

player_info 1309 {    # 获取玩家信息 - 1309
    request {

    }
    response {
        player 0 : player # 玩家信息
    }
}

player_allinfo 1310 {    # 获取玩家全部游戏数据 - 1310
    request {
        cmds 0 : *integer # 协议编号数组
    }
    response {
        # TODO to finish this
    }
}

player_other 1311 {    # 获取其它玩家的上阵信息 - 1311
    request {
        id 0 : integer # 玩家ID
    }
    response {
        player 0 : other_player # 斗法玩家信息

    }
}


player_vipdata 1312 {    # 获取玩家的VIP特权数据 - 1312
    request {

    }
    response {
        levels 0 : *viplevel # VIP级别列表
    }
}

]]

player.s2c = [[


]]


return player