local State_02SelectMix = {}

-- INPUT HANDLING

function State_02SelectMix.UpPressed()

	Game.selectedMixIndex = Game.selectedMixIndex - 1
	if Game.selectedMixIndex == 0 then Game.selectedMixIndex = #DatabaseMixes end
	Game.selectedMixName = DatabaseMixes[Game.selectedMixIndex].MixName
	--love.audio.play(SfxMove:clone())

end

function State_02SelectMix.DownPressed()

	Game.selectedMixIndex = Game.selectedMixIndex + 1
	if Game.selectedMixIndex > #DatabaseMixes then Game.selectedMixIndex = 1 end
	Game.selectedMixName = DatabaseMixes[Game.selectedMixIndex].MixName
	--love.audio.play(SfxMove:clone())

end

function State_02SelectMix.CenterPressed()

	Game.selectedSortIndex = 1
	Game.selectedSortName = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].SortName

	Game.state = 3

	--love.audio.play(SfxCenter:clone())

end

function State_02SelectMix.BackPressed()

	Game.state = 1

	Game.selectedMixIndex = 0
	Game.selectedMixName = ""

	--love.audio.play(SfxBack:clone())

end









































-- DRAWING

function State_02SelectMix.Drawing()
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
		Text = Game.selectedPlayerName.."/",
		XPos = drawingX+24,
		YPos = drawingY-2,
		ColorName = "yellow",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "--------------- 02. SELECT A PIU MIX ----------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	for i=1,#DatabaseMixes,1 do
		meckx_print({
			Text = (Game.selectedMixIndex == i) and "> "..DatabaseMixes[i].MixName.." <" or DatabaseMixes[i].MixName,
			XPos = (Game.selectedMixIndex == i) and drawingX or drawingX+24,
			YPos = drawingY,
			ColorName = (Game.selectedMixIndex == i) and "white" or "darkGray",
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize
	end

end











































return State_02SelectMix