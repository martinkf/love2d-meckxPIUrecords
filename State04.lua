local State04 = {}

-- INPUT HANDLING

function State04.UpPressed()

	Game.selectedSongIndex = Game.selectedSongIndex - 1
	if Game.selectedSongIndex == 0 then Game.selectedSongIndex = #MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs end
	Game.selectedSongName = MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].SongTitle
	love.audio.play(SfxMove:clone())

end

function State04.DownPressed()

	Game.selectedSongIndex = Game.selectedSongIndex + 1
	if Game.selectedSongIndex > #MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs then Game.selectedSongIndex = 1 end
	Game.selectedSongName = MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].SongTitle
	love.audio.play(SfxMove:clone())

end

function State04.CenterPressed()

	--

end

function State04.BackPressed()

	Game.state = 3
	Game.selectedSongIndex = 1
	Game.selectedSongName = MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].SongTitle
	love.audio.play(SfxBack:clone())

end









































-- DRAWING

function State04.Drawing()
	local drawingX = 6
	local drawingY = 2
	local linebreakSize = 42

	-- background
	meckx_clearScreen({
		ColorName = "darkestGray",
	})
	meckx_rect({
		XPos = 0,
		YPos = 0,
		Width = 1280,
		Height = 47,
		ColorName = "red",
		RectStyle = "fill",
	})

	-- contents
	meckx_print({
		Text = Game.selectedPlayerName.."/"..Game.selectedMixName.."/"..Game.selectedSortName,
		XPos = drawingX,
		YPos = drawingY-4,
		ColorName = "yellow",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "----------------- 04. SELECT A SONG -----------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	for offset = -2, 7 do
		local index = ((Game.selectedSongIndex + offset - 1) % #MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs) + 1
		local songTitle = MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[index].SongTitle
		local indexFormatted = string.format("%04d", index)
		
		if offset == 0 then
			-- let's grab the currently hovered song's { array of charts }
			Game.selectedSongArrayOfCharts = MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[index].Charts
			-- let's force this variable to update here because i suck at programming
			Game.selectedSongName = MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].SongTitle
		end
		
		meckx_print({
			Text = (offset == 0) and "> "..indexFormatted..". "..songTitle.." <" or indexFormatted..". "..songTitle,
			XPos = (offset == 0) and drawingX or drawingX+24,
			YPos = drawingY,
			ColorName = (offset == 0) and "white" or "darkGray",
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize
	end

	meckx_print({
		Text = "---------------------- CHARTS -----------------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize
	drawingY = drawingY + linebreakSize

	-- drawing chart separators
	drawingX = 6
	drawingX = drawingX + 24
	for j=1,7,1 do
		meckx_print({
			Text = "     |",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "white",
			FontStyle = ClassicConsole_48,
		})
		drawingX = drawingX + (24*7)
	end

	-- drawing charts
	drawingX = 6
	drawingX = drawingX + 24
	for j=1,#Game.selectedSongArrayOfCharts,1 do
		--local text = Game.selectedSongArrayOfCharts[j]
		local songToInput = Game.selectedSongName
		local chartToInput = Game.selectedSongArrayOfCharts[j]
		local text = ChartDatabase.FetchChartDifficulty(songToInput, chartToInput)
		meckx_print({
			Text = text,
			XPos = drawingX,
			YPos = drawingY,
			ColorName = ChartDatabase.FetchChartColor(songToInput, chartToInput),
			FontStyle = ClassicConsole_48,
		})
		drawingX = drawingX + (24*7)
	end

end











































return State04