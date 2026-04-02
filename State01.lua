local State01 = {}

-- INPUT HANDLING

function State01.UpPressed()

	Game.selectedPlayerIndex = Game.selectedPlayerIndex - 1
	if Game.selectedPlayerIndex == 0 then Game.selectedPlayerIndex = #PlayerDatabase end
	Game.selectedPlayerName = PlayerDatabase[Game.selectedPlayerIndex].PlayerName

end

function State01.DownPressed()

	Game.selectedPlayerIndex = Game.selectedPlayerIndex + 1
	if Game.selectedPlayerIndex > #PlayerDatabase then Game.selectedPlayerIndex = 1 end
	Game.selectedPlayerName = PlayerDatabase[Game.selectedPlayerIndex].PlayerName

end

function State01.CenterPressed()

	Game.state = 2

end

function State01.BackPressed()

	--

end









































-- DRAWING

function State01.Drawing()
	local drawingX = 10
	local drawingY = 4
	local linebreakSize = 42

	-- background
	meckx_clearScreen({
		ColorName = "darkGray",
	})

	-- contents
	meckx_print({
		Text = "-- 01. CHOOSE A PLAYER PROFILE --",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + (1.5 * linebreakSize)

	for i=1,#PlayerDatabase,1 do
		local text = (Game.selectedPlayerIndex == i) and "> "..PlayerDatabase[i].PlayerName.." <" or PlayerDatabase[i].PlayerName
		local colorName = (Game.selectedPlayerIndex == i) and "white" or "black"
		meckx_print({
			Text = text,
			XPos = drawingX,
			YPos = drawingY,
			ColorName = colorName,
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize
	end

end











































return State01