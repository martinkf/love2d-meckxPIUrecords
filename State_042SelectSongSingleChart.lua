local State_042SelectSongSingleChart = {}

-- INPUT HANDLING

function State_042SelectSongSingleChart.UpPressed()

	if Game.infographic == 1 then
		Game.infographic = 0
	else
		Game.selectedSongIndex = Game.selectedSongIndex - 1
		-- wraps around
		if Game.selectedSongIndex == 0 then
			Game.selectedSongIndex = #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs
		end
		Game.selectedSongName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].SongTitle
		Game.selectedSongArrayOfCharts = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts

		Game.selectedChartIndex = 1
		Game.selectedChartName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts[Game.selectedChartIndex]
		Game.selectedChartDifficultyName = FetchChartDifficultyName(Game.selectedSongName, Game.selectedChartName)
		Game.selectedChartRecommendedSpeed = FetchRecommendedSpeed(Game.selectedPlayerName, Game.selectedSongName, Game.selectedChartName)
		Game.selectedChartRecommendedAV = FetchRecommendedAV(Game.selectedPlayerName, Game.selectedSongName, Game.selectedChartName)
	end

end

function State_042SelectSongSingleChart.DownPressed()

	if Game.infographic == 1 then
		Game.infographic = 0
	else
		Game.selectedSongIndex = Game.selectedSongIndex + 1
		-- wraps around
		if Game.selectedSongIndex > #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs then
			Game.selectedSongIndex = 1
		end
		Game.selectedSongName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].SongTitle
		Game.selectedSongArrayOfCharts = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts

		Game.selectedChartIndex = 1
		Game.selectedChartName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts[Game.selectedChartIndex]
		Game.selectedChartDifficultyName = FetchChartDifficultyName(Game.selectedSongName, Game.selectedChartName)
		Game.selectedChartRecommendedSpeed = FetchRecommendedSpeed(Game.selectedPlayerName, Game.selectedSongName, Game.selectedChartName)
		Game.selectedChartRecommendedAV = FetchRecommendedAV(Game.selectedPlayerName, Game.selectedSongName, Game.selectedChartName)
	end

end

function State_042SelectSongSingleChart.CenterPressed()

	if Game.infographic == 1 then
		Game.infographic = 0
	else
		Game.selectedChartIndex = 1
		Game.selectedChartName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts[Game.selectedChartIndex]
		Game.selectedChartDifficultyName = FetchChartDifficultyName(Game.selectedSongName, Game.selectedChartName)
		Game.selectedChartRecommendedSpeed = FetchRecommendedSpeed(Game.selectedPlayerName, Game.selectedSongName, Game.selectedChartName)
		Game.selectedChartRecommendedAV = FetchRecommendedAV(Game.selectedPlayerName, Game.selectedSongName, Game.selectedChartName)

		Game.infographic = 0
		Game.state = 5

		-- since it's a single-chart song wheel, skips to state 6 instead of going through 5
		Game.selectedChartOptIndex = 1
		Game.selectedChartOptName = "Add new record"
		Game.state = 6
	end

end

function State_042SelectSongSingleChart.BackPressed()

	if Game.infographic == 1 then
		Game.infographic = 0
	else
		Game.state = 3

		Game.selectedSongIndex = 0
		Game.selectedSongName = ""
		Game.selectedSongArrayOfCharts = {}

		Game.selectedChartIndex = 0
		Game.selectedChartName = ""
		Game.selectedChartDifficultyName = ""
		Game.selectedChartRecommendedSpeed = ""
		Game.selectedChartRecommendedAV = ""
	end

end













































-- DRAWING

