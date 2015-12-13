ID_STANDARD_LEN	= 12		--策划填入的各种ID标准最大长度

FORMATION_MAX_POS	= 7		--上阵的最大数
SKILL_MAX_NUM	= 5		--角色身上最大法宝数
ENEMY_SKILL_MAX_NUM	= 3		--敌人身上最大法宝数
RELATION_MAX_NUM	= 6		--姻缘最大个数

ENEMY_SIDE_WIN	= 0		--敌方胜利
MY_SIDE_WIN	= 1		--我方胜利
NONE_WIN	= 2		--未分胜负

BATTLE_SPOLIATE	= 1		--掠夺战斗
BATTLE_DOUFA	= 2		--斗法战斗

ROBOT_UID	= -999	--机器人uid


--各个品级(角色.装备.法宝.阵法....等)
RANK_DING	= 1
RANK_BING	= 2
RANK_YI	= 3
RANK_JIA	= 4
RANK_SHEN	= 5


--系统参数
SYSTEM_INIT_GOLD	= "player_init_golden"			--初始黄金关键字
SYSTEM_INIT_MONEY	= "player_init_money"				--初始银两关键字
SYSTEM_INIT_PNEUMA	= "player_init_pneuma"			--初始元气关键字
SYSTEM_INIT_STRENGTH	= "player_init_strength"			--初始体力关键字
SYSTEM_INIT_PNEUMA_INTERVAL	= "pneuma_restore_interval"		--元气恢复时间间隔秒关键字
SYSTEM_INIT_STRENGTH_INTERVAL	= "strength_restore_interval"		--体力恢复时间间隔秒关键字
SYSTEM_STRENGTH_ADD_MAX	= "strength_add_max"				--体力叠加上限关键字
SYSTEM_PNEUMA_ADD_MAX	= "pneuma_add_max"				--元气叠加上限关键字
SYSTEM_PROP_CHANGE_PNAME	= "change_pname_itemId"			--更改玩家队伍名称道具关键字
SYSTEM_PROP_STRENGTH	= "strength_itemId"				--补充体力道具关键字
SYSTEM_PROP_PNEUMA	= "pneuma_itemId"					--补充元神道具关键字
SYSTEM_PROP_EQ_RECAST	= "equip_renew_itemId"			--装备重铸道具关键字
SYSTEM_PROP_STAR_REFRESH	= "refresh_star_itemId"			--刷新星宿道具关键字
SYSTEM_PROP_TRANSFER_NOR	= "transfer_itemId_nor"			--普通传功丹道具关键字
SYSTEM_PROP_TRANSFER_SPE	= "transfer_itemId_spe"			--特效传功丹道具关键字
SYSTEM_PROP_TRANSFER_MAG	= "transfer_itemId_mag"			--九转传功丹道具关键字
SYSTEM_STAR1_OPEN_LEVEL	= "star1_open_level"				--星宿位置1开启级别关键字
SYSTEM_STAR2_OPEN_LEVEL	= "star2_open_level"				--星宿位置2开启级别关键字
SYSTEM_STAR3_OPEN_LEVEL	= "star3_open_level"				--星宿位置3开启级别关键字
SYSTEM_STAR4_OPEN_LEVEL	= "star4_open_level"				--星宿位置4开启级别关键字
SYSTEM_STAR5_OPEN_LEVEL	= "star5_open_level"				--星宿位置5开启级别关键字
SYSTEM_STAR6_OPEN_LEVEL	= "star6_open_level"				--星宿位置6开启级别关键字
SYSTEM_STAR7_OPEN_LEVEL	= "star7_open_level"				--星宿位置7开启级别关键字
SYSTEM_STAR8_OPEN_LEVEL	= "star8_open_level"				--星宿位置8开启级别关键字
SYSTEM_DF_BATTLE_PLUS_EXP_PARA_A	= "df_battle_plus_exp_para_a"
SYSTEM_DF_BATTLE_PLUS_EXP_PARA_B	= "df_battle_plus_exp_para_b"
SYSTEM_CHAR_TRAIN_ITEMID	= "character_practice_itemId"		--神仙修炼消耗修炼丹道具关键字
SYSTEM_CHAR_TRAIN_ITEM_USE	= "char_train_item_use"			--神仙修炼一次消耗修炼丹数量关键字
SYSTEM_CHAR_TRAIN_GOLD_USE	= "char_train_gold_use"			--神仙精心修炼一次消耗仙晶数量关键字
SYSTEM_CHAR_TRAIN_LEVEL	= "char_train_level"				--神仙连续10次修炼限制等级关键字
SYSTEM_CHAR_TRAIN_VAL_MIN	= "char_train_val_min"			--神仙修炼增减值下限关键字
SYSTEM_CHAR_TRAIN_VAL_MAX	= "char_train_val_max"			--神仙修炼增减值上限关键字
SYSTEM_CHAR_TRAIN_PT_VAL_MIN	= "char_train_pt_val_min"			--神仙修炼潜力转化值下限关键字
SYSTEM_CHAR_TRAIN_PT_VAL_MAX	= "char_train_pt_val_max"			--神仙修炼潜力转化值上限关键字
SYSTEM_CHAR_TRAIN_RATE_MAX	= "char_train_rate_max"			--神仙修炼属性上限百分比
SYSTEM_CHAR_TRAIN_RATE_MIN	= "char_train_rate_min"			--神仙修炼属性下限百分比
SYSTEM_FRAG_CD_INTERVAL_JIA	= "frag_cd_interval_jia"			--甲级碎片拼合次数消失间隔(秒)
SYSTEM_FRAG_CD_INTERVAL_YI	= "frag_cd_interval_yi"			--乙级碎片拼合次数消失间隔(秒)
SYSTEM_FRAG_CD_INTERVAL_BING	= "frag_cd_interval_bing"			--丙级碎片拼合次数消失间隔(秒)
SYSTEM_FRAG_CD_INTERVAL_DING	= "frag_cd_interval_ding"			--丁级碎片拼合次数消失间隔(秒)
SYSTEM_ROBOT_BATTLE_RATIO_MIN	= "robot_battle_ratio_min"		--机器人战斗值系数最小值关键字
SYSTEM_ROBOT_BATTLE_RATIO_MAX	= "robot_battle_ratio_max"		--机器人战斗值系数最大值关键字
SYSTEM_REFRESH_PARTNER_ITEMID	= "refresh_partner_itemId"		--刷新护法道具关键字
SYSTEM_PARTNER_OPEN_LEVEL	= "partner_open_level"			--护法开启级别关键字
SYSTEM_REFRESH_CAMPAIGN_GOLD	= "refresh_campaign_gold"			--刷新关卡战斗次数所需仙晶关键字
SYSTEM_CD_COMBAT_INTERVAL	= "cd_combat_interval"			--普通关卡单次扫荡cd时间关键字
SYSTEM_CLEAR_CD_COMBAT_GOLD	= "clear_cd_combat_golden"		--普通关卡清除冷却时间所需元宝数关键字
SYSTEM_CD_COMBAT_MB_INTERVAL	= "cd_combat_mb_interval"			--灵珠关卡单次扫荡cd时间关键字
SYSTEM_CLEAR_CD_COMBAT_MB_GOLD	= "clear_cd_combat_mb_golden"		--灵珠关卡清除冷却时间所需元宝数关键字
SYSTEM_COMBAT_MB_VIP_LEVEL	= "combat_mb_vip_level"			--灵珠关卡vip扫荡级别关键字
SYSTEM_COMBAT_LEVEL	= "combat_level"					--普通关卡扫荡开启级别关键字
SYSTEM_COMBAT_VIP_LEVEL	= "combat_vip_level"				--普通关卡扫荡免CD时间VIP级别关键字
SYSTEM_XIANGHUO_ITEMID	= "recruit_itemId"				--香火道具ID关键字
SYSTEM_POST_LEVELUP_DAY	= "post_levelup_day"				--发布仙贴升级累计天数关键字
SYSTEM_BEASTTOUCH_ITEMID	= "beasttouch_itemid"				--双倍缠绵所需道具ID关键字
SYSTEM_BEASTTOUCH_ITEMID_NUM	= "beasttouch_itemid_num"			--双倍缠绵所需道具数量关键字
SYSTEM_FIRST_CHARGE_ITEMID	= "first_charge_itemId"			--首充礼包道具ID关键字
SYSTEM_SIGN_DAILY_MONEY	= "sign_daily_money"				--每日签到所得银两
SYSTEM_SIGN_MONTH_ITEMID	= "sign_month_itemid"				--每日签到满一月所得宝箱
SYSTEM_SIGN_RESIGN_GOLDEN	= "sign_resign_golden"			--每次补签所消耗的元宝
SYSTEM_SIGN_WEEKLY_GOLDEN	= "sign_weekly_golden"			--每日签到满一周所得元宝
SYSTEM_BEAST_BUFF_ACT_SEC	= "beast_buff_act_seconds"		--神兽BUFF每次激活多长时间关键字
SYSTEM_RSG_NOON_BEGIN	= "rsg_noon_begin"				--每日中午吃人参果开始时间
SYSTEM_RSG_NOON_END	= "rsg_noon_end"					--每日中午吃人参果结束时间
SYSTEM_RSG_NIGHT_BEGIN	= "rsg_night_begin"				--每日晚上吃人参果开始时间
SYSTEM_RSG_NIGHT_END	= "rsg_night_end"					--每日晚上吃人参果结束时间
SYSTEM_PROP_CHAT	= "chat_itemId"					--允许聊天广播道具ID，小喇叭ID
SYSTEM_GET_CHAT_MSG_NUM	= "chat_msg_num"					--获取聊天消息条数
SYSTEM_DOUFA_REWARD_BEGIN_TIME	= "doufa_reward_begin_num"		--斗法争霸奖励开启时间
SYSTEM_WJZT_ENEMY_NAME	= "wjzt_enemy_name"				--无尽之塔敌人队伍名称关键字
SYSTEM_HDDL_TIME_BEGIN	= "hddl_time_begin"				--活动大礼活动开启时间
SYSTEM_HDDL_TIME_END	= "hddl_time_end"					--活动大礼活动结束时间
SYSTEM_TBPH_TIME_BEGIN	= "tbph_time_begin"				--通宝票号开始时间
SYSTEM_TBPH_TIME_END	= "tbph_time_end"					--通宝票号结束时间
SYSTEM_TBPH_SUM_GOLD	= "tbph_sum_gold"					--通宝票号摇元宝总数
SYSTEM_SIGN_DAILY_1_GOLD	= "sign_daily_1_gold"				--每日签到第一天所得元宝
SYSTEM_SIGN_DAILY_2_GOLD	= "sign_daily_2_gold"				--每日签到第二天所得元宝
SYSTEM_SIGN_DAILY_3_GOLD	= "sign_daily_3_gold"				--每日签到第三天所得元宝
SYSTEM_SIGN_DAILY_4_GOLD	= "sign_daily_4_gold"				--每日签到第四天所得元宝
SYSTEM_SIGN_DAILY_5_GOLD	= "sign_daily_5_gold"				--每日签到第五天所得元宝
SYSTEM_SIGN_DAILY_6_GOLD	= "sign_daily_6_gold"				--每日签到第六天所得元宝
SYSTEM_SIGN_DAILY_7_GOLD	= "sign_daily_7_gold"				--每日签到第七天所得元宝
SYSTEM_SIGN_DAILY_7_ITEMID	= "sign_daily_7_itemid"			--每日签到第七天所得宝箱
SYSTEM_JLZ_NO_REWARD_KIT = "jlz_no_reward_kit"             --聚灵阵未领取奖励锦囊
SYSTEM_WJZT_SWEEP_KIT = "wjzt_sweep_kit"                --无尽之塔扫荡奖励锦囊
SYSTEM_WJZT_RANK_KIT = "wjzt_rank_kit"                 --无尽之塔排名锦囊
SYSTEM_ROUSING_INI	= "rousing_init"					--鼓舞花费初始值
SYSTEM_ROUSING_ADD	= "rousing_add"					--鼓舞花费成长值
SYSTEM_XFDL_TIME_BEGIN	= "xfdl_time_begin"			--消费大礼活动开启时间
SYSTEM_XFDL_TIME_END	= "xfdl_time_end"			--消费大礼活动结束时间
SYSTEM_THDS_KIT = "thds_kit"                      --土豪诞生锦囊


