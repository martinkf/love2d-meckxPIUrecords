local Debug_01Variables = {}

function Debug_01Variables.Drawing()
	local drawingX = 620
	local drawingY = 220
	local linebreakSize = 26

	-- background
	meckx_rect({
		XPos = drawingX - 4,
		YPos = drawingY - 6,
		Width = 1280 - drawingX,
		Height = 720 - drawingY,
		ColorName = "blue",
		RectStyle = "fill",
	})

	-- contents
	meckx_print({
		Text = "Tee = "..Tee,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "Game.state = "..Game.state,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "Game.selectedPlayerIndex = "..Game.selectedPlayerIndex,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "Game.selectedPlayerName = "..Game.selectedPlayerName,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "Game.selectedMixIndex = "..Game.selectedMixIndex,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "Game.selectedMixName = "..Game.selectedMixName,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "Game.selectedSortIndex = "..Game.selectedSortIndex,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "Game.selectedSortName = "..Game.selectedSortName,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "Game.selectedSongIndex = "..Game.selectedSongIndex,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "Game.selectedSongName = "..Game.selectedSongName,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "#Game.selectedSongArrayOfCharts = "..#Game.selectedSongArrayOfCharts,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = (Game.selectedSongArrayOfCharts[1]) and "Game.selectedSongArrayOfCharts[1] = "..Game.selectedSongArrayOfCharts[1] or "nope",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

end

return Debug_01Variables