local State_05SelectChart = {}

-- INPUT HANDLING

function State_05SelectChart.UpPressed()

	Game.selectedChartIndex = Game.selectedChartIndex - 1
	if Game.selectedChartIndex == 0 then Game.selectedChartIndex = #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts end
	Game.selectedChartName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts[Game.selectedChartIndex]
	Game.selectedChartDifficultyName = FetchChartDifficultyName(Game.selectedSongName, Game.selectedChartName)
	Game.selectedChartRecommendedSpeed = FetchRecommendedSpeed(Game.selectedPlayerName, Game.selectedSongName, Game.selectedChartName)

end

function State_05SelectChart.DownPressed()

	Game.selectedChartIndex = Game.selectedChartIndex + 1
	if Game.selectedChartIndex > #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts then Game.selectedChartIndex = 1 end
	Game.selectedChartName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts[Game.selectedChartIndex]
	Game.selectedChartDifficultyName = FetchChartDifficultyName(Game.selectedSongName, Game.selectedChartName)
	Game.selectedChartRecommendedSpeed = FetchRecommendedSpeed(Game.selectedPlayerName, Game.selectedSongName, Game.selectedChartName)

end

function State_05SelectChart.CenterPressed()

	Game.selectedChartOptIndex = 1
	Game.selectedChartOptName = "Add new record"

	Game.state = 6

end

function State_05SelectChart.BackPressed()

	Game.state = 41

	Game.selectedChartIndex = 0
	Game.selectedChartName = ""
	Game.selectedChartDifficultyName = ""
	Game.selectedChartRecommendedSpeed = ""

end









































-- DRAWING

function State_05SelectChart.Drawing()
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
		Text = "../"..Game.selectedSongName,
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
	local tempdrawingY = drawingY
	for j=1,#Game.selectedSongArrayOfCharts,1 do
		
		local songToInput = Game.selectedSongName
		local chartToInput = Game.selectedSongArrayOfCharts[j]

		local text = FetchChartDifficultyName(songToInput, chartToInput).."·"..chartToInput

		meckx_print({
			Text = (j == Game.selectedChartIndex) and "> "..text or text,
			XPos = (j == Game.selectedChartIndex) and drawingX or drawingX+24,
			YPos = drawingY,
			ColorName = (j == Game.selectedChartIndex) and FetchChartColorEnabled(songToInput, chartToInput) or FetchChartColorDisabled(songToInput, chartToInput),
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + 2 * linebreakSize
	end








	--displaying top record information
	drawingY = tempdrawingY
	for j=1,#Game.selectedSongArrayOfCharts,1 do
		local actualText = "-"
		local actualText2 = ""
		local actualTextP = ""
		local actualTextG = ""
		local actualTextD = ""
		local actualTextB = ""
		local actualTextM = ""
		local actualColor = "lightGray"
		local highScoreObject = FetchHighScore(Game.selectedPlayerName, Game.selectedSongName, Game.selectedSongArrayOfCharts[j])
		if highScoreObject then
			actualText = highScoreObject.DisplayStars .. " " .. highScoreObject.DisplayAccuracy
			actualText2 = highScoreObject.Date .. " " .. highScoreObject.Time
			actualTextP = string.format("%04d", highScoreObject.Perfects)
			actualTextG = string.format("%04d", highScoreObject.Greats)
			actualTextD = string.format("%04d", highScoreObject.Goods)
			actualTextB = string.format("%04d", highScoreObject.Bads)
			actualTextM = string.format("%04d", highScoreObject.Misses)
			actualColor = FetchHighScoreColor(Game.selectedPlayerName, Game.selectedSongName, Game.selectedSongArrayOfCharts[j])
		end
		local textPos = 52-#actualText

		meckx_print({
			Text = actualText,
			XPos = drawingX+(textPos*24),
			YPos = drawingY,
			ColorName = actualColor,
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize

		meckx_print({
			Text = actualText2,
			XPos = drawingX+(6*24),
			YPos = drawingY,
			ColorName = actualColor,
			FontStyle = ClassicConsole_48,
		})
		meckx_print({ Text = "|", XPos = drawingX+(26*24), YPos = drawingY, ColorName = "white", FontStyle = ClassicConsole_48, })
		meckx_print({
			Text = actualTextP,
			XPos = drawingX+(27*24),
			YPos = drawingY,
			ColorName = "meckx_02Blue_light",
			FontStyle = ClassicConsole_48,
		})
		meckx_print({ Text = "|", XPos = drawingX+(31*24), YPos = drawingY, ColorName = "white", FontStyle = ClassicConsole_48, })
		meckx_print({
			Text = actualTextG,
			XPos = drawingX+(32*24),
			YPos = drawingY,
			ColorName = "meckx_03Green_light",
			FontStyle = ClassicConsole_48,
		})
		meckx_print({ Text = "|", XPos = drawingX+(36*24), YPos = drawingY, ColorName = "white", FontStyle = ClassicConsole_48, })
		meckx_print({
			Text = actualTextD,
			XPos = drawingX+(37*24),
			YPos = drawingY,
			ColorName = "meckx_04Yellow_light",
			FontStyle = ClassicConsole_48,
		})
		meckx_print({ Text = "|", XPos = drawingX+(41*24), YPos = drawingY, ColorName = "white", FontStyle = ClassicConsole_48, })
		meckx_print({
			Text = actualTextB,
			XPos = drawingX+(42*24),
			YPos = drawingY,
			ColorName = "meckx_01Pink_light",
			FontStyle = ClassicConsole_48,
		})
		meckx_print({ Text = "|", XPos = drawingX+(46*24), YPos = drawingY, ColorName = "white", FontStyle = ClassicConsole_48, })
		meckx_print({
			Text = actualTextM,
			XPos = drawingX+(47*24),
			YPos = drawingY,
			ColorName = "meckx_06Red_light",
			FontStyle = ClassicConsole_48,
		})
		meckx_print({ Text = "|", XPos = drawingX+(51*24), YPos = drawingY, ColorName = "white", FontStyle = ClassicConsole_48, })
		drawingY = drawingY + linebreakSize
	end

end











































return State_05SelectChart