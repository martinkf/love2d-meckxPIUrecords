local State_05SelectChart = {}

-- INPUT HANDLING

function State_05SelectChart.UpPressed()

	Game.selectedChartIndex = Game.selectedChartIndex - 1
	if Game.selectedChartIndex == 0 then Game.selectedChartIndex = #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts end
	Game.selectedChartName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts[Game.selectedChartIndex]
	Game.selectedChartDifficulty = DatabaseCharts.FetchChartDifficulty(Game.selectedSongName, Game.selectedChartName)
	--love.audio.play(SfxMove:clone())

end

function State_05SelectChart.DownPressed()

	Game.selectedChartIndex = Game.selectedChartIndex + 1
	if Game.selectedChartIndex > #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts then Game.selectedChartIndex = 1 end
	Game.selectedChartName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts[Game.selectedChartIndex]
	Game.selectedChartDifficulty = DatabaseCharts.FetchChartDifficulty(Game.selectedSongName, Game.selectedChartName)
	--love.audio.play(SfxMove:clone())

end

function State_05SelectChart.BackPressed()

	Game.state = 4

	Game.selectedChartIndex = 0
	Game.selectedChartName = ""
	Game.selectedChartDifficulty = ""

	--love.audio.play(SfxBack:clone())

end









































-- DRAWING

function State_05SelectChart.Drawing()
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
		Text = Game.selectedSongName,
		XPos = drawingX+24,
		YPos = drawingY-2,
		ColorName = "yellow",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "----------------- 05. SELECT A CHART ----------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	-- drawing charts
	for j=1,#Game.selectedSongArrayOfCharts,1 do
		
		local songToInput = Game.selectedSongName
		local chartToInput = Game.selectedSongArrayOfCharts[j]

		local text = DatabaseCharts.FetchChartDifficulty(songToInput, chartToInput).." - "..string.format("%-15s", chartToInput).." - "

		meckx_print({
			Text = (j == Game.selectedChartIndex) and "> "..text or text,
			XPos = (j == Game.selectedChartIndex) and drawingX or drawingX+24,
			YPos = drawingY,
			ColorName = (j == Game.selectedChartIndex) and "white" or DatabaseCharts.FetchChartColor(songToInput, chartToInput),
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + 2 * linebreakSize
	end

end











































return State_05SelectChart