--[[

Copyright (c) 2011-2012 qeeplay.com

http://dualface.github.com/quick-cocos2d-x/

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

]]

--[[
if CCLuaLog then
    io.output():setvbuf('no')
elseif ngx and ngx.log then
    print = function(...)
        local arg = {...}
        for k,v in pairs(arg) do
            arg[k] = tostring(v)
        end
        ngx.log(ngx.ERR, table.concat(arg, "\t"))
    end
end
]]

--local Debug = {}

echo = print

function printf(fmt, ...)
    echo(string.format(tostring(fmt), ...))
end

function echoError(fmt, ...)
    echoLog("ERR", fmt, ...)
    print(debug.traceback("", 2))
end

function echoInfo(fmt, ...)
    echoLog("INFO", fmt, ...)
end

function echoLog(tag, fmt, ...)
    echo(string.format("[%s] %s", string.upper(tostring(tag)), string.format(tostring(fmt), ...)))
end

function throw(errorType, fmt, ...)
    local arg = {...}
    for k,v in pairs(arg) do
        arg[k] = tostring(v)
    end
    local msg = string.format(tostring(fmt), unpack(arg))
    error(string.format("<<%s>> - %s", tostring(errorType), msg), 2)
end

function dump(object, label, isReturnContents, nesting)
    if type(nesting) ~= "number" then nesting = 99 end

    local lookupTable = {}
    local result = {}

    local function _v(v)
        if type(v) == "string" then
            v = "\"" .. v .. "\""
        end
        return tostring(v)
    end

    local traceback = string.split(debug.traceback("", 2), "\n")
    echo("dump from: " .. string.trim(traceback[3]))

    local function _dump(object, label, indent, nest, keylen)
        label = label or "<var>"
        spc = ""
        if type(keylen) == "number" then
            spc = string.rep(" ", keylen - string.len(_v(label)))
        end
        if type(object) ~= "table" then
            result[#result +1 ] = string.format("%s%s%s = %s", indent, _v(label), spc, _v(object))
        elseif lookupTable[object] then
            result[#result +1 ] = string.format("%s%s%s = *REF*", indent, label, spc)
        else
            lookupTable[object] = true
            if nest > nesting then
                result[#result +1 ] = string.format("%s%s = *MAX NESTING*", indent, label)
            else
                result[#result +1 ] = string.format("%s%s = {", indent, _v(label))
                local indent2 = indent.."    "
                local keys = {}
                local keylen = 0
                local values = {}
                for k, v in pairs(object) do
                    keys[#keys + 1] = k
                    local vk = _v(k)
                    local vkl = string.len(vk)
                    if vkl > keylen then keylen = vkl end
                    values[k] = v
                end
                table.sort(keys, function(a, b)
                    if type(a) == "number" and type(b) == "number" then
                        return a < b
                    else
                        return tostring(a) < tostring(b)
                    end
                end)
                for i, k in ipairs(keys) do
                    _dump(values[k], k, indent2, nest + 1, keylen)
                end
                result[#result +1] = string.format("%s}", indent)
            end
        end
    end
    _dump(object, label, "- ", 1)

    if isReturnContents then
        return table.concat(result, "\n")
    end

    for i, line in ipairs(result) do
        echo(line)
    end
end

function vardump(object, label)
    local lookupTable = {}
    local result = {}

    local function _v(v)
        if type(v) == "string" then
            v = "\"" .. v .. "\""
        end
        return tostring(v)
    end

    local function _vardump(object, label, indent, nest)
        label = label or "<var>"
        local postfix = ""
        if nest > 1 then postfix = "," end
        if type(object) ~= "table" then
            if type(label) == "string" then
                result[#result +1] = string.format("%s%s = %s%s", indent, label, _v(object), postfix)
            else
                result[#result +1] = string.format("%s%s%s", indent, _v(object), postfix)
            end
        elseif not lookupTable[object] then
            lookupTable[object] = true

            if type(label) == "string" then
                result[#result +1 ] = string.format("%s%s = {", indent, label)
            else
                result[#result +1 ] = string.format("%s{", indent)
            end
            local indent2 = indent .. "    "
            local keys = {}
            local values = {}
            for k, v in pairs(object) do
                keys[#keys + 1] = k
                values[k] = v
            end
            table.sort(keys, function(a, b)
                if type(a) == "number" and type(b) == "number" then
                    return a < b
                else
                    return tostring(a) < tostring(b)
                end
            end)
            for i, k in ipairs(keys) do
                _vardump(values[k], k, indent2, nest + 1)
            end
            result[#result +1] = string.format("%s}%s", indent, postfix)
        end
    end
    _vardump(object, label, "", 1)

    return table.concat(result, "\n")
end

function printDisassembleHeader(name, title)
    print ("==================================")
    if (title) then
        print (name..": "..title)
    else
        print (name)
    end
    print ("----------------------------------")
end

function printDisassembleFooter(name, title)

    print ("----------------------------------")
    if (title) then
        print (name..": "..title.." End!")
    else
        print (name.." End!")
    end
    print ("==================================")
    print ("")
    print ("")
end

function disassemble(obj, title)
--[[
    if (Debug) then
        return
    end
]]
    printDisassembleHeader("Disassemble", title)

    local pairsObj = nil
    local o = {}
    local maxLength = 0
    local istable = false
    local cannotSort = false
    if (type(obj) == "table") then
        --table.sort(obj)
        --istable = true
        for k, v in pairs(obj) do
            o[#o + 1] = { key = k, value = v }
            if (type(k) == "userdata") then
                cannotSort = true
            else
                maxLength = math.max(string.len(k), maxLength)
            end
            --echoInfo("disassemble: key = %s, v = %s", k, v)
        end
    else
        local tbl = getmetatable(obj)
        for k, v in pairs(tbl) do
            o[#o + 1] = { key = k, value = v }
            if (type(k) == "userdata") then
                cannotSort = true
            else
                maxLength = math.max(string.len(k), maxLength)
            end
            --print("disassemble: key =", k, ", v =", v)
        end
    end

    if (cannotSort == false) then
        table.sort(o,
                   function(a, b)
                   return a.key < b.key
                   end);
    end

    for i = 1, #o do
        echoInfo("disassemble: key = %-"..maxLength.."s value = %s", o[i].key, o[i].value)
        if (istable) then
            disassemble(o[i].value, string.format("1 of %s", title))
        end
    end

    printDisassembleFooter("Disassemble", title)
end

function diffAssemble(obj1, obj2, title)
    printDisassembleHeader("Diff Assemble", title)

    local pairsObj1 = nil
    local pairsObj2 = nil

    if (type(obj1) == "table") then
        pairsObj1 = pairs(obj1)
    else
        pairsObj1 = pairs(getmetatable(obj1))
    end

    if (type(obj2) == "table") then
        pairsObj2 = pairs(obj2)
        else
        pairsObj2 = pairs(getmetatable(obj2))
    end

    local diff = {}

    for k, v in pairsObj1 do
        if (pairsObj2[k] == nil) then
            diff[#diff + 1] = { target = obj1, key = k }
        end
    end

    for k, v in pairsObj2 do
        if (pairsObj1[k] == nil) then
            diff[#diff + 1] = { target = obj2, key = k }
        end
    end

    for i = 1, #diff do
        local tar = "obj1"
        if diff[i].target == obj2 then tar = "obj2" end
        echoInfo("%s[%s].%s", tar, diff[i].target, diff[i].key)
    end

    printDisassembleFooter("Diff Assemble", title)
end

function printHex(str)
    local index = 1
    local buffer = ""
    for index = 1, string.len(str) do
        buffer = buffer..string.format("%02x ", string.byte(str, index))
    end
    print (buffer)
end
