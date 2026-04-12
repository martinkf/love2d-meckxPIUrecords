local State_07AddingNewRecord = {}

-- LOCAL VARIABLES
local perfectsM = 0
local perfectsC = 3
local perfectsD = 0
local perfectsU = 0
local greatsM = 0
local greatsC = 0
local greatsD = 0
local greatsU = 0
local goodsM = 0
local goodsC = 0
local goodsD = 0
local goodsU = 0
local badsM = 0
local badsC = 0
local badsD = 0
local badsU = 0
local missesM = 0
local missesC = 0
local missesD = 0
local missesU = 0
local correctPerfects = 300
local correctGreats = 0
local correctGoods = 0
local correctBads = 0
local correctMisses = 0
local totalSteps = 300
local accuracy = 1
local stars = 5
local comment = "PG!"
local recordColor = "white"
local selectorIndex = 1

-- LOCAL FUNCTIONS
function State_07AddingNewRecord.UpdateCorrectSteps()
	correctPerfects = (perfectsM * 1000) + (perfectsC * 100) + (perfectsD * 10) + perfectsU
	correctGreats = (greatsM * 1000) + (greatsC * 100) + (greatsD * 10) + greatsU
	correctGoods = (goodsM * 1000) + (goodsC * 100) + (goodsD * 10) + goodsU
	correctBads = (badsM * 1000) + (badsC * 100) + (badsD * 10) + badsU
	correctMisses = (missesM * 1000) + (missesC * 100) + (missesD * 10) + missesU
	totalSteps = correctPerfects + correctGreats + correctGoods + correctBads + correctMisses
end

function State_07AddingNewRecord.UpdateAccuracy()

	State_07AddingNewRecord.UpdateCorrectSteps()
	accuracy = ((correctPerfects/totalSteps)*1) + ((correctGreats/totalSteps)*0.8) + ((correctGoods/totalSteps)*0.5) + ((correctBads/totalSteps)*0.2)

end

function State_07AddingNewRecord.UpdateStars()

	State_07AddingNewRecord.UpdateAccuracy()
	if accuracy == 1 then
		stars = 5
		recordColor = "meckx_02Blue_light"
	elseif (correctMisses+correctBads+correctGoods) == 0 then
		stars = 4
		recordColor = "meckx_03Green_light"
	elseif (correctMisses+correctBads) == 0 then
		stars = 3
		recordColor = "meckx_04Yellow_light"
	elseif correctMisses == 0 then
		stars = 2
		recordColor = "meckx_01Pink_light"
	else
		stars = 1
		recordColor = "meckx_06Red_light"
	end

end

function State_07AddingNewRecord.UpdateComment()

	State_07AddingNewRecord.UpdateStars()
	if stars == 5 then comment = "PG!" end
	if correctGreats > 0 then comment = correctGreats .. " GREATS" end
	if correctGoods > 0 then comment = comment .. ", " .. correctGoods .. " GOODS" end
	if correctBads > 0 then comment = comment .. ", " .. correctBads .. " BADS" end
	if correctMisses > 0 then comment = comment .. ", " .. correctMisses .. " MISSES" end

end

function TestSaveDummyScore()

    MemorycardData = MemorycardData or {}
    MemorycardData.Players = MemorycardData.Players or {}
    MemorycardData.Players[Game.selectedPlayerName] = MemorycardData.Players[Game.selectedPlayerName] or {}
    MemorycardData.Players[Game.selectedPlayerName].Scores = MemorycardData.Players[Game.selectedPlayerName].Scores or {}

    local newEntry = {
        SongTitle = Game.selectedSongName,
        ChartName = Game.selectedChartName,
        Date = os.date("%d/%m/%Y"),
		Time = os.date("%H:%M:%S"),
        Perfects = 190,
        Greats = 2,
        Goods = 1,
        Bads = 0,
        Misses = 0,
        Accuracy = 0.995,
        Stars = 3,
        Comment = "1 GOOD"
    }

    table.insert(MemorycardData.Players[Game.selectedPlayerName].Scores, newEntry)

    SaveToMemorycard()

end

-- INPUT HANDLING

function State_07AddingNewRecord.UpPressed()

	if selectorIndex == 21 then selectorIndex = 17
	elseif selectorIndex == 17 then selectorIndex = 13
	elseif selectorIndex == 13 then selectorIndex = 9
	elseif selectorIndex == 9 then selectorIndex = 5
	elseif selectorIndex == 5 then selectorIndex = 1
	end
	State_07AddingNewRecord.UpdateComment()

end

function State_07AddingNewRecord.DownPressed()

	if selectorIndex == 1 then selectorIndex = 5
	elseif selectorIndex == 5 then selectorIndex = 9
	elseif selectorIndex == 9 then selectorIndex = 13
	elseif selectorIndex == 13 then selectorIndex = 17
	elseif selectorIndex == 17 then selectorIndex = 21
	end
	State_07AddingNewRecord.UpdateComment()

end

function State_07AddingNewRecord.LeftPressed()

	if selectorIndex == 2 then selectorIndex = 1
	elseif selectorIndex == 6 then selectorIndex = 5
	elseif selectorIndex == 10 then selectorIndex = 9
	elseif selectorIndex == 14 then selectorIndex = 13
	elseif selectorIndex == 18 then selectorIndex = 17
	end
	State_07AddingNewRecord.UpdateComment()

end

function State_07AddingNewRecord.RightPressed()

	if selectorIndex == 1 then selectorIndex = 2
	elseif selectorIndex == 5 then selectorIndex = 6
	elseif selectorIndex == 9 then selectorIndex = 10
	elseif selectorIndex == 13 then selectorIndex = 14
	elseif selectorIndex == 17 then selectorIndex = 18
	end
	State_07AddingNewRecord.UpdateComment()

