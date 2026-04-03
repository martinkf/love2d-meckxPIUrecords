local State_03SelectSort = {}

-- INPUT HANDLING

function State_03SelectSort.UpPressed()

	Game.selectedSortIndex = Game.selectedSortIndex - 1
	if Game.selectedSortIndex == 0 then Game.selectedSortIndex = #DatabaseMixes[Game.selectedMixIndex].SortingMethods end
	Game.selectedSortName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].SortName
	--love.audio.play(SfxMove:clone())

end

function State_03SelectSort.DownPressed()

	Game.selectedSortIndex = Game.selectedSortIndex + 1
	if Game.selectedSortIndex > #DatabaseMixes[Game.selectedMixIndex].SortingMethods then Game.selectedSortIndex = 1 end
	Game.selectedSortName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].SortName
	--love.audio.play(SfxMove:clone())

end

function State_03SelectSort.CenterPressed()

	Game.selectedSongIndex = 1
	Game.selectedSongName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].SongTitle
	Game.selectedSongArrayOfCharts = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].Charts

	Game.state = 4

	--love.audio.play(SfxCenter:clone())

end

function State_03SelectSort.BackPressed()

	Game.state = 2

	Game.selectedSortIndex = 0
	Game.selectedSortName = ""

	--love.audio.play(SfxBack:clone())

end









































-- DRAWING

function State_03SelectSort.Drawing()
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
			Text = (Game.selectedSortIndex == i) and "> "..DatabaseMixes[Game.selectedMixIndex].SortingMethods[i].SortName.." <" or DatabaseMixes[Game.selectedMixIndex].SortingMethods[i].SortName,
			XPos = (Game.selectedSortIndex == i) and drawingX or drawingX+24,
			YPos = drawingY,
			ColorName = (Game.selectedSortIndex == i) and "white" or "darkGray",
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize
	end

end











































return State_03SelectSort