local SaveLoadLibrary = {}

local json = require("json")

function LoadFromMemorycard()
    local data = love.filesystem.read("memorycard.json")

    if not data then
        return { Players = {} }
    end

    local decoded = json.decode(data)

    if not decoded then
        return { Players = {} }
    end

    if not decoded.Players then
        return { Players = {} }
    end

    return decoded
end

function SaveToMemorycard()
    local encoded = json.encode(MemorycardData)
    love.filesystem.write("memorycard.json", encoded)
end

































return SaveLoadLibrary