function State_042SelectSongSingleChart.Drawing()
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
		Text = Game.selectedPlayerName.."/"..Game.selectedMixName.."/"..Game.selectedSortName,
		XPos = drawingX+24,
		YPos = drawingY-2,
		ColorName = "yellow",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize




	-- drawing songs
	meckx_print({
		Text = "----------------- 04. SELECT A SONG -----------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize



	--the wheel (the wrapping around, actually) will look different depending on Game.selectedSortTotalSongs
	if Game.selectedSortTotalSongs < 15 then
		for index = 1, Game.selectedSortTotalSongs do
			local songTitle = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[index].SongTitle
			local indexFormatted = string.format("%03d", index)
			local originFormatted = DatabaseDetails.FetchSongOriginShort(songTitle)

			local leftSideText
			if Game.songListModeL == 0 then
				leftSideText = songTitle
			elseif Game.songListModeL == 1 then
				leftSideText = "["..originFormatted.."] "..indexFormatted..". "..songTitle
			end
			
			local dividerInteger = 36
			local outputLeftSideText = string.sub(leftSideText, 1, dividerInteger)

			meckx_print({
				Text = (Game.selectedSongIndex == index) and "> "..outputLeftSideText or outputLeftSideText,
				XPos = (Game.selectedSongIndex == index) and drawingX or drawingX+24,
				YPos = drawingY,
				ColorName = (Game.selectedSongIndex == index) and DatabaseDetails.FetchSongColorEnabled(songTitle) or DatabaseDetails.FetchSongColorDisabled(songTitle),
				FontStyle = ClassicConsole_48,
			})


			local chartName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[index].Charts[1]
			local chartDifficulty = FetchChartDifficultyName(songTitle, chartName)
			local recommendedSpeed = FetchRecommendedSpeed(Game.selectedPlayerName, songTitle, chartName)
			local highScoreObject = FetchHighScore(Game.selectedPlayerName, songTitle, chartName)

			local outputRightSideText
			local actualColor
			if highScoreObject then
				outputRightSideText = "[" .. chartDifficulty .. "] " .. highScoreObject.DisplayAccuracy
				actualColor = FetchHighScoreColor(Game.selectedPlayerName, songTitle, chartName)
			else
				outputRightSideText = "[" .. chartDifficulty .. "] " .. "-"
				actualColor = "lightGray"
			end
			
			meckx_print({
				Text = outputRightSideText,
				XPos = drawingX+((dividerInteger+3)*24),
				YPos = drawingY,
				ColorName = actualColor,
				FontStyle = ClassicConsole_48,
			})

			drawingY = drawingY + linebreakSize
		end
	else
		for offset = -2, 12 do
			local index = ((Game.selectedSongIndex + offset - 1) % #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs) + 1
			local songTitle = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[index].SongTitle
			local indexFormatted = string.format("%03d", index)
			local originFormatted = DatabaseDetails.FetchSongOriginShort(songTitle)

			local leftSideText
			if Game.songListModeL == 0 then
				leftSideText = songTitle
			elseif Game.songListModeL == 1 then
				leftSideText = "["..originFormatted.."] "..indexFormatted..". "..songTitle
			end
			
			local dividerInteger = 36
			local outputLeftSideText = string.sub(leftSideText, 1, dividerInteger)

			meckx_print({
				Text = (offset == 0) and "> "..outputLeftSideText or outputLeftSideText,
				XPos = (offset == 0) and drawingX or drawingX+24,
				YPos = drawingY,
				ColorName = (offset == 0) and DatabaseDetails.FetchSongColorEnabled(songTitle) or DatabaseDetails.FetchSongColorDisabled(songTitle),
				FontStyle = ClassicConsole_48,
			})


			local chartName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[index].Charts[1]
			local chartDifficulty = FetchChartDifficultyName(songTitle, chartName)
			local recommendedSpeed = FetchRecommendedSpeed(Game.selectedPlayerName, songTitle, chartName)
			local highScoreObject = FetchHighScore(Game.selectedPlayerName, songTitle, chartName)

			local outputRightSideText
			local actualColor
			if highScoreObject then
				outputRightSideText = "[" .. chartDifficulty .. "] " .. highScoreObject.DisplayAccuracy
				actualColor = FetchHighScoreColor(Game.selectedPlayerName, songTitle, chartName)
			else
				outputRightSideText = "[" .. chartDifficulty .. "] " .. "-"
				actualColor = "lightGray"
			end
			
			meckx_print({
				Text = outputRightSideText,
				XPos = drawingX+((dividerInteger+2)*24),
				YPos = drawingY,
				ColorName = actualColor,
				FontStyle = ClassicConsole_48,
			})

			drawingY = drawingY + linebreakSize
		end
	end

end











































return State_042SelectSongSingleChart