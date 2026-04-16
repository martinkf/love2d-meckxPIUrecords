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
local displayAccuracy = "100.00%"
local stars = 5
local displayStars = "*****"
local comment = "PERFECT GAME!"
local recordColor = "white"

-- SELECTOR
local selectorIndex = 1
local function getRowCol(index)
	local cols = 4
    local row = math.floor((index - 1) / cols)
    local col = (index - 1) % cols
    return row, col
end
local function getIndex(row, col)
	local cols = 4
    return row * cols + col + 1
end

-- GLOBAL FUNCTIONS
function ResetState07()
	perfectsM = 0
	perfectsC = 3
	perfectsD = 0
	perfectsU = 0
	greatsM = 0
	greatsC = 0
	greatsD = 0
	greatsU = 0
	goodsM = 0
	goodsC = 0
	goodsD = 0
	goodsU = 0
	badsM = 0
	badsC = 0
	badsD = 0
	badsU = 0
	missesM = 0
	missesC = 0
	missesD = 0
	missesU = 0
	correctPerfects = 300
	correctGreats = 0
	correctGoods = 0
	correctBads = 0
	correctMisses = 0
	totalSteps = 300
	accuracy = 1
	displayAccuracy = "100.00%"
	stars = 5
	comment = "PERFECT GAME!"
	recordColor = "white"

	selectorIndex = 1
end

-- LOCAL FUNCTIONS
local function UpdateCorrectSteps()
	correctPerfects = (perfectsM * 1000) + (perfectsC * 100) + (perfectsD * 10) + perfectsU
	correctGreats = (greatsM * 1000) + (greatsC * 100) + (greatsD * 10) + greatsU
	correctGoods = (goodsM * 1000) + (goodsC * 100) + (goodsD * 10) + goodsU
	correctBads = (badsM * 1000) + (badsC * 100) + (badsD * 10) + badsU
	correctMisses = (missesM * 1000) + (missesC * 100) + (missesD * 10) + missesU
	totalSteps = correctPerfects + correctGreats + correctGoods + correctBads + correctMisses
end

local function UpdateAccuracy()

	UpdateCorrectSteps()
	accuracy = ((correctPerfects/totalSteps)*1) + ((correctGreats/totalSteps)*0.8) + ((correctGoods/totalSteps)*0.5) + ((correctBads/totalSteps)*0.2)
	displayAccuracy = string.format("%.2f", accuracy*100) .. "%"

end

local function UpdateStars()

	UpdateAccuracy()
	if accuracy == 1 then
		stars = 5
		displayStars = "*****"
		recordColor = "meckx_02Blue_light"
	elseif (correctMisses+correctBads+correctGoods) == 0 then
		stars = 4
		displayStars = "****"
		recordColor = "meckx_03Green_light"
	elseif (correctMisses+correctBads) == 0 then
		stars = 3
		displayStars = "***"
		recordColor = "meckx_04Yellow_light"
	elseif correctMisses == 0 then
		stars = 2
		displayStars = "**"
		recordColor = "meckx_01Pink_light"
	else
		stars = 1
		displayStars = "*"
		recordColor = "meckx_06Red_light"
	end

end

local function UpdateComment()

	UpdateStars()
	if stars == 5 then comment = "PERFECT GAME!"
	elseif stars == 4 then comment = correctGreats .. " GREATS"
	elseif stars == 3 then
		comment = ""
		if correctGreats > 0 then comment = correctGreats .. " GREATS, " end
		comment = comment .. correctGoods .. " GOODS"
	elseif stars == 2 then
		comment = ""
		if correctGreats > 0 then comment = correctGreats .. " GREATS, " end
		if correctGoods > 0 then comment = comment .. correctGoods .. " GOODS, " end
		comment = comment .. correctBads .. " BADS"
	elseif stars == 1 then
		comment = ""
		if correctGreats > 0 then comment = correctGreats .. " GREATS, " end
		if correctGoods > 0 then comment = comment .. correctGoods .. " GOODS, " end
		if correctBads > 0 then comment = comment .. correctBads .. " BADS, " end
		comment = comment .. correctMisses .. " MISSES"
	end