--初始值已经在数据库中配置,此处用于容错
SYSTEM_INIT_GOLD_V	= 200								--初始黄金
SYSTEM_INIT_MONEY_V	= 500								--初始银两
SYSTEM_INIT_PNEUMA_V	= 10								--初始元气
SYSTEM_INIT_STRENGTH_V	= 20								--初始体力
SYSTEM_INIT_PNEUMA_INTERVAL_V	= 1800							--元气恢复时间间隔秒
SYSTEM_INIT_STRENGTH_INTERVAL_V	= 1800							--体力恢复时间间隔秒
SYSTEM_STRENGTH_ADD_MAX_V	= 300								--体力叠加上限
SYSTEM_PNEUMA_ADD_MAX_V	= 300								--元神叠加上限
SYSTEM_PROP_CHANGE_PNAME_V	= "item3008"						--更改队伍名称道具
SYSTEM_PROP_STRENGTH_V	= "item3017"						--补充体力道具
SYSTEM_PROP_PNEUMA_V	= "item3018"						--补充元神道具
SYSTEM_PROP_EQ_RECAST_V	= "item3004"						--装备重铸道具
SYSTEM_PROP_STAR_REFRESH_V	= "item3003"						--刷新星宿道具
SYSTEM_PROP_TRANSFER_NOR_V	= "item3005"						--普通传功丹道具
SYSTEM_PROP_TRANSFER_SPE_V	= "item4006"						--特效传功丹道具
SYSTEM_PROP_TRANSFER_MAG_V	= "item4007"						--九转传功丹道具
SYSTEM_PROP_TRANSFER_NOR_I_V	= 80								--普通传功丹道具功效
SYSTEM_PROP_TRANSFER_SPE_I_V	= 100								--特效传功丹道具功效
SYSTEM_STAR1_OPEN_LEVEL_V	= 15								--星宿位置1开启级别
SYSTEM_STAR2_OPEN_LEVEL_V	= 30								--星宿位置2开启级别
SYSTEM_STAR3_OPEN_LEVEL_V	= 45								--星宿位置3开启级别
SYSTEM_STAR4_OPEN_LEVEL_V	= 60								--星宿位置4开启级别
SYSTEM_STAR5_OPEN_LEVEL_V	= 75								--星宿位置5开启级别
SYSTEM_STAR6_OPEN_LEVEL_V	= 90								--星宿位置6开启级别
SYSTEM_STAR7_OPEN_LEVEL_V	= 105								--星宿位置7开启级别
SYSTEM_STAR8_OPEN_LEVEL_V	= 120								--星宿位置8开启级别
SYSTEM_DF_BATTLE_PLUS_EXP_PARA_A_V	= 100
SYSTEM_DF_BATTLE_PLUS_EXP_PARA_B_V	= 1
SYSTEM_CHAR_TRAIN_ITEMID_V	= "item3002"						--神仙修炼消耗修炼丹道具
SYSTEM_CHAR_TRAIN_ITEM_USE_V	= 1								--神仙修炼一次消耗修炼丹数量
SYSTEM_CHAR_TRAIN_GOLD_USE_V	= 1								--神仙精心修炼一次消耗仙晶数量
SYSTEM_CHAR_TRAIN_LEVEL_V	= 15								--神仙连续10次修炼限制等级
SYSTEM_CHAR_TRAIN_VAL_MIN_V	= 1								--神仙修炼增减值下限
SYSTEM_CHAR_TRAIN_VAL_MAX_V	= 3								--神仙修炼增减值上限
SYSTEM_CHAR_TRAIN_PT_VAL_MIN_V	= 1								--神仙修炼潜力转化值下限
SYSTEM_CHAR_TRAIN_PT_VAL_MAX_V	= 3								--神仙修炼潜力转化值上限
SYSTEM_CHAR_TRAIN_RATE_MAX_V	= 230								--神仙修炼属性上限百分比
SYSTEM_CHAR_TRAIN_RATE_MIN_V	= 50								--神仙修炼属性下限百分比
SYSTEM_FRAG_CD_INTERVAL_JIA_V	= 295200							--甲级碎片拼合次数消失间隔(秒)
SYSTEM_FRAG_CD_INTERVAL_YI_V	= 172800							--乙级碎片拼合次数消失间隔(秒)
SYSTEM_FRAG_CD_INTERVAL_BING_V	= 86400							--丙级碎片拼合次数消失间隔(秒)
SYSTEM_FRAG_CD_INTERVAL_DING_V	= 43200							--丁级碎片拼合次数消失间隔(秒)
SYSTEM_ROBOT_BATTLE_RATIO_MIN_V	= 0.7								--机器人战斗值系数最小值
SYSTEM_ROBOT_BATTLE_RATIO_MAX_V	= 1.1								--机器人战斗值系数最大值
SYSTEM_REFRESH_PARTNER_ITEMID_V	= "item3001"						--刷新护法道具
SYSTEM_PARTNER_OPEN_LEVEL_V	= 20								--护法开启级别
SYSTEM_REFRESH_CAMPAIGN_GOLD_V	= 10								--刷新关卡战斗次数所需仙晶
SYSTEM_CD_COMBAT_INTERVAL_V	= 300								--普通关卡单次扫荡cd时间
SYSTEM_CLEAR_CD_COMBAT_GOLD_V	= 200								--普通关卡清除冷却时间所需元宝数
SYSTEM_CD_COMBAT_MB_INTERVAL_V	= 1800							--灵珠关卡单次扫荡cd时间
SYSTEM_CLEAR_CD_COMBAT_MB_GOLD_V	= 30								--灵珠关卡清除冷却时间所需元宝数
SYSTEM_COMBAT_MB_VIP_LEVEL_V	= 4								--灵珠关卡vip扫荡级别
SYSTEM_COMBAT_LEVEL_V	= 10								--普通关卡扫荡开启级别
SYSTEM_COMBAT_VIP_LEVEL_V	= 5								--普通关卡扫荡免CD时间VIP级别
SYSTEM_XIANGHUO_ITEMID_V	= "item3035"						--香火道具id
SYSTEM_POST_LEVELUP_DAY_V	= 10								--发布仙贴升级累计天数
SYSTEM_BEASTTOUCH_ITEMID_V	= "item9999"						--双倍缠绵所需道具ID
SYSTEM_BEASTTOUCH_ITEMID_NUM_V	= 10								--双倍缠绵所需道具数量
SYSTEM_FIRST_CHARGE_ITEMID_V	= "item4052"						--首充礼包道具ID
SYSTEM_SIGN_DAILY_MONEY_V	= 100								--每日签到所得银两
SYSTEM_SIGN_MONTH_ITEMID_V	= "item4054"						--每日签到满一月所得宝箱
SYSTEM_SIGN_RESIGN_GOLDEN_V	= 30								--每次补签所消耗的元宝
SYSTEM_SIGN_WEEKLY_GOLDEN_V	= 80								--每日签到满一周所得元宝
SYSTEM_BEAST_BUFF_ACT_SEC_V	= 86400							--神兽BUFF每次激活多长时间
SYSTEM_RSG_NOON_BEGIN_V	= 12								--每日中午吃人参果开始时间
SYSTEM_RSG_NOON_END_V	= 14								--每日中午吃人参果结束时间
SYSTEM_RSG_NIGHT_BEGIN_V	= 18								--每日晚上吃人参果开始时间
SYSTEM_RSG_NIGHT_END_V	= 20								--每日晚上吃人参果结束时间
SYSTEM_PROP_CHAT_V	= "item3009"						--允许聊天广播道具ID，小喇叭ID
SYSTEM_GET_CHAT_MSG_NUM_V	= 30								--获取聊天消息条数
SYSTEM_DOUFA_REWARD_BEGIN_TIME_V	= "0"								--斗法争霸奖励开启时间
SYSTEM_WJZT_ENEMY_NAME_V	= "noname"						--无尽之塔敌人队伍名称
SYSTEM_HDDL_TIME_BEGIN_V	= "0000-00-00 00:00:00"			--活动大礼活动开启时间
SYSTEM_HDDL_TIME_END_V	= "0000-00-00 00:00:00"			--活动大礼活动结束时间
SYSTEM_TBPH_TIME_BEGIN_V	= "0000-00-00 00:00:00"			--通宝票号开始时间
SYSTEM_TBPH_TIME_END_V	= "0000-00-00 00:00:00"			--通宝票号结束时间
SYSTEM_TBPH_SUM_GOLD_V	= 5								--通宝票号摇元宝总数
SYSTEM_SIGN_DAILY_1_GOLD_V	= 10								--每日签到第一天所得元宝
SYSTEM_SIGN_DAILY_2_GOLD_V	= 10								--每日签到第二天所得元宝
SYSTEM_SIGN_DAILY_3_GOLD_V	= 10								--每日签到第三天所得元宝
SYSTEM_SIGN_DAILY_4_GOLD_V	= 10								--每日签到第四天所得元宝
SYSTEM_SIGN_DAILY_5_GOLD_V	= 10								--每日签到第五天所得元宝
SYSTEM_SIGN_DAILY_6_GOLD_V	= 10								--每日签到第六天所得元宝
SYSTEM_SIGN_DAILY_7_GOLD_V	= 10								--每日签到第七天所得元宝
SYSTEM_SIGN_DAILY_7_ITEMID_V	= "item4054"						--每日签到第七天所得宝箱
SYSTEM_ROUSING_INI_V	= 5								--鼓舞花费初始值
SYSTEM_ROUSING_ADD_V	= 5								--鼓舞花费成长值
SYSTEM_XFDL_TIME_BEGIN_V	= "0000-00-00 00:00:00"			--消费大礼活动开启时间
SYSTEM_XFDL_TIME_END_V	= "0000-00-00 00:00:00"			--消费大礼活动结束时间




