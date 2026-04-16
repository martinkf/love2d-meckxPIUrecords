local State_06ChartSelected = {}

-- LOCAL VARIABLES

local chartOptions = {
	"Add new record",
	"Edit recommended speed"
}

-- INPUT HANDLING

function State_06ChartSelected.UpPressed()

	Game.selectedChartOptIndex = Game.selectedChartOptIndex - 1
	if Game.selectedChartOptIndex == 0 then Game.selectedChartOptIndex = #chartOptions end
	Game.selectedChartOptName = chartOptions[Game.selectedChartOptIndex]

end

function State_06ChartSelected.DownPressed()

	Game.selectedChartOptIndex = Game.selectedChartOptIndex + 1
	if Game.selectedChartOptIndex > #chartOptions then Game.selectedChartOptIndex = 1 end
	Game.selectedChartOptName = chartOptions[Game.selectedChartOptIndex]

end

function State_06ChartSelected.CenterPressed()

	if Game.selectedChartOptIndex == 1 then
		ResetState07()
		Game.state = 7
	elseif Game.selectedChartOptIndex == 2 then
		ResetState08()
		Game.state = 8
	end

end

function State_06ChartSelected.BackPressed()

	Game.selectedChartOptIndex = 0
	Game.selectedChartOptName = ""

	if Game.selectedSortName == "Full Display Mode" then
		-- then we will return to a "multiple-chart songwheel"
		Game.selectedChartIndex = 0
		Game.selectedChartName = ""
		Game.selectedChartDifficultyName = ""
		Game.selectedChartRecommendedSpeed = ""
		Game.state = 41
	else
		-- we will return to a "single-chart songwheel"
		Game.state = 42
	end

end









































-- DRAWING

function State_06ChartSelected.Drawing()
	local drawingX = 6
	local drawingY = Game.baseDrawingY
	local linebreakSize = 42

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
		Text = "../"..Game.selectedSongName.."/"..Game.selectedChartName,
		XPos = drawingX+24,
		YPos = drawingY-2,
		ColorName = "yellow",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = Game.selectedChartName,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = FetchChartColorEnabled(Game.selectedSongName, Game.selectedChartName),
		FontStyle = ClassicConsole_48,
	})
	local outputText = "["..Game.selectedChartRecommendedSpeed.."]"
	meckx_print({
		Text = outputText,
		XPos = drawingX + ((53-#outputText)*24),
		YPos = drawingY,
		ColorName = "lightGray",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize
	meckx_print({
		Text = Game.selectedChartDifficultyName,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = FetchChartColorEnabled(Game.selectedSongName, Game.selectedChartName),
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "----------------- 06. CHART OPTIONS -----------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	for i=1,#chartOptions,1 do
		meckx_print({
			Text = (i == Game.selectedChartOptIndex) and "> "..chartOptions[i] or chartOptions[i],
			XPos = (i == Game.selectedChartOptIndex) and drawingX or drawingX+24,
			YPos = drawingY,
			ColorName = "white",
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize
	end

	meckx_print({
		Text = "---------------------- RECORDS ----------------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

end











































return State_06ChartSelected