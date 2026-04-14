local State_06ChartSelected = {}

-- LOCAL VARIABLES

local chartOptions = {
	"Add new record",
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

	ResetState07Numbers()
	Game.state = 7

end

function State_06ChartSelected.BackPressed()

	Game.state = 5

	Game.selectedChartOptIndex = 0
	Game.selectedChartOptName = ""

end









































-- DRAWING

function State_06ChartSelected.Drawing()
	local drawingX = 6
	local drawingY = Game.baseDrawingY
	local linebreakSize = 42

	-- background
	meckx_clearScreen({
		ColorName = "black",
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