local errorcode = {
    OK = 0,
    INTERNAL_ERROR = 1,
    ARGUMENTS_ERROR = 2,
    USER_NAME_EMPTY = 100,
    USER_NAME_LENGTH_ERROR = 101,
    PASSWORD_EMPTY = 102,
    PASSWORD_LENGTH_ERROR = 103,
    USER_NAME_ILLEGAL = 104,
    PASSWORD_ILLEGAL = 105,
    USER_ALREADY_EXISTS = 106,
    USER_DOES_NOT_EXISTS = 107,
    USER_PASSWORD_WRONG = 108,
}

function errorcode.getError(self, errno)
    for k, v in pairs(self) do
        if (type(v) ~= "function" and v == errno) then
            return k
        end
    end

    return "Unknow"
end

return errorcode
