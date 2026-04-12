local SaveLoadLibrary = {}

local json = require("json")

local function GetDefaultMemorycard()
    return {
        Players = {
            ["1. MartinTest"] = { Scores = {} },
            ["2. Handpad"]    = { Scores = {} },
            ["3. PIU pad"]    = { Scores = {} },
        }
    }
end

function LoadFromMemorycard()
    local data = love.filesystem.read("memorycard.json")

    if not data then
        return GetDefaultMemorycard()
    end

    local decoded = json.decode(data)

    if not decoded then
        return GetDefaultMemorycard()
    end

    if not decoded.Players then
        return GetDefaultMemorycard()
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
        if #completeArray == 1 then return completeArray[1] -- if only 1 score for this player+song+chart
        else
            -- if 2 or more scores for this player+song+chart, then we actually need to think a little
            -- pending lol
            return completeArray[1]
        end
    else
        return -- if no scores at all for this player+song+chart
    end

end

function FetchHighScoreColor(input_playerName, input_songTitle, input_chartName)

    local highScoreObject = FetchHighScore(input_playerName, input_songTitle, input_chartName)

    if highScoreObject then
        if highScoreObject.Stars == 5 then return "meckx_02Blue_light"
        elseif highScoreObject.Stars == 4 then return "meckx_03Green_light"
        elseif highScoreObject.Stars == 3 then return "meckx_04Yellow_light"
        elseif highScoreObject.Stars == 2 then return "meckx_01Pink_light"
        else return "meckx_06Red_light"
        end
    else
        return "lightGray"
    end

end
































return SaveLoadLibrary