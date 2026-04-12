local State_06ChartSelected = {}

-- LOCAL VARIABLES

local chartOptions = {
	"Add new record",
}

-- LOCAL FUNCTIONS
function TestSaveDummyScore()
    local playerName = Game.selectedPlayerName

    -- safety (never crash)
    MemorycardData = MemorycardData or {}
    MemorycardData.Players = MemorycardData.Players or {}
    MemorycardData.Players[playerName] = MemorycardData.Players[playerName] or {}
    MemorycardData.Players[playerName].Scores = MemorycardData.Players[playerName].Scores or {}

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
        Score = 3,
        Comment = "1 GOOD"
    }

    table.insert(MemorycardData.Players[playerName].Scores, newEntry)

    SaveToMemorycard()
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

	TestSaveDummyScore()

	Game.selectedChartOptIndex = 0
	Game.selectedChartOptName = ""

	Game.selectedChartIndex = 0
	Game.selectedChartName = ""
	Game.selectedChartDifficultyName = ""

	Game.state = 4

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