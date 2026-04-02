local ChartDatabase = {
    Songs = {
        ["ANOTHER TRUTH | CORDIALITY"] = {
            Charts = {
                ["3RD-NORMAL"] = { DifficultyName = " S04" },
                ["3RD-HARD"] = { DifficultyName = " S06" },
                ["3RD-DOUBLE"] = { DifficultyName = " D07" },
            }
        },
        ["EXTRAVAGANZA"] = {
            Charts = {
                ["3RD-HARD"] = { DifficultyName = " S10" },
                ["3RD-CRAZY"] = { DifficultyName = " S12" },
                ["3RD-DOUBLE"] = { DifficultyName = " D13" },
            }
        },
        ["MR. LARPUS"] = {
            Charts = {
                ["OBGSE-NORMAL"] = { DifficultyName = " S05" },
                ["OBGSE-HARD"] = { DifficultyName = " S25" },
                ["OBGSE-CRAZY"] = { DifficultyName = " S26" },
            }
        },
    }
}

function ChartDatabase.FetchChartDifficulty(input_songTitle, input_chartName)

    local song = ChartDatabase.Songs[input_songTitle]
    if not song then return "XXXX" end

    local chart = song.Charts[input_chartName]
    if not chart then return "XXXX" end

    return chart.DifficultyName or "XXXX"

end

function ChartDatabase.FetchChartColor(input_songTitle, input_chartName)

    local song = ChartDatabase.Songs[input_songTitle]
    if not song then return "black" end

    local chart = song.Charts[input_chartName]
    if not chart then return "black" end

    if chart.DifficultyName:sub(2, 2) == "S" then
        -- if the second digit is a "S"
        return "orange"
    elseif chart.DifficultyName:sub(2, 2) == "D" then
        return "forestGreen"
    else return "black" end

end

return ChartDatabase