end

local function SaveANewRecord()

	UpdateComment()

    MemorycardData = MemorycardData or {}
    MemorycardData.Players = MemorycardData.Players or {}
    MemorycardData.Players[Game.selectedPlayerName] = MemorycardData.Players[Game.selectedPlayerName] or {}
    MemorycardData.Players[Game.selectedPlayerName].Scores = MemorycardData.Players[Game.selectedPlayerName].Scores or {}

    local newEntry = {
        SongTitle = Game.selectedSongName,
        ChartName = Game.selectedChartName,
        Date = os.date("%d/%m/%Y"),
		Time = os.date("%H:%M:%S"),
        Perfects = correctPerfects,
        Greats = correctGreats,
        Goods = correctGoods,
        Bads = correctBads,
        Misses = correctMisses,
        Accuracy = accuracy,
		DisplayAccuracy = displayAccuracy,
        Stars = stars,
		DisplayStars = displayStars,
        Comment = comment
    }

    table.insert(MemorycardData.Players[Game.selectedPlayerName].Scores, newEntry)

    SaveToMemorycard()

end

-- INPUT HANDLING

function State_07AddingNewRecord.UpPressed()

	if selectorIndex == 22 then
        selectorIndex = 21
    elseif selectorIndex == 21 then
        selectorIndex = 17
    else
        local row, col = getRowCol(selectorIndex)

        if row > 0 then
            row = row - 1
            selectorIndex = getIndex(row, col)
        end
    end

    UpdateComment()
end

function State_07AddingNewRecord.DownPressed()

	if selectorIndex == 21 then
        selectorIndex = 22
    elseif selectorIndex >= 17 and selectorIndex <= 20 then
        selectorIndex = 21
    elseif selectorIndex <= 17 then
        local row, col = getRowCol(selectorIndex)

        if row < 4 then
            row = row + 1
            selectorIndex = getIndex(row, col)
        end
    end

    UpdateComment()
end

function State_07AddingNewRecord.LeftPressed()
    if selectorIndex ~= 21 and selectorIndex ~= 22 then
        local row, col = getRowCol(selectorIndex)

        if col > 0 then
            col = col - 1
            selectorIndex = getIndex(row, col)
        end
    end

    UpdateComment()
end

function State_07AddingNewRecord.RightPressed()
    if selectorIndex ~= 21 and selectorIndex ~= 22 then
        local row, col = getRowCol(selectorIndex)

        if col < 3 then
            col = col + 1
            selectorIndex = getIndex(row, col)
        end
    end

    UpdateComment()
end

