local State_06ChartSelected = {}

-- LOCAL VARIABLES

local chartOptions = {
	"Add new record",
	"Edit recommended speed"
}

-- GLOBAL FUNCTIONS
function ResetState06()
	--
end

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
	local text = Game.selectedSongName
	local textSize = #text
	meckx_print({
		Text = Game.selectedSongName,
		XPos = drawingX+(((53-#text)/2)*24),
		YPos = drawingY-2,
		ColorName = "yellow",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_rect({
		XPos = 0,
		YPos = 44,
		Width = 1280,
		Height = 40,
		ColorName = FetchChartColorEnabled(Game.selectedSongName, Game.selectedChartName),
		RectStyle = "fill",
		Transparency = 1,
	})
	local text2 = Game.selectedChartDifficultyName .. " - " .. Game.selectedChartName .. " - [" .. Game.selectedChartRecommendedSpeed .. "]"
	meckx_print({
		Text = text2,
		XPos = drawingX+(((53-#text2)/2)*24),
		YPos = drawingY,
		ColorName = "white",
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