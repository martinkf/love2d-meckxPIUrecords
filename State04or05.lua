local State04or05 = {}

-- INPUT HANDLING

function State04or05.UpPressedState04()

	Game.selectedSongIndex = Game.selectedSongIndex - 1
	if Game.selectedSongIndex == 0 then Game.selectedSongIndex = #MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs end
	Game.selectedSongName = MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].SongTitle

	--love.audio.play(SfxMove:clone())

end

function State04or05.DownPressedState04()

	Game.selectedSongIndex = Game.selectedSongIndex + 1
	if Game.selectedSongIndex > #MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs then Game.selectedSongIndex = 1 end
	Game.selectedSongName = MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].SongTitle

	--love.audio.play(SfxMove:clone())

end

function State04or05.CenterPressedState04()

	Game.selectedChartIndex = 1
	Game.selectedChartName = MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts[Game.selectedChartIndex]
	Game.selectedChartDifficulty = ChartDatabase.FetchChartDifficulty(Game.selectedSongName, Game.selectedChartName)

	Game.state = 5

	--love.audio.play(SfxCenter:clone())

end

function State04or05.BackPressedState04()

	Game.state = 3

	Game.selectedSongIndex = 0
	Game.selectedSongName = ""
	Game.selectedSongArrayOfCharts = {}

	--love.audio.play(SfxBack:clone())

end



function State04or05.UpPressedState05()

	Game.selectedChartIndex = Game.selectedChartIndex - 1
	if Game.selectedChartIndex == 0 then Game.selectedChartIndex = #MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts end
	Game.selectedChartName = MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts[Game.selectedChartIndex]
	Game.selectedChartDifficulty = ChartDatabase.FetchChartDifficulty(Game.selectedSongName, Game.selectedChartName)
	--love.audio.play(SfxMove:clone())

end

function State04or05.DownPressedState05()

	Game.selectedChartIndex = Game.selectedChartIndex + 1
	if Game.selectedChartIndex > #MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts then Game.selectedChartIndex = 1 end
	Game.selectedChartName = MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts[Game.selectedChartIndex]
	Game.selectedChartDifficulty = ChartDatabase.FetchChartDifficulty(Game.selectedSongName, Game.selectedChartName)
	--love.audio.play(SfxMove:clone())

end

function State04or05.BackPressedState05()

	Game.state = 4

	Game.selectedChartIndex = 0
	Game.selectedChartName = ""
	Game.selectedChartDifficulty = ""

	--love.audio.play(SfxBack:clone())

end









































-- DRAWING

function State04or05.Drawing()
	local drawingX = 6
	local drawingY = 6
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
		XPos = drawingX,
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

	local offsetSelectedSong = (Game.selectedSortName == "Full Display Mode") and -1 or -2
	local numberOfDisplaySongs = (Game.selectedSortName == "Full Display Mode") and 2 or 10
	for offset = offsetSelectedSong, numberOfDisplaySongs do
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

	-- drawing charts
	for j=1,#Game.selectedSongArrayOfCharts,1 do
		--local text = Game.selectedSongArrayOfCharts[j]
		local songToInput = Game.selectedSongName
		local chartToInput = Game.selectedSongArrayOfCharts[j]
		local text = ChartDatabase.FetchChartDifficulty(songToInput, chartToInput)
		meckx_print({
			Text = text,
			XPos = drawingX+24,
			YPos = drawingY,
			ColorName = ChartDatabase.FetchChartColor(songToInput, chartToInput),
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize
	end

end











































return State04or05