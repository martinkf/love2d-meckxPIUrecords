local SaveLoadLibrary = {}

local json = require("json")

local function GetDefaultMemorycard()
    return {
        Players = {
            ["1. MartinTest"] = { Scores = {} },
            ["2. Hand PIU"] = { Scores = {} },
            ["3. PIU pad"] = { Scores = {} },
            ["4. DanceFit House"] = { Scores = {} },
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

    results = SortArrayOfRecordsByStarsThenAccuracy(results)

    return results
end

function SortArrayOfRecordsByStarsThenAccuracy(input_array)
    local output_array = {}

    -- this copies the input array into a new one, to preserve input_array the way it is (for some reason)
    for i, v in ipairs(input_array) do
        output_array[i] = v
    end

    -- sorts! thanks lua
    table.sort(output_array, function(a, b)
        if a.Stars ~= b.Stars then
            return a.Stars > b.Stars
        end
        return a.Accuracy > b.Accuracy
    end)

    return output_array
end

function FetchHighScore(input_playerName, input_songTitle, input_chartName)

    local completeArray = FetchArrayOfRecords(input_playerName, input_songTitle, input_chartName)
    completeArray = SortArrayOfRecordsByStarsThenAccuracy(completeArray)

    if #completeArray > 0 then
        return completeArray[1]
    else
        return -- if no scores at all for this player+song+chart
    end

end

function FetchScoreColorOfThisScore(input_scoreObject)
    if input_scoreObject.Stars == 5 then return "meckx_02Blue_light"
    elseif input_scoreObject.Stars == 4 then return "meckx_03Green_light"
    elseif input_scoreObject.Stars == 3 then return "meckx_04Yellow_light"
    elseif input_scoreObject.Stars == 2 then return "meckx_01Pink_light"
    else return "meckx_06Red_light"
    end
end

function FetchHighScoreColor(input_playerName, input_songTitle, input_chartName)

    local highScoreObject = FetchHighScore(input_playerName, input_songTitle, input_chartName)

    return FetchScoreColorOfThisScore(highScoreObject)

end

function FetchRecommendedSpeed(input_playerName, input_songTitle, input_chartName)

    local player = MemorycardData.Players[input_playerName]
    if not player or not player.RecommendedSpeeds then
        return "????"
    end

    for _, thisSongAndChart in ipairs(player.RecommendedSpeeds) do
        if thisSongAndChart.SongTitle == input_songTitle and thisSongAndChart.ChartName == input_chartName then
            return thisSongAndChart.RecommendedSpeed
        end
    end

    return "????"

end

function FetchRecommendedAV(input_playerName, input_songTitle, input_chartName)

    local player = MemorycardData.Players[input_playerName]
    if not player or not player.RecommendedSpeeds then
        return "?????"
    end

    for _, thisSongAndChart in ipairs(player.RecommendedSpeeds) do
        if thisSongAndChart.SongTitle == input_songTitle and thisSongAndChart.ChartName == input_chartName then
            return thisSongAndChart.RecommendedAV
        end
    end

    return "?????"

end
































return SaveLoadLibrary