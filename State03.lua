local State03 = {}

-- INPUT HANDLING

function State03.UpPressed()

	Game.selectedSortIndex = Game.selectedSortIndex - 1
	if Game.selectedSortIndex == 0 then Game.selectedSortIndex = #MixDatabase[Game.selectedMixIndex].SortingMethods end
	Game.selectedSortName = MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].SortName
	--love.audio.play(SfxMove:clone())

end

function State03.DownPressed()

	Game.selectedSortIndex = Game.selectedSortIndex + 1
	if Game.selectedSortIndex > #MixDatabase[Game.selectedMixIndex].SortingMethods then Game.selectedSortIndex = 1 end
	Game.selectedSortName = MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].SortName
	--love.audio.play(SfxMove:clone())

end

function State03.CenterPressed()

	Game.selectedSongIndex = 1
	Game.selectedSongName = MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[Game.selectedSongIndex].SongTitle

	Game.state = 4

	--love.audio.play(SfxCenter:clone())

end

function State03.BackPressed()

	Game.state = 2

	Game.selectedSortIndex = 0
	Game.selectedSortName = ""

	--love.audio.play(SfxBack:clone())

end









































-- DRAWING

function State03.Drawing()
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
		Text = Game.selectedPlayerName.."/"..Game.selectedMixName.."/",
		XPos = drawingX,
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

	for i=1,#MixDatabase[Game.selectedMixIndex].SortingMethods,1 do
		meckx_print({
			Text = (Game.selectedSortIndex == i) and "> "..MixDatabase[Game.selectedMixIndex].SortingMethods[i].SortName.." <" or MixDatabase[Game.selectedMixIndex].SortingMethods[i].SortName,
			XPos = (Game.selectedSortIndex == i) and drawingX or drawingX+24,
			YPos = drawingY,
			ColorName = (Game.selectedSortIndex == i) and "white" or "darkGray",
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize
	end

end











































return State03