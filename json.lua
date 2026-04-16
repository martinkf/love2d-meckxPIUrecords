local json = {}

function json.encode(value, indent)
    indent = indent or 0
    local spacing = string.rep("  ", indent)
    local t = type(value)

    if t == "table" then
        -- detect array
        local isArray = true
        local count = 0

        for k, _ in pairs(value) do
            count = count + 1
            if type(k) ~= "number" then
                isArray = false
                break
            end
        end

        if isArray then
            -- ensure it's 1..n
            for i = 1, count do
                if value[i] == nil then
                    isArray = false
                    break
                end
            end
        end

        local result = {}

        if isArray then
            -- ARRAY MODE
            table.insert(result, "[\n")

            for i = 1, count do
                if i > 1 then table.insert(result, ",\n") end

                local val = json.encode(value[i], indent + 1)
                table.insert(result,
                    string.rep("  ", indent + 1) .. val
                )
            end

            table.insert(result, "\n" .. spacing .. "]")

        else
            -- OBJECT MODE
            table.insert(result, "{\n")

            local first = true
            for k, v in pairs(value) do
                if not first then table.insert(result, ",\n") end
                first = false

                local key = '"' .. tostring(k) .. '"'
                local val = json.encode(v, indent + 1)

                table.insert(result,
                    string.rep("  ", indent + 1) .. key .. ": " .. val
                )
            end

            table.insert(result, "\n" .. spacing .. "}")
        end

        return table.concat(result)

    elseif t == "string" then
        local s = value
        s = s:gsub("\\", "\\\\")
        s = s:gsub('"', '\\"')
        return '"' .. s .. '"'

    elseif t == "number" or t == "boolean" then
        return tostring(value)

    elseif t == "nil" then
        return "null"

    else
        return "null"
    end
end

function json.decode(str)
    local pos = 1

    local function skip()
        while str:sub(pos,pos):match("%s") do
            pos = pos + 1
        end
    end

    local function parseString()
        pos = pos + 1 -- skip opening "
        local result = ""

        while pos <= #str do
            local c = str:sub(pos,pos)

            if c == '"' then
                pos = pos + 1
                return result
            elseif c == "\\" then
                local nextChar = str:sub(pos+1,pos+1)
                result = result .. nextChar
                pos = pos + 2
            else
                result = result .. c
                pos = pos + 1
            end
        end
    end

    local function parseNumber()
        local start = pos
        while str:sub(pos,pos):match("[%d%.%-]") do
            pos = pos + 1
        end
        return tonumber(str:sub(start, pos-1))
    end

    local parseValue

    local function parseArray()
        pos = pos + 1 -- skip [
        local result = {}

        skip()

        if str:sub(pos,pos) == "]" then
            pos = pos + 1
            return result
        end

        while true do
            table.insert(result, parseValue())
            skip()

            local c = str:sub(pos,pos)
            if c == "]" then
                pos = pos + 1
                break
            elseif c == "," then
                pos = pos + 1
            end
        end

        return result
    end

    local function parseObject()
        pos = pos + 1 -- skip {
        local result = {}

        skip()

        if str:sub(pos,pos) == "}" then
            pos = pos + 1
            return result
        end

        while true do
            skip()
            local key = parseString()

            skip()
            pos = pos + 1 -- skip :

            local value = parseValue()
            result[key] = value

            skip()
            local c = str:sub(pos,pos)

            if c == "}" then
                pos = pos + 1
                break
            elseif c == "," then
                pos = pos + 1
            end
        end

        return result
    end

    function parseValue()
        skip()
        local c = str:sub(pos,pos)

        if c == "{" then
            return parseObject()
        elseif c == "[" then
            return parseArray()
        elseif c == '"' then
            return parseString()
        elseif c:match("[%d%-]") then
            return parseNumber()
        elseif str:sub(pos,pos+3) == "true" then
            pos = pos + 4
            return true
        elseif str:sub(pos,pos+4) == "false" then
            pos = pos + 5
            return false
        elseif str:sub(pos,pos+3) == "null" then
            pos = pos + 4
            return nil
        end
    end

    local ok, result = pcall(parseValue)

    if not ok then
        return nil
    end

    -- enforce your structure
    result = result or {}
    result.Players = result.Players or {}

    for _, player in pairs(result.Players) do
        player.Scores = player.Scores or {}
    end

    return result
end

return json