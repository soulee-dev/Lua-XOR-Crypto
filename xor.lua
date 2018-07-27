function encrypt(a, b)
    stringArray = stringtoBytes(a)

    for k, _ in pairs(stringArray) do
        stringArray[k] = bit.bxor(stringArray[k], b)
    end

    return util.Base64Encode(bytestoString(stringArray))
end

function decrypt(a, b)
    stringArray = stringtoBytes(util.Base64Decode(a))

    for k, _ in pairs(stringArray) do
        stringArray[k] = bit.bxor(stringArray[k], b)
    end

    return bytestoString(stringArray)
end

function stringtoBytes(a)
    stringArray = {}

    for i = 0, string.len(a) do
        stringArray[i] = string.byte(a, i)
    end

    return stringArray
end

function bytestoString(a)
    str = ""

    for k, _ in pairs(stringArray) do
        str = str .. string.char(stringArray[k])
    end

    return str
end

function util.Base64Decode(data)
    local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    if not data then return end
    data = string.gsub(data, "[^" .. b .. "=]", '')

    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r, f = '', (b:find(x) - 1)

        for i = 6, 1, -1 do
            r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and '1' or '0')
        end

        return r
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c = 0

        for i = 1, 8 do
            c = c + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0)
        end

        return string.char(c)
    end))
end