local State_04SelectSong = {}

-- INPUT HANDLING

function State_04SelectSong.UpPressed()

	if Game.infographic == 1 then
		Game.infographic = 0
	else
		Game.selectedSongIndex = Game.selectedSongIndex - 1
		if Game.selectedSortName == "Single Progressive" or
		Game.selectedSortName == "Half-Double Progressive" or
		Game.selectedSortName == "Double Progressive" or
		Game.selectedSortName == "Swan Charts" then
			-- doesnt wrap around
			if Game.selectedSongIndex == 0 then
				Game.selectedSongIndex = 1 
			end
		else
			-- wraps around
			if Game.selectedSongIndex == 0 then
				Game.selectedSongIndex = #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs
			end
		end
		Game.selectedSongName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].SongTitle
		Game.selectedSongArrayOfCharts = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts

	end

end

function State_04SelectSong.DownPressed()

	if Game.infographic == 1 then
		Game.infographic = 0
	else
		Game.selectedSongIndex = Game.selectedSongIndex + 1
		if Game.selectedSortName == "Single Progressive" or
		Game.selectedSortName == "Half-Double Progressive" or
		Game.selectedSortName == "Double Progressive" or
		Game.selectedSortName == "Swan Charts" then
			-- doesnt wrap around
			if Game.selectedSongIndex > #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs then
				Game.selectedSongIndex = #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs
			end
		else
			-- wraps around
			if Game.selectedSongIndex > #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs then
				Game.selectedSongIndex = 1
			end
		end

		Game.selectedSongName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].SongTitle
		Game.selectedSongArrayOfCharts = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts

	end

end

function State_04SelectSong.CenterPressed()

	if Game.infographic == 1 then
		Game.infographic = 0
	else
		Game.selectedChartIndex = 1
		Game.selectedChartName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts[Game.selectedChartIndex]
		Game.selectedChartDifficultyName = DatabaseDetails.FetchChartDifficultyName(Game.selectedSongName, Game.selectedChartName)

		Game.infographic = 0
		Game.state = 5
	end

end

function State_04SelectSong.BackPressed()

	if Game.infographic == 1 then
		Game.infographic = 0
	else
		Game.state = 3

		Game.selectedSongIndex = 0
		Game.selectedSongName = ""
		Game.selectedSongArrayOfCharts = {}

	end

end













































-- DRAWING

function State_04SelectSong.Drawing()
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

	if Game.selectedSortName == "Single Progressive" or
	Game.selectedSortName == "Half-Double Progressive" or
	Game.selectedSortName == "Double Progressive" or
	Game.selectedSortName == "Swan Charts" then
		-- song list doesnt wrap around
		local numberOfDisplayedCharts = (#Game.selectedSongArrayOfCharts < 11) and #Game.selectedSongArrayOfCharts or 10
		for offset = -2, (11 - numberOfDisplayedCharts) do
			local index = Game.selectedSongIndex + offset
			if index < 1 then
				meckx_print({
					Text = "",
					XPos = drawingX+24,
					YPos = drawingY,
					ColorName = "white",
					FontStyle = ClassicConsole_48,
				})
				drawingY = drawingY + linebreakSize
			elseif index < (#DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs + 1) then
				local songTitle = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[index].SongTitle
				local indexFormatted = string.format("%04d", index)
				local originFormatted = DatabaseDetails.FetchSongOriginShort(songTitle)

				local text = "["..originFormatted.."] "..indexFormatted..". "..songTitle

				meckx_print({
					Text = (offset == 0) and "> "..text.." <" or text,
					XPos = (offset == 0) and drawingX or drawingX+24,
					YPos = drawingY,
					ColorName = (offset == 0) and DatabaseDetails.FetchSongColorEnabled(songTitle) or DatabaseDetails.FetchSongColorDisabled(songTitle),
					FontStyle = ClassicConsole_48,
				})
				drawingY = drawingY + linebreakSize
			else
				meckx_print({
					Text = "",
					XPos = drawingX+24,
					YPos = drawingY,
					ColorName = "white",
					FontStyle = ClassicConsole_48,
				})
				drawingY = drawingY + linebreakSize
			end

		end
	else
		-- song list loops around
		local numberOfDisplayedCharts = (#Game.selectedSongArrayOfCharts < 11) and #Game.selectedSongArrayOfCharts or 10
		for offset = -2, (11 - numberOfDisplayedCharts) do
			local index = ((Game.selectedSongIndex + offset - 1) % #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs) + 1
			local songTitle = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[index].SongTitle
			local indexFormatted = string.format("%04d", index)
			local originFormatted = DatabaseDetails.FetchSongOriginShort(songTitle)

			local text = "["..originFormatted.."] "..indexFormatted..". "..songTitle

			meckx_print({
				Text = (offset == 0) and "> "..text.." <" or text,
				XPos = (offset == 0) and drawingX or drawingX+24,
				YPos = drawingY,
				ColorName = (offset == 0) and DatabaseDetails.FetchSongColorEnabled(songTitle) or DatabaseDetails.FetchSongColorDisabled(songTitle),
				FontStyle = ClassicConsole_48,
			})
			drawingY = drawingY + linebreakSize
		end
	end





	-- drawing charts
	meckx_print({
		Text = "---------------------- CHARTS -----------------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	local tempdrawingY = drawingY

	for j=1,#Game.selectedSongArrayOfCharts,1 do

		local songToInput = Game.selectedSongName
		local chartToInput = Game.selectedSongArrayOfCharts[j]

		local text = DatabaseDetails.FetchChartDifficultyName(songToInput, chartToInput).."·"..chartToInput

		meckx_print({
			Text = text,
			XPos = drawingX+24,
			YPos = drawingY,
			ColorName = DatabaseDetails.FetchChartColorEnabled(songToInput, chartToInput),
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize
	end

	--displaying top record information
	drawingY = tempdrawingY
	for j=1,#Game.selectedSongArrayOfCharts,1 do
		local playerPlaying = Game.selectedPlayerName
		local songToInput = Game.selectedSongName
		local chartToInput = Game.selectedSongArrayOfCharts[j]

		local highScoreObject = FetchHighScore(playerPlaying, songToInput, chartToInput)

		local actualText
		local actualColor
		if highScoreObject then actualText = highScoreObject.Stars else actualText = "" end
		if highScoreObject then actualColor = "meckx_06Red_light" else actualColor = "white" end

		meckx_print({
			Text = actualText,
			XPos = drawingX+(29*24),
			YPos = drawingY,
			ColorName = actualColor,
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize
	end
	
end











































return State_04SelectSong