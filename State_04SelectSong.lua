local State_04SelectSong = {}

-- INPUT HANDLING

function State_04SelectSong.UpPressed()

	Game.selectedSongIndex = Game.selectedSongIndex - 1
	if Game.selectedSongIndex == 0 then Game.selectedSongIndex = #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs end
	Game.selectedSongName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].SongTitle
	Game.selectedSongArrayOfCharts = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts

	--love.audio.play(SfxMove:clone())

end

function State_04SelectSong.DownPressed()

	Game.selectedSongIndex = Game.selectedSongIndex + 1
	if Game.selectedSongIndex > #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs then Game.selectedSongIndex = 1 end
	Game.selectedSongName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].SongTitle
	Game.selectedSongArrayOfCharts = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts

	--love.audio.play(SfxMove:clone())

end

function State_04SelectSong.CenterPressed()

	Game.selectedChartIndex = 1
	Game.selectedChartName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts[Game.selectedChartIndex]
	Game.selectedChartDifficulty = DatabaseCharts.FetchChartDifficulty(Game.selectedSongName, Game.selectedChartName)

	Game.state = 5

	--love.audio.play(SfxCenter:clone())

end

function State_04SelectSong.BackPressed()

	Game.state = 3

	Game.selectedSongIndex = 0
	Game.selectedSongName = ""
	Game.selectedSongArrayOfCharts = {}

	--love.audio.play(SfxBack:clone())

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

	meckx_print({
		Text = "----------------- 04. SELECT A SONG -----------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize
	
	local numberOfDisplayedCharts = (#Game.selectedSongArrayOfCharts < 11) and #Game.selectedSongArrayOfCharts or 10
	for offset = -2, (11 - numberOfDisplayedCharts) do
		local index = ((Game.selectedSongIndex + offset - 1) % #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs) + 1
		local songTitle = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[index].SongTitle
		local indexFormatted = string.format("%04d", index)
		
		if offset == 0 then
			-- let's grab the currently hovered song's { array of charts }
			--Game.selectedSongArrayOfCharts = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[index].Charts
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

	-- drawing charts
	for j=1,#Game.selectedSongArrayOfCharts,1 do
		
		local songToInput = Game.selectedSongName
		local chartToInput = Game.selectedSongArrayOfCharts[j]

		local text = DatabaseCharts.FetchChartDifficulty(songToInput, chartToInput).." - "..string.format("%-15s", chartToInput).." - "

		meckx_print({
			Text = text,
			XPos = drawingX+24,
			YPos = drawingY,
			ColorName = DatabaseCharts.FetchChartColor(songToInput, chartToInput),
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize
	end

end











































return State_04SelectSong