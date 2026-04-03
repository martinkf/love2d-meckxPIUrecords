local Debug_01Variables = {}

function Debug_01Variables.Drawing()
	local drawingX = 650
	local drawingY = 100
	local linebreakSize = 26

	-- background
	meckx_rect({
		XPos = drawingX - 4,
		YPos = drawingY - 6,
		Width = 1280 - drawingX,
		Height = 720 - drawingY,
		ColorName = "blue",
		RectStyle = "fill",
		Transparency = 0.25,
	})

	-- contents
	meckx_print({
		Text = "love._os = "..love._os,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize
	drawingY = drawingY + (0.5 * linebreakSize)

	meckx_print({
		Text = "Game.state = "..Game.state,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize
	drawingY = drawingY + (0.5 * linebreakSize)

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
	drawingY = drawingY + (0.5 * linebreakSize)

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
	drawingY = drawingY + (0.5 * linebreakSize)

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
	drawingY = drawingY + (0.5 * linebreakSize)

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

	if #Game.selectedSongArrayOfCharts > 0 then
		for i = 1, #Game.selectedSongArrayOfCharts do
			meckx_print({
				Text = "Game.selectedSongArrayOfCharts[" .. i .. "] = " .. Game.selectedSongArrayOfCharts[i],
				XPos = drawingX,
				YPos = drawingY,
				ColorName = "white",
				FontStyle = ClassicConsole_24,
			})
			drawingY = drawingY + linebreakSize
		end
	end
	drawingY = drawingY + (0.5 * linebreakSize)

	meckx_print({
		Text = "Game.selectedChartIndex = "..Game.selectedChartIndex,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "Game.selectedChartName = "..Game.selectedChartName,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "Game.selectedChartDifficulty = "..Game.selectedChartDifficulty,
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

end

return Debug_01Variables