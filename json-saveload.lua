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

function FetchArrayOfRecords(input_playerName, input_songTitle, input_chartName)
    local results = {}

    local player = MemorycardData.Players[input_playerName]
    if not player or not player.Scores then
        return results
    end

    for _, thisResult in ipairs(player.Scores) do
        if thisResult.SongTitle == input_songTitle and thisResult.ChartName == input_chartName then
            results[#results + 1] = thisResult
        end
    end

    return results
end

function FetchHighScore(input_playerName, input_songTitle, input_chartName)

    local completeArray = FetchArrayOfRecords(input_playerName, input_songTitle, input_chartName)

    if #completeArray > 0 then
        return completeArray[1]
    else
        return
    end

end
































return SaveLoadLibrary