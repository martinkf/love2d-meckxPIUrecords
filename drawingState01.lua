return function()
	local drawingX = 10
	local drawingY = 10
	local linebreakSize = 26

	love.graphics.clear(0.3, 0.3, 0.3)

	printColoredWhite("-- CHOOSE A PLAYER PROFILE --", drawingX, drawingY)
	drawingY = drawingY + (2 * linebreakSize)

	printColoredWhite(PlayerDatabase[1].PlayerName, drawingX, drawingY)
	drawingY = drawingY + linebreakSize

	printColoredWhite(PlayerDatabase[2].PlayerName, drawingX, drawingY)
	drawingY = drawingY + linebreakSize
end