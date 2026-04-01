return function()
	local drawingX = 720
	local drawingY = 10
	local linebreakSize = 26

	--love.graphics.clear(0.1, 0.1, 0.1)
	-- background rectangle
	love.graphics.setColor(0, 0, 1) -- blue
	love.graphics.rectangle("fill", 720-4, 10-6, 1280-(720), 720-10)
	love.graphics.setColor(1, 1, 1) -- reset to white

	printColoredWhite("Tee = "..Tee, drawingX, drawingY)
	drawingY = drawingY + linebreakSize

	printColoredWhite("Game.state = "..Game.state, drawingX, drawingY)
	drawingY = drawingY + linebreakSize

	printColoredWhite("Game.selectedPlayerIndex = "..Game.selectedPlayerIndex, drawingX, drawingY)
	drawingY = drawingY + linebreakSize

end