PROP_BEAST_ACTIVATE	= "prop_beast_activate"			--激活神兽道具


ATTR_TYPE_NUM	= 12		--属性type个数
--1-武力,2-灵力,3-敏捷,4-气血,5-防御,6-命中,7-闪避,8-暴击,9-抗暴,10-会心,11-无序,12-金刚
TYPE_FORCE = 1
TYPE_SPIRIT = 2
TYPE_AGILITY = 3
TYPE_BLOOD = 4
TYPE_DEFENSE = 5
TYPE_HIT = 6
TYPE_DODGE = 7
TYPE_CRIT = 8
TYPE_UPRISING = 9
TYPE_KNOWING = 10
TYPE_RANDOM	= 11
TYPE_KONGKING	= 12



TYPE_FORMATION_FRONT	= 1		--阵首
TYPE_FORMATION_MIDDLE	= 2		--阵中
TYPE_FORMATION_TAIL	= 3		--阵尾

TYPE_FORMATION_ADD_BY_POST	= 1	--发布仙贴

--新手引导服务器记录type
TYPE_GUIDE_FIRST_RECRUIT	= 0
TYPE_GUIDE_CAMPAIGN_1	= 1
TYPE_GUIDE_CAMPAIGN_2	= 2
TYPE_GUIDE_CAMPAIGN_3	= 3
TYPE_GUIDE_CAMPAIGN_4	= 4