function State_07AddingNewRecord.CenterPressed()

	if selectorIndex == 22 then
		Game.selectedChartOptIndex = 0
		Game.selectedChartOptName = ""
		Game.selectedChartIndex = 0
		Game.selectedChartName = ""
		Game.selectedChartDifficultyName = ""
		Game.selectedChartRecommendedSpeed = ""

		if Game.selectedSortName == "Full Display Mode" then
			Game.state = 41
		else
			Game.state = 42
		end

	elseif selectorIndex == 21 then

		SaveANewRecord()

		Game.selectedChartOptIndex = 0
		Game.selectedChartOptName = ""
		Game.selectedChartIndex = 0
		Game.selectedChartName = ""
		Game.selectedChartDifficultyName = ""
		Game.selectedChartRecommendedSpeed = ""

		if Game.selectedSortName == "Full Display Mode" then
			Game.state = 41
		else
			Game.state = 42
		end

	elseif selectorIndex == 20 then
		if missesU == 9 then missesU = 0 else missesU = missesU + 1 end
	elseif selectorIndex == 19 then
		if missesD == 9 then missesD = 0 else missesD = missesD + 1 end
	elseif selectorIndex == 18 then
		if missesC == 9 then missesC = 0 else missesC = missesC + 1 end
	elseif selectorIndex == 17 then
		if missesM == 9 then missesM = 0 else missesM = missesM + 1 end
	elseif selectorIndex == 16 then
		if badsU == 9 then badsU = 0 else badsU = badsU + 1 end
	elseif selectorIndex == 15 then
		if badsD == 9 then badsD = 0 else badsD = badsD + 1 end
	elseif selectorIndex == 14 then
		if badsC == 9 then badsC = 0 else badsC = badsC + 1 end
	elseif selectorIndex == 13 then
		if badsM == 9 then badsM = 0 else badsM = badsM + 1 end
	elseif selectorIndex == 12 then
		if goodsU == 9 then goodsU = 0 else goodsU = goodsU + 1 end
	elseif selectorIndex == 11 then
		if goodsD == 9 then goodsD = 0 else goodsD = goodsD + 1 end
	elseif selectorIndex == 10 then
		if goodsC == 9 then goodsC = 0 else goodsC = goodsC + 1 end
	elseif selectorIndex == 9 then
		if goodsM == 9 then goodsM = 0 else goodsM = goodsM + 1 end
	elseif selectorIndex == 8 then
		if greatsU == 9 then greatsU = 0 else greatsU = greatsU + 1 end
	elseif selectorIndex == 7 then
		if greatsD == 9 then greatsD = 0 else greatsD = greatsD + 1 end
	elseif selectorIndex == 6 then
		if greatsC == 9 then greatsC = 0 else greatsC = greatsC + 1 end
	elseif selectorIndex == 5 then
		if greatsM == 9 then greatsM = 0 else greatsM = greatsM + 1 end
	elseif selectorIndex == 4 then
		if perfectsU == 9 then perfectsU = 0 else perfectsU = perfectsU + 1 end
	elseif selectorIndex == 3 then
		if perfectsD == 9 then perfectsD = 0 else perfectsD = perfectsD + 1 end
	elseif selectorIndex == 2 then
		if perfectsC == 9 then perfectsC = 0 else perfectsC = perfectsC + 1 end
	elseif selectorIndex == 1 then
		if perfectsM == 9 then perfectsM = 0 else perfectsM = perfectsM + 1 end
	end

	UpdateComment()

end

function State_07AddingNewRecord.BackPressed()

	if selectorIndex == 20 then
		if missesU == 0 then missesU = 9 else missesU = missesU - 1 end
	elseif selectorIndex == 19 then
		if missesD == 0 then missesD = 9 else missesD = missesD - 1 end
	elseif selectorIndex == 18 then
		if missesC == 0 then missesC = 9 else missesC = missesC - 1 end
	elseif selectorIndex == 17 then
		if missesM == 0 then missesM = 9 else missesM = missesM - 1 end
	elseif selectorIndex == 16 then
		if badsU == 0 then badsU = 9 else badsU = badsU - 1 end
	elseif selectorIndex == 15 then
		if badsD == 0 then badsD = 9 else badsD = badsD - 1 end
	elseif selectorIndex == 14 then
		if badsC == 0 then badsC = 9 else badsC = badsC - 1 end
	elseif selectorIndex == 13 then
		if badsM == 0 then badsM = 9 else badsM = badsM - 1 end
	elseif selectorIndex == 12 then
		if goodsU == 0 then goodsU = 9 else goodsU = goodsU - 1 end
	elseif selectorIndex == 11 then
		if goodsD == 0 then goodsD = 9 else goodsD = goodsD - 1 end
	elseif selectorIndex == 10 then
		if goodsC == 0 then goodsC = 9 else goodsC = goodsC - 1 end
	elseif selectorIndex == 9 then
		if goodsM == 0 then goodsM = 9 else goodsM = goodsM - 1 end
	elseif selectorIndex == 8 then
		if greatsU == 0 then greatsU = 9 else greatsU = greatsU - 1 end
	elseif selectorIndex == 7 then
		if greatsD == 0 then greatsD = 9 else greatsD = greatsD - 1 end
	elseif selectorIndex == 6 then
		if greatsC == 0 then greatsC = 9 else greatsC = greatsC - 1 end
	elseif selectorIndex == 5 then
		if greatsM == 0 then greatsM = 9 else greatsM = greatsM - 1 end
	elseif selectorIndex == 4 then
		if perfectsU == 0 then perfectsU = 9 else perfectsU = perfectsU - 1 end
	elseif selectorIndex == 3 then
		if perfectsD == 0 then perfectsD = 9 else perfectsD = perfectsD - 1 end
	elseif selectorIndex == 2 then
		if perfectsC == 0 then perfectsC = 9 else perfectsC = perfectsC - 1 end
	elseif selectorIndex == 1 then
		if perfectsM == 0 then perfectsM = 9 else perfectsM = perfectsM - 1 end
	end

