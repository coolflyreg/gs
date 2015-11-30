-- 商城（24XX)

local shop = {}

shop.types = [[
]]

shop.c2s = [[

shop_all 2401 {    # 获取商城所有物品 - 2401
    request {

    }
    response {
        items 0 : *item # 商城出售物品列表
    }
}

shop_purchase 2402 {    # 购买物品 - 2402
    request {
        id    0 : string # 商品ID
        count 1 : integer # 购买数量
    }
    response {
        id     0 : string # 物品ID
        count  1 : integer # 物品剩余数量
        golden 2 : integer # 剩余仙晶(元宝)
    }
}

]]

shop.s2c = [[


]]


return shop