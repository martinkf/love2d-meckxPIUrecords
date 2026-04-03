local State02 = {}

-- INPUT HANDLING

function State02.UpPressed()

	Game.selectedMixIndex = Game.selectedMixIndex - 1
	if Game.selectedMixIndex == 0 then Game.selectedMixIndex = #MixDatabase end
	Game.selectedMixName = MixDatabase[Game.selectedMixIndex].MixName
	--love.audio.play(SfxMove:clone())

end

function State02.DownPressed()

	Game.selectedMixIndex = Game.selectedMixIndex + 1
	if Game.selectedMixIndex > #MixDatabase then Game.selectedMixIndex = 1 end
	Game.selectedMixName = MixDatabase[Game.selectedMixIndex].MixName
	--love.audio.play(SfxMove:clone())

end

function State02.CenterPressed()

	Game.selectedSortIndex = 1
	Game.selectedSortName = MixDatabase[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].SortName

	Game.state = 3

	--love.audio.play(SfxCenter:clone())

end

function State02.BackPressed()

	Game.state = 1

	Game.selectedMixIndex = 0
	Game.selectedMixName = ""

	--love.audio.play(SfxBack:clone())

end









































-- DRAWING

function State02.Drawing()
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
		Text = Game.selectedPlayerName.."/",
		XPos = drawingX,
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

	for i=1,#MixDatabase,1 do
		meckx_print({
			Text = (Game.selectedMixIndex == i) and "> "..MixDatabase[i].MixName.." <" or MixDatabase[i].MixName,
			XPos = (Game.selectedMixIndex == i) and drawingX or drawingX+24,
			YPos = drawingY,
			ColorName = (Game.selectedMixIndex == i) and "white" or "darkGray",
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize
	end

end











































return State02