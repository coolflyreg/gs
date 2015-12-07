local skynet = require("skynet")
local log = require "syslog"
local mysql = require "mysql"

databases = databases or {
    dbs = {},
    init = function(self, name, config)

        if (self.dbs[name]) then
            log.warningf("DB %s Connection is existing.", name)
            return
        end

        config.on_connect = function(db)
            db:query("set charset utf8")
            log.info("DB "..name.." is Connected!")
        end
        local database = mysql.connect(config)
        if not database then
            log.err("DB "..name.." connect failed.")
        else
            self.dbs[name] = database
        end
    end,

    get = function(self, name)
        if (self.dbs[name]) then
            return assert(self.dbs[name])
        end

        return nil
    end
}

return databases
