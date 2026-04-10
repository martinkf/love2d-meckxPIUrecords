local Overlay_Infographic = {}

function Overlay_Infographic.Drawing()
	local drawingX = 4
	local drawingY = 48
	local linebreakSize = 26
	local numberOfSongs = #DatabaseMixes[Game.selectedMixIndex].SortingMethods[Game.selectedSortIndex].AvailableSongs
	local totalWidth = 1272
    local totalHeight = 668
	local columnWidth = totalWidth / numberOfSongs

	local colors = {
        "black",
        "gray",
        "white",
        "gray"
    }

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

	for i = 1, numberOfSongs do
        local xPos = drawingX + (i - 1) * columnWidth
        local color = colors[((i - 1) % #colors) + 1]

        meckx_rect({
            XPos = xPos,
            YPos = drawingY,
            Width = columnWidth,
            Height = totalHeight,
            ColorName = color,
            RectStyle = "fill",
            Transparency = 1,
        })
    end

end

return Overlay_Infographic