end

function State_07AddingNewRecord.CenterPressed()



end

function State_07AddingNewRecord.BackPressed()



end











































-- DRAWING

function State_07AddingNewRecord.Drawing()
	local drawingX = 6
	local drawingY = Game.baseDrawingY
	local linebreakSize = 42

	State_07AddingNewRecord.UpdateComment()

	-- background
	meckx_clearScreen({
		ColorName = "darkestGray",
	})
	meckx_rect({
		XPos = 0,
		YPos = 0,
		Width = 1280,
		Height = 44,
		ColorName = "red",
		RectStyle = "fill",
		Transparency = 1,
	})

	-- contents
	meckx_print({
		Text = "../"..Game.selectedSongName.."/"..Game.selectedChartName.."/ADDING NEW RECORD",
		XPos = drawingX+24,
		YPos = drawingY-2,
		ColorName = "yellow",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "--------------- 07. ADD RECORD DETAILS --------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	--drawing the selector
	local selectorX = 0
	local selectorY = 0

	if selectorIndex == 1 or selectorIndex == 5 or selectorIndex == 9 or selectorIndex == 13 or selectorIndex == 17 then selectorX = drawingX+23
	elseif selectorIndex == 2 or selectorIndex == 6 or selectorIndex == 10 or selectorIndex == 14 or selectorIndex == 18 then selectorX = drawingX+23+(1*24)
	elseif selectorIndex == 21 then selectorX = -200
	end

	if selectorIndex == 1 or selectorIndex == 2 then selectorY = 89
	elseif selectorIndex == 5 or selectorIndex == 6 then selectorY = 131
	elseif selectorIndex == 9 or selectorIndex == 10 then selectorY = 173
	elseif selectorIndex == 13 or selectorIndex == 14 then selectorY = 215
	elseif selectorIndex == 17 or selectorIndex == 18 then selectorY = 257
	elseif selectorIndex == 21 then selectorY = -200
	end

	meckx_rect({
		XPos = selectorX,
		YPos = selectorY,
		Width = 23,
		Height = 32,
		ColorName = "white",
		RectStyle = "fill",
		Transparency = 1,
	})

	--drawing the numbers
	meckx_print({
		Text = perfectsM,
		XPos = drawingX+(1*24),
		YPos = drawingY,
		ColorName = (selectorIndex == 1) and "black" or "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = perfectsC,
		XPos = drawingX+(2*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = perfectsD,
		XPos = drawingX+(3*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = perfectsU,
		XPos = drawingX+(4*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = "PERFECTs",
		XPos = drawingX+(6*24),
		YPos = drawingY,
		ColorName = "meckx_02Blue_light",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = greatsM,
		XPos = drawingX+(1*24),
		YPos = drawingY,
		ColorName = (selectorIndex == 5) and "black" or "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = greatsC,
		XPos = drawingX+(2*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = greatsD,
		XPos = drawingX+(3*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = greatsU,
		XPos = drawingX+(4*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = "GREATs",
		XPos = drawingX+(6*24),
		YPos = drawingY,
		ColorName = "meckx_03Green_light",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = goodsM,
		XPos = drawingX+(1*24),
		YPos = drawingY,
		ColorName = (selectorIndex == 9) and "black" or "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = goodsC,
		XPos = drawingX+(2*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = goodsD,
		XPos = drawingX+(3*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = goodsU,
		XPos = drawingX+(4*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = "GOODs",
		XPos = drawingX+(6*24),
		YPos = drawingY,
		ColorName = "meckx_04Yellow_light",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = badsM,
		XPos = drawingX+(1*24),
		YPos = drawingY,
		ColorName = (selectorIndex == 13) and "black" or "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = badsC,
		XPos = drawingX+(2*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = badsD,
		XPos = drawingX+(3*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = badsU,
		XPos = drawingX+(4*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = "BADs",
		XPos = drawingX+(6*24),
		YPos = drawingY,
		ColorName = "meckx_01Pink_light",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = missesM,
		XPos = drawingX+(1*24),
		YPos = drawingY,
		ColorName = (selectorIndex == 17) and "black" or "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = missesC,
		XPos = drawingX+(2*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = missesD,
		XPos = drawingX+(3*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = missesU,
		XPos = drawingX+(4*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = "MISSes",
		XPos = drawingX+(6*24),
		YPos = drawingY,
		ColorName = "meckx_06Red_light",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "ACCURACY:",
		XPos = drawingX+(6*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	local displaytext = accuracy*100 .. "%"
	meckx_print({
		Text = displaytext,
		XPos = drawingX+(16*24),
		YPos = drawingY,
		ColorName = recordColor,
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "STARS:",
		XPos = drawingX+(6*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	local starsAsString
	if stars == 5 then starsAsString = "*****"
	elseif stars == 5 then starsAsString = "****"
	elseif stars == 5 then starsAsString = "***"
	elseif stars == 5 then starsAsString = "**"
	else starsAsString = "*" end
	meckx_print({
		Text = starsAsString,
		XPos = drawingX+(16*24),
		YPos = drawingY,
		ColorName = recordColor,
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "COMMENT:",
		XPos = drawingX+(6*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = comment,
		XPos = drawingX+(16*24),
		YPos = drawingY,
		ColorName = recordColor,
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + (2 * linebreakSize)

	meckx_print({
		Text = (selectorIndex == 21) and "> Confirm adding new record..." or "Confirm adding new record...",
		XPos = (selectorIndex == 21) and drawingX or drawingX+24,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
end











































return State_07AddingNewRecord