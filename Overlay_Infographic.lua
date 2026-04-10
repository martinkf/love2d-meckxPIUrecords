local Overlay_Infographic = {}

function Overlay_Infographic.Drawing()
	local drawingX = 4
	local drawingY = 48

	local numberOfSongs = #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs
	local totalWidth = 1272
    local totalHeight = 668

	local cols = math.ceil(math.sqrt(numberOfSongs))
    local rows = math.ceil(numberOfSongs / cols)

	-- background
	meckx_rect({
		XPos = drawingX,
		YPos = drawingY,
		Width = 1272,
		Height = 668,
		ColorName = "black",
		RectStyle = "fill",
		Transparency = 1,
	})

	-- da grid
	for i=1, numberOfSongs do
        local col = (i - 1) % cols
        local row = math.floor((i - 1) / cols)

        local xPos = drawingX + (col * (totalWidth / cols))
        local yPos = drawingY + (row * (totalHeight / rows))

        local songTitle = DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs[i].SongTitle
		local color = DatabaseDetails.FetchSongColorEnabled(songTitle)

        meckx_rect({
            XPos = xPos,
            YPos = yPos,
            Width = (totalWidth / cols),
            Height = (totalHeight / rows),
            ColorName = color,
            RectStyle = "fill",
            Transparency = 1,
        })
    end

end

return Overlay_Infographic