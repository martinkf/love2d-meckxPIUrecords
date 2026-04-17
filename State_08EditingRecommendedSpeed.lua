local State_08EditingRecommendedSpeed = {}

-- LOCAL VARIABLES
local selectorIndex = 1
local editingRecommendedSpeed

-- GLOBAL FUNCTIONS
function ResetState08()
	selectorIndex = 1
	editingRecommendedSpeed = Game.selectedChartRecommendedSpeed
end

-- LOCAL FUNCTIONS
local function SaveEditRecommendedSpeed()

    MemorycardData = MemorycardData or {}
    MemorycardData.Players = MemorycardData.Players or {}
    MemorycardData.Players[Game.selectedPlayerName] = MemorycardData.Players[Game.selectedPlayerName] or {}
    MemorycardData.Players[Game.selectedPlayerName].RecommendedSpeeds = MemorycardData.Players[Game.selectedPlayerName].RecommendedSpeeds or {}

    local speeds = MemorycardData.Players[Game.selectedPlayerName].RecommendedSpeeds

    local newEntry = {
        SongTitle = Game.selectedSongName,
        ChartName = Game.selectedChartName,
        RecommendedSpeed = editingRecommendedSpeed
    }

    local found = false

    for i, entry in ipairs(speeds) do
        if entry.SongTitle == newEntry.SongTitle and entry.ChartName == newEntry.ChartName then
            speeds[i] = newEntry
            found = true
            break
        end
    end

    if not found then
        table.insert(speeds, newEntry)
    end

	Game.selectedChartRecommendedSpeed = editingRecommendedSpeed
    SaveToMemorycard()

end

-- INPUT HANDLING

function State_08EditingRecommendedSpeed.UpPressed()

	selectorIndex = selectorIndex - 1
	if selectorIndex == 0 then selectorIndex = 3 end

end

function State_08EditingRecommendedSpeed.DownPressed()

    selectorIndex = selectorIndex + 1
	if selectorIndex == 4 then selectorIndex = 1 end

end

function State_08EditingRecommendedSpeed.LeftPressed()

	if selectorIndex == 1 then
		if editingRecommendedSpeed == "4.5x" then editingRecommendedSpeed = "  4x"
		elseif editingRecommendedSpeed == "  4x" then editingRecommendedSpeed = "3.5x"
		elseif editingRecommendedSpeed == "3.5x" then editingRecommendedSpeed = "  3x"
		elseif editingRecommendedSpeed == "  3x" then editingRecommendedSpeed = "2.5x"
		elseif editingRecommendedSpeed == "2.5x" then editingRecommendedSpeed = "  2x"
		elseif editingRecommendedSpeed == "  2x" then editingRecommendedSpeed = "1.5x"
		elseif editingRecommendedSpeed == "1.5x" then editingRecommendedSpeed = "  1x"
		elseif editingRecommendedSpeed == "  1x" then editingRecommendedSpeed = "0.5x"
		end
	end

end

function State_08EditingRecommendedSpeed.RightPressed()

	if selectorIndex == 1 then
		if editingRecommendedSpeed == "  0x" then editingRecommendedSpeed = "0.5x"
		elseif editingRecommendedSpeed == "0.5x" then editingRecommendedSpeed = "  1x"
		elseif editingRecommendedSpeed == "  1x" then editingRecommendedSpeed = "1.5x"
		elseif editingRecommendedSpeed == "1.5x" then editingRecommendedSpeed = "  2x"
		elseif editingRecommendedSpeed == "  2x" then editingRecommendedSpeed = "2.5x"
		elseif editingRecommendedSpeed == "2.5x" then editingRecommendedSpeed = "  3x"
		elseif editingRecommendedSpeed == "  3x" then editingRecommendedSpeed = "3.5x"
		elseif editingRecommendedSpeed == "3.5x" then editingRecommendedSpeed = "  4x"
		elseif editingRecommendedSpeed == "  4x" then editingRecommendedSpeed = "4.5x"
		end
	end

end

function State_08EditingRecommendedSpeed.CenterPressed()

	if selectorIndex == 2 then
		SaveEditRecommendedSpeed()
		Game.state = 6
	elseif selectorIndex == 3 then
		State_08EditingRecommendedSpeed.BackPressed()
	end

end

function State_08EditingRecommendedSpeed.BackPressed()

	Game.state = 6

end











































-- DRAWING

function State_08EditingRecommendedSpeed.Drawing()
	local drawingX = 6
	local drawingY = Game.baseDrawingY
	local linebreakSize = 42

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
		Text = "../"..Game.selectedSongName.."/"..Game.selectedChartName.."/EDITING RECOMMENDED SPEED",
		XPos = drawingX+24,
		YPos = drawingY-2,
		ColorName = "yellow",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "------------- 07. EDIT RECOMMENDED SPEED ------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + (2 * linebreakSize)

	meckx_print({
		Text = (selectorIndex == 1) and "> Recommended speed: " .. editingRecommendedSpeed or "Recommended speed: " .. editingRecommendedSpeed,
		XPos = (selectorIndex == 1) and drawingX or drawingX+24,
		YPos = drawingY,
		ColorName = (selectorIndex == 1) and "white" or "lightGray",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + (2 * linebreakSize)

	meckx_print({
		Text = (selectorIndex == 2) and "> Confirm editing recommended speed..." or "Confirm editing recommended speed...",
		XPos = (selectorIndex == 2) and drawingX or drawingX+24,
		YPos = drawingY,
		ColorName = (selectorIndex == 2) and "meckx_03Green_light" or "meckx_03Green_dark",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize
	meckx_print({
		Text = (selectorIndex == 3) and "> Cancel..." or "Cancel...",
		XPos = (selectorIndex == 3) and drawingX or drawingX+24,
		YPos = drawingY,
		ColorName = (selectorIndex == 3) and "meckx_06Red_light" or "meckx_06Red_dark",
		FontStyle = ClassicConsole_48,
	})
end











































return State_08EditingRecommendedSpeed