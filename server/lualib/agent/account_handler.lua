local skynet = require("skynet")
local log = require "syslog"
local handler = require("agent.handler")
local errorcode = require("protocols.errorcode")
local validator = require("protocols.validator")
local databases = require("db.databases")
local json = require("cjson")
require "framework"

local REQUEST = {}
handler = handler.new(REQUEST)

function REQUEST.account_register(args)
    local username = args.username
    local password = args.password

    local result = validator.checkUserName(username)
    if (result ~= errorcode.OK) then return { errno = result } end
    result = validator.checkPassword(password)
    if (result ~= errorcode.OK) then return { errno = result } end

    local db = databases:get("account")

    local sql = string.format("SELECT Fid FROM zzb_account WHERE Fname='%s' ", username)
    local res = db:query(sql)

    if (res and not res.badresult and #res > 0) then
        return { errno = errorcode.USER_ALREADY_EXISTS }
    elseif res.badresult then
        log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %d", sql, res.err, res.errno, res.sqlstate)
        return { errno = errorcode.INTERNAL_ERROR }
    end

--[[
The right result after execute insert statement
- "<var>" = {
-     "affected_rows" = 1
-     "insert_id"     = 2312
-     "server_status" = 2
-     "warning_count" = 0
- }

IF sql execute error, will receive the data as follow
- "<var>" = {
-     "badresult" = true
-     "err"       = "Duplicate entry 'gxtest-0' for key 'np'"
-     "errno"     = 1062
-     "sqlstate"  = "23000"
- }

]]
    local insertsql = string.format("INSERT INTO zzb_account (Fname, Fpassword, Freg_time) VALUES ('%s', '%s', UNIX_TIMESTAMP()) ",
            username, password)
    local insertRes = db:query(insertsql)
    if not insertRes.badresult then
        local userId = insertRes.insert_id
    else
        log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %d", insertsql, insertRes.err, insertRes.errno, insertRes.sqlstate)
        return { errno = errorcode.INTERNAL_ERROR }
    end

    return { username = args.username }
end


function REQUEST.account_auth(args)
    local username = args.username
    local password = args.password

    local result = validator.checkUserName(username)
    if (result ~= errorcode.OK) then return { errno = result } end
    result = validator.checkPassword(password)
    if (result ~= errorcode.OK) then return { errno = result } end

    local db = databases:get("account")

    local sql = string.format("SELECT Fpassword FROM zzb_account WHERE Fname='%s'  ", username)
    local res = db:query(sql)

    if (res and not res.badresult and #res > 0) then
        if (res[1].Fpassword == password) then
            -- Success
        else
            return { errno = errorcode.USER_PASSWORD_WRONG }
        end
    elseif (res and not res.badresult and #res == 0) then
        return { errno = errnocode.USER_DOES_NOT_EXISTS }
    else
        log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %d", sql, res.err, res.errno, res.sqlstate)
        return { errno = errorcode.INTERNAL_ERROR }
    end

    local insertsql = string.format("INSERT INTO zzb_log_account_login (Fname, Fplatid, Flogin_time) VALUES ('%s', 0, UNIX_TIMESTAMP())", username)
    local insertRes = db:query(insertsql)
    if not insertRes.badresult then

    else
        log.errf("Execute SQL: %s, Reason: %s, errno: %d, sqlstate: %d", insertsql, insertRes.err, insertRes.errno, insertRes.sqlstate)
        -- return { errno = errorcode.INTERNAL_ERROR }
    end

    return { username = args.username }
end


function REQUEST.account_auth_platform(args)
    error("<Request.skill_upgrade> Not Implemented")
end


return handler
