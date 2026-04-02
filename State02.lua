local State02 = {}

-- INPUT HANDLING

function State02.UpPressed()

	Game.selectedMixIndex = Game.selectedMixIndex - 1
	if Game.selectedMixIndex == 0 then Game.selectedMixIndex = #Database end
	Game.selectedMixName = Database[Game.selectedMixIndex].MixName

end

function State02.DownPressed()

	Game.selectedMixIndex = Game.selectedMixIndex + 1
	if Game.selectedMixIndex > #Database then Game.selectedMixIndex = 1 end
	Game.selectedMixName = Database[Game.selectedMixIndex].MixName

end

function State02.CenterPressed()

	Game.state = 3

end

function State02.BackPressed()

	Game.state = 1
	Game.selectedMixIndex = 1
	Game.selectedMixName = Database[Game.selectedMixIndex].MixName

end









































-- DRAWING

function State02.Drawing()
	local drawingX = 10
	local drawingY = 4
	local linebreakSize = 42

	-- background
	meckx_clearScreen({
		ColorName = "darkGray",
	})

	-- contents
	meckx_print({
		Text = "-- 02. SELECT A PIU MIX --",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + (1.5 * linebreakSize)

	for i=1,#Database,1 do
		local text = (Game.selectedMixIndex == i) and "> "..Database[i].MixName.." <" or Database[i].MixName
		local colorName = (Game.selectedMixIndex == i) and "white" or "black"
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











































return State02