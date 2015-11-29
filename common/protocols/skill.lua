-- 法宝信息（18XX）

local skill = {}

skill.types = [[
]]

skill.c2s = [[


skill_all 1801 {    # 获取全部法宝信息 - 1801
    request {

    }
    response {
        skills 0 : *skill # 法宝列表
    }
}


skill_one 1802 {    # 获取单个法宝信息 - 1802
    request {
        id 0 : integer # 玩家法宝ID
    }
    response {
        skill 0 : skill # 法宝信息
    }
}


skill_upgrade 1803 {    # 升级法宝 - 1803
    request {
        id         0 : integer # 玩家法宝ID
        skillIds   1 : *integer # 消耗的玩家法宝ID数组
    }
    response {
        skill     0 : skill # 法宝信息
        money     1 : integer # 剩余货币
        character 2 : character # 角色信息
    }
}


]]

skill.s2c = [[


]]


return skill