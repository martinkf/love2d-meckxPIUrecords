local State_05SelectChart = {}

-- INPUT HANDLING

function State_05SelectChart.UpPressed()

	Game.selectedChartIndex = Game.selectedChartIndex - 1
	if Game.selectedChartIndex == 0 then Game.selectedChartIndex = #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts end
	Game.selectedChartName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts[Game.selectedChartIndex]
	Game.selectedChartDifficultyName = DatabaseDetails.FetchChartDifficultyName(Game.selectedSongName, Game.selectedChartName)
	--love.audio.play(SfxMove:clone())

end

function State_05SelectChart.DownPressed()

	Game.selectedChartIndex = Game.selectedChartIndex + 1
	if Game.selectedChartIndex > #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts then Game.selectedChartIndex = 1 end
	Game.selectedChartName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts[Game.selectedChartIndex]
	Game.selectedChartDifficultyName = DatabaseDetails.FetchChartDifficultyName(Game.selectedSongName, Game.selectedChartName)
	--love.audio.play(SfxMove:clone())

end

function State_05SelectChart.BackPressed()

	Game.state = 4

	Game.selectedChartIndex = 0
	Game.selectedChartName = ""
	Game.selectedChartDifficultyName = ""

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
	local tempdrawingY = drawingY
	for j=1,#Game.selectedSongArrayOfCharts,1 do
		
		local songToInput = Game.selectedSongName
		local chartToInput = Game.selectedSongArrayOfCharts[j]

		local text = DatabaseDetails.FetchChartDifficultyName(songToInput, chartToInput).." - "..chartToInput

		meckx_print({
			Text = (j == Game.selectedChartIndex) and "> "..text or text,
			XPos = (j == Game.selectedChartIndex) and drawingX or drawingX+24,
			YPos = drawingY,
			ColorName = (j == Game.selectedChartIndex) and DatabaseDetails.FetchChartColorEnabled(songToInput, chartToInput) or DatabaseDetails.FetchChartColorDisabled(songToInput, chartToInput),
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + 2 * linebreakSize
	end

	--this is a temporary display on how records might appear
	--[[
	drawingY = tempdrawingY
	for j=1,#Game.selectedSongArrayOfCharts,1 do
		if j == 1 then
			meckx_print({
				Text = "100.0% ·  FPC · 22/08/2026",
				XPos = drawingX+(27*24),
				YPos = drawingY,
				ColorName = "blue",
				FontStyle = ClassicConsole_48,
			})
			drawingY = drawingY + linebreakSize
			meckx_print({
				Text = "0320 · 0000 · 0000 · 0000 · 0000",
				XPos = drawingX+(21*24),
				YPos = drawingY,
				ColorName = "white",
				FontStyle = ClassicConsole_48,
			})
			drawingY = drawingY + linebreakSize
		elseif j == 2 then
			meckx_print({
				Text = "99.37% ·   FC · 02/04/2026",
				XPos = drawingX+(27*24),
				YPos = drawingY,
				ColorName = "green",
				FontStyle = ClassicConsole_48,
			})
			drawingY = drawingY + linebreakSize
			meckx_print({
				Text = "0316 · 0004 · 0000 · 0000 · 0000",
				XPos = drawingX+(21*24),
				YPos = drawingY,
				ColorName = "white",
				FontStyle = ClassicConsole_48,
			})
			drawingY = drawingY + linebreakSize
		elseif j == 3 then
			meckx_print({
				Text = "99.06% ·   1B · 03/07/2025",
				XPos = drawingX+(27*24),
				YPos = drawingY,
				ColorName = "magenta",
				FontStyle = ClassicConsole_48,
			})
			drawingY = drawingY + linebreakSize
			meckx_print({
				Text = "0315 · 0004 · 0000 · 0000 · 0001",
				XPos = drawingX+(21*24),
				YPos = drawingY,
				ColorName = "white",
				FontStyle = ClassicConsole_48,
			})
			drawingY = drawingY + linebreakSize
		elseif j == 4 then
			meckx_print({
				Text = "94.47% ·   9B · 09/12/2025",
				XPos = drawingX+(27*24),
				YPos = drawingY,
				ColorName = "magenta",
				FontStyle = ClassicConsole_48,
			})
			drawingY = drawingY + linebreakSize
			meckx_print({
				Text = "0293 · 0018 · 0002 · 0002 · 0005",
				XPos = drawingX+(21*24),
				YPos = drawingY,
				ColorName = "white",
				FontStyle = ClassicConsole_48,
			})
			drawingY = drawingY + linebreakSize
		else
			meckx_print({
				Text = "89.47% · +10B · 12/02/2025",
				XPos = drawingX+(27*24),
				YPos = drawingY,
				ColorName = "red",
				FontStyle = ClassicConsole_48,
			})
			drawingY = drawingY + linebreakSize
			meckx_print({
				Text = "0270 · 0032 · 0000 · 0006 · 0012",
				XPos = drawingX+(21*24),
				YPos = drawingY,
				ColorName = "white",
				FontStyle = ClassicConsole_48,
			})
			drawingY = drawingY + linebreakSize
		end
		
	end
	]]--

end











































return State_05SelectChart