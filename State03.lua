local State03 = {}

-- INPUT HANDLING

function State03.UpPressed()

	Game.selectedSortIndex = Game.selectedSortIndex - 1
	if Game.selectedSortIndex == 0 then Game.selectedSortIndex = #Database[Game.selectedMixIndex].SortingMethods end
	Game.selectedSortName = Database[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].SortName

end

function State03.DownPressed()

	Game.selectedSortIndex = Game.selectedSortIndex + 1
	if Game.selectedSortIndex > #Database[Game.selectedMixIndex].SortingMethods then Game.selectedSortIndex = 1 end
	Game.selectedSortName = Database[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].SortName

end

function State03.CenterPressed()

	--

end

function State03.BackPressed()

	Game.state = 2
	Game.selectedSortIndex = 1
	Game.selectedSortName = Database[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].SortName

end









































-- DRAWING

function State03.Drawing()
	local drawingX = 10
	local drawingY = 4
	local linebreakSize = 42

	-- background
	meckx_clearScreen({
		ColorName = "darkGray",
	})

	-- contents
	meckx_print({
		Text = "-- 03. SELECT A SORTING ORDER --",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + (1.5 * linebreakSize)

	for i=1,#Database[Game.selectedMixIndex].SortingMethods,1 do
		local text = (Game.selectedSortIndex == i) and "> "..Database[Game.selectedMixIndex].SortingMethods[i].SortName.." <" or Database[Game.selectedMixIndex].SortingMethods[i].SortName
		local colorName = (Game.selectedSortIndex == i) and "white" or "black"
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











































return State03