--法宝类型,1-武攻,2-灵击,3-敏杀,4-护身
SKILL_TYPE_WUGONG	= 1
SKILL_TYPE_LINGJI	= 2
SKILL_TYPE_MINSHA	= 3
SKILL_TYPE_HUSHEN	= 4

--法宝攻击范围,0-单体,1-全体,2-横扫,3-贯穿,4-溅射,5-三人,6-五人,7-三次,8-五次
SKILL_FIRE_TYPE_DT	= 0
SKILL_FIRE_TYPE_QT	= 1
SKILL_FIRE_TYPE_HS	= 2
SKILL_FIRE_TYPE_GC	= 3
SKILL_FIRE_TYPE_JS	= 4
SKILL_FIRE_TYPE_SR	= 5
SKILL_FIRE_TYPE_WR	= 6
SKILL_FIRE_TYPE_SC	= 7
SKILL_FIRE_TYPE_WC	= 8


--物品类型:0-掉落,1-装备,2-法宝,3-灵珠,4-阵法,5-碎片,9-道具,10-魂魄,11-宝箱,12-银币,13-金币（仙晶）15-精魂
--        16-行动点数  17-元神点数  18-声望  19-魔晶
TYPE_DROP	= 0
TYPE_EQUIPMENT	= 1
TYPE_SKILL	= 2
TYPE_MAGICBALL	= 3
TYPE_FORMATION	= 4
TYPE_FRAGMENT	= 5
TYPE_PROP	= 9
TYPE_SOUL	= 10
TYPE_BOX	= 11
TYPE_MONEY	= 12
TYPE_GOLD	= 13
TYPE_JINGHUN = 15
TYPE_XINGDONG = 16
TYPE_YUANSHEN = 17
TYPE_SHENWANG = 18
TYPE_MOJING = 19


