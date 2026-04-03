local DatabaseCharts = {
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
    }
}

function DatabaseCharts.FetchChartDifficulty(input_songTitle, input_chartName)

    local song = DatabaseCharts.Songs[input_songTitle]
    if not song then return "XXXX" end

    local chart = song.Charts[input_chartName]
    if not chart then return "XXXX" end

    return chart.DifficultyName or "XXXX"

end

function DatabaseCharts.FetchChartColor(input_songTitle, input_chartName)

    local song = DatabaseCharts.Songs[input_songTitle]
    if not song then return "black" end

    local chart = song.Charts[input_chartName]
    if not chart then return "black" end

    if chart.DifficultyName:match("^ S") then return "orange"
    elseif chart.DifficultyName:match("^HD") then return "blue"
    elseif chart.DifficultyName:match("^ D") then return "forestGreen"
    else return "black" end

end

return DatabaseCharts