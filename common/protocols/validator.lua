local errorcode = require("protocols.errorcode")

validator = validator or {
    checkLegalCharacters = function(str, legalCharacters) -- return true for legal, false for illegal
        local i = 1
        local j = 1
        local byte_str = 0
        local byte_chars = 0
        local contains = false
        for i = 1, string.len(str) do
            byte_str = string.byte(str, i)
            contains = false
            for j = 1, string.len(legalCharacters) do
                byte_chars = string.byte(legalCharacters, j)
                if (byte_str == byte_chars) then
                    contains = true
                    break
                end
            end

            if (not contains) then
                return false
            end
        end
        return true
    end,

    checkUserName = function(username)
        if (not username or username == "") then
            return errorcode.USER_NAME_EMPTY
        end

        if (string.len(username) < 6 or string.len(username) > 20) then
            return errorcode.USER_NAME_LENGTH_ERROR
        end

        if (not validator.checkLegalCharacters(username, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_@")) then
            return errorcode.USER_NAME_ILLEGAL
        end

        return errorcode.OK
    end,

    checkPassword = function(password)
        if (not password or password == "") then
            return errorcode.PASSWORD_EMPTY
        end

        if (string.len(password) < 6 or string.len(password) > 20) then
            return errorcode.PASSWORD_LENGTH_ERROR
        end

        if (not validator.checkLegalCharacters(password, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_@!#$%^&*<>,.?;:")) then
            return errorcode.PASSWORD_ILLEGAL
        end

        return errorcode.OK
    end,
}

return validator
