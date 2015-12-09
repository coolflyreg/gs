local skynet = require("skynet")
local log = require("syslog")
local mysql = require("mysql")
local pool = require "pool"

-----------------------------------------------------

local _dbPools = {}

-----------------------------------------------------

local CMD = {}

function CMD.init(name, config, poolsize)
    if (_dbPools[name]) then
        log.warningf("DB %s Connection is existing.", name)
        return
    end

    local function poolDB_oncreate()
        config.on_connect = function(db)
            db:query("set charset utf8")
            log.info("DB "..name.." is Connected!")
        end
        local database = mysql.connect(config)
        if not database then
            log.err("DB "..name.." connect failed.")
            return nil
        else
            return database
        end
    end

    local poolConfig = {
        init_count = poolsize,
        on_create = poolDB_oncreate
    }

    local dbpool = pool.create(poolConfig)

    _dbPools[name] = dbpool

    return true
end
require("framework")
function CMD.query(name, sql)
    local dbpool = _dbPools[name]
    if (not pool) then
        error(string.format("There is no database for \"%s\"", name))
        return
    end

    local db = dbpool:new()

    local res = db:query(sql) -- TODO to catch the error for analyze

    dbpool:destroy(db)

    return res
end

skynet.start(function()
    skynet.dispatch("lua", function(_, _, command, ...)
        local f = assert(CMD[command])
        skynet.ret(skynet.pack(f(...)))
    end)
end)