-- #define	GET_MIN_VAL(a, b)		((a) < (b) ? (a) : (b))		--取最小值
-- #define	GET_MAX_VAL(a, b)		((a) > (b) ? (a) : (b))		--取最大值
--
-- #define	GET_LEVEL_VAL(__init, __stronger, __level)	((__init) + (__stronger) * (__level > 0 ? __level - 1 : 0))	--计算当前等级数据

--增减碎片数量的方式：1代表通过掠夺方式；0代表非掠夺方式
DO_FRAG_PLUNDER	= 1
DO_FRAG_NOT_PLUNDER	= 0


--每日任务
DAY_DO_ANY_COPY_BATTLE	= "ED0001"	--闯荡任意副本一次
DAY_PLUNDER_SUCCESS	= "ED0002"	--掠夺成功一次
DAY_EAT_REN_SHENG_GUO	= "ED0003"	--吃人参果两次
DAY_RECRUIT_GOD	= "ED0004"	--招募任意神仙5个
DAY_WORSHIP_NV_WA	= "ED0005"	-- 祭拜女娲一次
DAY_DO_DOUFA_BATTLE	= "ED0006"	-- 进行一次斗法
DAY_DO_PRACTICE	= "ED0007"	-- 进行一次修炼
DAY_DO_FOREVER_TOWER	= "ED0008"	-- 挑战一次无尽之塔
DAY_ANNOUNCE_GOD_POST	= "ED0009"	-- 发布一次仙贴
DAY_DO_PRAY	= "ED0010"	-- 进行一次祈福
DAY_VIP_GIFT_BAG	= "ED0013"	--泛指礼包id
DAY_DO_BEAST_UP	= "ED0026"	--神兽喂养5次
DAY_DO_BEAST_PRA	= "ED0027"	--神兽双修一次
DAY_DO_DOUFA_BATTLE_6	= "ED0028"	-- 进行六次斗法
DAY_DO_DOUFA_BATTLE_9	= "ED0029"	-- 进行九次斗法


