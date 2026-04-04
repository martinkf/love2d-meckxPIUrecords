local State_01SelectPlayer = {}

-- INPUT HANDLING

function State_01SelectPlayer.UpPressed()

	Game.selectedPlayerIndex = Game.selectedPlayerIndex - 1
	if true then
		-- doesn't wrap around
		if Game.selectedPlayerIndex == 0 then Game.selectedPlayerIndex = 1 end
	else
		-- wraps around
		if Game.selectedPlayerIndex == 0 then Game.selectedPlayerIndex = #DatabasePlayers end
	end

	Game.selectedPlayerName = DatabasePlayers[Game.selectedPlayerIndex].PlayerName

	--love.audio.play(SfxMove:clone())

end

function State_01SelectPlayer.DownPressed()

	Game.selectedPlayerIndex = Game.selectedPlayerIndex + 1
	if true then
		-- doesnt' wrap around
		if Game.selectedPlayerIndex > #DatabasePlayers then Game.selectedPlayerIndex = #DatabasePlayers end
	else
		-- wraps around
		if Game.selectedPlayerIndex > #DatabasePlayers then Game.selectedPlayerIndex = 1 end
	end

	Game.selectedPlayerName = DatabasePlayers[Game.selectedPlayerIndex].PlayerName

	--love.audio.play(SfxMove:clone())

end

function State_01SelectPlayer.CenterPressed()

	Game.selectedMixIndex = 1
	Game.selectedMixName = DatabaseMixes[Game.selectedMixIndex].MixName

	Game.state = 2

	--love.audio.play(SfxCenter:clone())

end









































-- DRAWING

function State_01SelectPlayer.Drawing()
	local drawingX = 6
	local drawingY = Game.baseDrawingY
	local linebreakSize = 42

	-- backgrounds
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
		Text = "../",
		XPos = drawingX+24,
		YPos = drawingY-2,
		ColorName = "yellow",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "------------ 01. SELECT A PLAYER PROFILE ------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	for i=1,#DatabasePlayers,1 do
		meckx_print({
			Text = (Game.selectedPlayerIndex == i) and "> "..DatabasePlayers[i].PlayerName.." <" or DatabasePlayers[i].PlayerName,
			XPos = (Game.selectedPlayerIndex == i) and drawingX or drawingX+24,
			YPos = drawingY,
			ColorName = (Game.selectedPlayerIndex == i) and "white" or "darkGray",
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize
	end

end











































return State_01SelectPlayer