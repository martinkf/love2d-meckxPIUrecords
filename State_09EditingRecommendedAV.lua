local State_09EditingRecommendedAV = {}

-- LOCAL VARIABLES
local selectorIndex = 1
local editingRecommendedAV

-- GLOBAL FUNCTIONS
function ResetState09()
	selectorIndex = 1
	editingRecommendedAV = Game.selectedChartRecommendedAV
end

-- LOCAL FUNCTIONS
local function SaveEditRecommendedAV()

    MemorycardData = MemorycardData or {}
    MemorycardData.Players = MemorycardData.Players or {}
    MemorycardData.Players[Game.selectedPlayerName] = MemorycardData.Players[Game.selectedPlayerName] or {}
    MemorycardData.Players[Game.selectedPlayerName].RecommendedAVs = MemorycardData.Players[Game.selectedPlayerName].RecommendedAVs or {}

    local avs = MemorycardData.Players[Game.selectedPlayerName].RecommendedAVs

    local newEntry = {
        SongTitle = Game.selectedSongName,
        ChartName = Game.selectedChartName,
        RecommendedAV = editingRecommendedAV
    }

    local found = false

    for i, entry in ipairs(avs) do
        if entry.SongTitle == newEntry.SongTitle and entry.ChartName == newEntry.ChartName then
            avs[i] = newEntry
            found = true
            break
        end
    end

    if not found then
        table.insert(avs, newEntry)
    end

	Game.selectedChartRecommendedAV = editingRecommendedAV
    SaveToMemorycard()

end

-- INPUT HANDLING

function State_09EditingRecommendedAV.UpPressed()

	selectorIndex = selectorIndex - 1
	if selectorIndex == 0 then selectorIndex = 3 end

end

function State_09EditingRecommendedAV.DownPressed()

    selectorIndex = selectorIndex + 1
	if selectorIndex == 4 then selectorIndex = 1 end

end

function State_09EditingRecommendedAV.LeftPressed()

	if selectorIndex == 1 then
		if editingRecommendedAV == "500AV" then editingRecommendedAV = "480AV"
		elseif editingRecommendedAV == "480AV" then editingRecommendedAV = "460AV"
		elseif editingRecommendedAV == "460AV" then editingRecommendedAV = "440AV"
		elseif editingRecommendedAV == "440AV" then editingRecommendedAV = "420AV"
		elseif editingRecommendedAV == "420AV" then editingRecommendedAV = "400AV"
		elseif editingRecommendedAV == "400AV" then editingRecommendedAV = "380AV"
		elseif editingRecommendedAV == "380AV" then editingRecommendedAV = "360AV"
		elseif editingRecommendedAV == "360AV" then editingRecommendedAV = "340AV"
		elseif editingRecommendedAV == "340AV" then editingRecommendedAV = "320AV"
		elseif editingRecommendedAV == "320AV" then editingRecommendedAV = "300AV"
		end
	end

end

function State_09EditingRecommendedAV.RightPressed()

	if selectorIndex == 1 then
		if editingRecommendedAV == "?????" then editingRecommendedAV = "300AV"
		elseif editingRecommendedAV == "300AV" then editingRecommendedAV = "320AV"
		elseif editingRecommendedAV == "320AV" then editingRecommendedAV = "340AV"
		elseif editingRecommendedAV == "340AV" then editingRecommendedAV = "360AV"
		elseif editingRecommendedAV == "360AV" then editingRecommendedAV = "380AV"
		elseif editingRecommendedAV == "380AV" then editingRecommendedAV = "400AV"
		elseif editingRecommendedAV == "400AV" then editingRecommendedAV = "420AV"
		elseif editingRecommendedAV == "420AV" then editingRecommendedAV = "440AV"
		elseif editingRecommendedAV == "440AV" then editingRecommendedAV = "460AV"
		elseif editingRecommendedAV == "460AV" then editingRecommendedAV = "480AV"
		elseif editingRecommendedAV == "480AV" then editingRecommendedAV = "500AV"
		end
	end

end

function State_09EditingRecommendedAV.CenterPressed()

	if selectorIndex == 2 then
		SaveEditRecommendedAV()
		Game.state = 6
	elseif selectorIndex == 3 then
		State_09EditingRecommendedAV.BackPressed()
	end

end

function State_09EditingRecommendedAV.BackPressed()

	Game.state = 6

end











































-- DRAWING

function State_09EditingRecommendedAV.Drawing()
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
		Text = "../"..Game.selectedSongName.."/"..Game.selectedChartName.."/EDITING RECOMMENDED AV",
		XPos = drawingX+24,
		YPos = drawingY-2,
		ColorName = "yellow",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "------------- 07. EDIT RECOMMENDED AV ------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + (2 * linebreakSize)

	meckx_print({
		Text = (selectorIndex == 1) and "> Recommended AV: " .. editingRecommendedAV or "Recommended AV: " .. editingRecommendedAV,
		XPos = (selectorIndex == 1) and drawingX or drawingX+24,
		YPos = drawingY,
		ColorName = (selectorIndex == 1) and "white" or "lightGray",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + (2 * linebreakSize)

	meckx_print({
		Text = (selectorIndex == 2) and "> Confirm editing recommended AV..." or "Confirm editing recommended AV...",
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











































return State_09EditingRecommendedAV