--成就
CJ_PLAYER_LEVELUP	= 11		--玩家升级
CJ_CAMPAIGN_EASY	= 12		--通关普通副本
CJ_CAMPAIGN_NORMAL	= 13		--通关高手副本
CJ_CAMPAIGN_HARD	= 14		--通关宗师副本
CJ_GAIN_CHA_JIA	= 15		--获得甲级神仙
CJ_GAIN_EP_JIA	= 16		--获得甲级装备
CJ_GAIN_SKILL_JIA	= 17		--获得甲级法宝
CJ_GAIN_FOR_JIA	= 18		--获得甲级阵法
CJ_EP_UPGRADE	= 19		--升级装备
CJ_SKILL_UPGRADE	= 20		--升级法宝
CJ_STAR_UPGRADE	= 21		--升级星宿
CJ_FOR_UPGRADE	= 22		--升级阵法
CJ_EP_RECAST_5L	= 23		--重铸装备到绝品
CJ_EP_RECAST_1L	= 24		--重铸装备到凡品
CJ_STAR_REFRESH	= 25		--移星换斗
CJ_BAT_FRA	= 26		--成功掠夺碎片
CJ_ADD_FRIEND	= 27		--添加好友
CJ_BAT_ENEMY	= 28		--好友切磋
CJ_BAT_FRIEND	= 29		--成功复仇
CJ_ALL_EP_JIA	= 30		--上阵神仙全部穿戴甲级装备
CJ_ALL_EP_YI	= 31		--上阵神仙全部穿戴乙级装备
CJ_ENTER_GAME	= 32		--每日登录游戏
CJ_HAVE_MONEY	= 33		--拥有银两
CJ_ON_FORMATION	= 34		--上阵神仙
CJ_CHA_RELATION	= 35		--神仙缘分


--活动ID
DEF_ACT_WJZT = "ACT007"  --无尽之塔
DEF_ACT_JLZ = "ACT008"  --聚灵阵
DEF_ACT_THDS = "ACT014"  --土豪诞生
