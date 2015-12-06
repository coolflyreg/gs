local errorcode = {
    OK = 0,
    INTERNAL_ERROR = 1,
    USER_NAME_EMPTY = 2,
    USER_NAME_LENGTH_ERROR = 3,
    PASSWORD_EMPTY = 4,
    PASSWORD_LENGTH_ERROR = 5,
    USER_NAME_ILLEGAL = 6,
    PASSWORD_ILLEGAL = 7,
    USER_ALREADY_EXISTS = 8,
    USER_DOES_NOT_EXISTS = 9,
    USER_PASSWORD_WRONG = 10,
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
