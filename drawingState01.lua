return function()
	local drawingX = 10
	local drawingY = 10
	local linebreakSize = 26

	love.graphics.clear(0.3, 0.3, 0.3)

	printColoredWhite("-- CHOOSE A PLAYER PROFILE --", drawingX, drawingY)
	drawingY = drawingY + (2 * linebreakSize)

	for i=1,#PlayerDatabase,1 do
		local text = (Game.selectedPlayerIndex == i) and "> "..PlayerDatabase[i].PlayerName.." <" or PlayerDatabase[i].PlayerName
		local colorName = (Game.selectedPlayerIndex == i) and "white" or "black"
		printColoredColor(
			text,
			drawingX,
			drawingY,
			colorName
		)
		drawingY = drawingY + linebreakSize
	end

end