local State01 = {}

-- INPUT HANDLING

function State01.UpPressed()

	Game.selectedPlayerIndex = Game.selectedPlayerIndex - 1
	if Game.selectedPlayerIndex == 0 then Game.selectedPlayerIndex = #PlayerDatabase end
	Game.selectedPlayerName = PlayerDatabase[Game.selectedPlayerIndex].PlayerName
	love.audio.play(SfxMove:clone())

end

function State01.DownPressed()

	Game.selectedPlayerIndex = Game.selectedPlayerIndex + 1
	if Game.selectedPlayerIndex > #PlayerDatabase then Game.selectedPlayerIndex = 1 end
	Game.selectedPlayerName = PlayerDatabase[Game.selectedPlayerIndex].PlayerName
	love.audio.play(SfxMove:clone())

end

function State01.CenterPressed()

	Game.state = 2
	love.audio.play(SfxCenter:clone())

end

function State01.BackPressed()

	--

end









































-- DRAWING

function State01.Drawing()
	local drawingX = 6
	local drawingY = 2
	local linebreakSize = 42

	-- backgrounds
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
		Text = "../",
		XPos = drawingX,
		YPos = drawingY-4,
		ColorName = "yellow",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "------------ 01. CHOOSE A PLAYER PROFILE ------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	for i=1,#PlayerDatabase,1 do
		meckx_print({
			Text = (Game.selectedPlayerIndex == i) and "> "..PlayerDatabase[i].PlayerName.." <" or PlayerDatabase[i].PlayerName,
			XPos = (Game.selectedPlayerIndex == i) and drawingX or drawingX+24,
			YPos = drawingY,
			ColorName = (Game.selectedPlayerIndex == i) and "white" or "darkGray",
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize
	end

end











































return State01