end











































-- DRAWING

function State_07AddingNewRecord.Drawing()
	local drawingX = 6
	local drawingY = Game.baseDrawingY
	local linebreakSize = 42

	UpdateComment()

	-- background
	meckx_clearScreen({
		ColorName = "backgroundGray",
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
	local selectorX, selectorY

	if selectorIndex == 21 or selectorIndex == 22 then selectorX = -200; selectorY = -200;
	else
		local row, col = getRowCol(selectorIndex)
		selectorX = (drawingX + 23) + (col * 24)
		selectorY = 89 + (row * 42)
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
		ColorName = (selectorIndex == 2) and "black" or "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = perfectsD,
		XPos = drawingX+(3*24),
		YPos = drawingY,
		ColorName = (selectorIndex == 3) and "black" or "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = perfectsU,
		XPos = drawingX+(4*24),
		YPos = drawingY,
		ColorName = (selectorIndex == 4) and "black" or "white",
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
		ColorName = (selectorIndex == 6) and "black" or "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = greatsD,
		XPos = drawingX+(3*24),
		YPos = drawingY,
		ColorName = (selectorIndex == 7) and "black" or "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = greatsU,
		XPos = drawingX+(4*24),
		YPos = drawingY,
		ColorName = (selectorIndex == 8) and "black" or "white",
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
		ColorName = (selectorIndex == 10) and "black" or "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = goodsD,
		XPos = drawingX+(3*24),
		YPos = drawingY,
		ColorName = (selectorIndex == 11) and "black" or "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = goodsU,
		XPos = drawingX+(4*24),
		YPos = drawingY,
		ColorName = (selectorIndex == 12) and "black" or "white",
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
		ColorName = (selectorIndex == 14) and "black" or "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = badsD,
		XPos = drawingX+(3*24),
		YPos = drawingY,
		ColorName = (selectorIndex == 15) and "black" or "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = badsU,
		XPos = drawingX+(4*24),
		YPos = drawingY,
		ColorName = (selectorIndex == 16) and "black" or "white",
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
		ColorName = (selectorIndex == 18) and "black" or "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = missesD,
		XPos = drawingX+(3*24),
		YPos = drawingY,
		ColorName = (selectorIndex == 19) and "black" or "white",
		FontStyle = ClassicConsole_48,
	})
	meckx_print({
		Text = missesU,
		XPos = drawingX+(4*24),
		YPos = drawingY,
		ColorName = (selectorIndex == 20) and "black" or "white",
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
	meckx_print({
		Text = displayAccuracy,
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
	meckx_print({
		Text = displayStars,
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
		ColorName = (selectorIndex == 21) and "meckx_03Green_light" or "meckx_03Green_dark",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize
	meckx_print({
		Text = (selectorIndex == 22) and "> Cancel..." or "Cancel...",
		XPos = (selectorIndex == 22) and drawingX or drawingX+24,
		YPos = drawingY,
		ColorName = (selectorIndex == 22) and "meckx_06Red_light" or "meckx_06Red_dark",
		FontStyle = ClassicConsole_48,
	})
end











































return State_07AddingNewRecord