local State_03SelectSort = {}

-- INPUT HANDLING

function State_03SelectSort.UpPressed()

	Game.selectedSortIndex = Game.selectedSortIndex - 1
	if true then
		-- doesn't wrap around
		if Game.selectedSortIndex == 0 then Game.selectedSortIndex = 1 end
	else
		-- wraps around
		if Game.selectedSortIndex == 0 then Game.selectedSortIndex = #DatabaseMixes[Game.selectedMixIndex].SortingMethods end
	end

	Game.selectedSortName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].SortName
	Game.selectedSortTotalSongs = #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs

end

function State_03SelectSort.DownPressed()

	Game.selectedSortIndex = Game.selectedSortIndex + 1
	if true then
		-- doesnt' wrap around
		if Game.selectedSortIndex > #DatabaseMixes[Game.selectedMixIndex].SortingMethods then
			Game.selectedSortIndex = #DatabaseMixes[Game.selectedMixIndex].SortingMethods
		end
	else
		-- wraps around
		if Game.selectedSortIndex > #DatabaseMixes[Game.selectedMixIndex].SortingMethods then Game.selectedSortIndex = 1 end
	end

	Game.selectedSortName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].SortName
	Game.selectedSortTotalSongs = #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs

end

function State_03SelectSort.CenterPressed()

	Game.selectedSongIndex = 1
	Game.selectedSongName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].SongTitle
	Game.selectedSongArrayOfCharts = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts

	if Game.selectedSortName == "Full Display Mode" then
		-- means we will load a "multiple-chart songwheel"
		Game.state = 41
	else
		-- this means we will load a "single-chart songwheel"
		Game.selectedChartIndex = 1
		Game.selectedChartName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts[Game.selectedChartIndex]
		Game.selectedChartDifficultyName = FetchChartDifficultyName(Game.selectedSongName, Game.selectedChartName)
		Game.selectedChartRecommendedSpeed = FetchRecommendedSpeed(Game.selectedPlayerName, Game.selectedSongName, Game.selectedChartName)
		Game.selectedChartRecommendedAV = FetchRecommendedAV(Game.selectedPlayerName, Game.selectedSongName, Game.selectedChartName)
		Game.state = 42
	end

end

function State_03SelectSort.BackPressed()

	Game.state = 2

	Game.selectedSortIndex = 0
	Game.selectedSortName = ""
	Game.selectedSortTotalSongs = 0

end









































-- DRAWING

function State_03SelectSort.Drawing()
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
		Text = Game.selectedPlayerName.."/"..Game.selectedMixName.."/",
		XPos = drawingX+24,
		YPos = drawingY-2,
		ColorName = "yellow",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "------------ 03. SELECT A SORTING ORDER -------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	for i=1,#DatabaseMixes[Game.selectedMixIndex].SortingMethods,1 do
		meckx_print({
			Text = (Game.selectedSortIndex == i) and "> "..DatabaseMixes[Game.selectedMixIndex].SortingMethods[i].SortName or DatabaseMixes[Game.selectedMixIndex].SortingMethods[i].SortName,
			XPos = (Game.selectedSortIndex == i) and drawingX or drawingX+24,
			YPos = drawingY,
			ColorName = (Game.selectedSortIndex == i) and "white" or "darkGray",
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize
	end

	if #DatabaseMixes[Game.selectedMixIndex].CheatCodes > 0 then

		drawingY = 670 - (#DatabaseMixes[Game.selectedMixIndex].CheatCodes * 42)

		meckx_print({
			Text = "-------------------- CHEAT CODES --------------------",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "white",
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize

		for i=1,#DatabaseMixes[Game.selectedMixIndex].CheatCodes,1 do
			meckx_print({
				Text = DatabaseMixes[Game.selectedMixIndex].CheatCodes[i],
				XPos = drawingX+24,
				YPos = drawingY,
				ColorName = "lightGray",
				FontStyle = ClassicConsole_48,
			})
			drawingY = drawingY + linebreakSize
		end

	end

end











































return State_03SelectSort