local Debug_03Controller = {}

function Debug_03Controller.Drawing()
	local j = Joysticks[1]
	local drawingX = 660
	local drawingY = 100
	local linebreakSize = 26

	-- background
	meckx_rect({
		XPos = drawingX - 4,
		YPos = drawingY - 6,
		Width = 1280 - drawingX,
		Height = 720 - drawingY,
		ColorName = "red",
		RectStyle = "fill",
		Transparency = 0.25,
	})

	if #Joysticks == 0 then
		meckx_print({
			Text = "No controller detected",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "lightGray",
			FontStyle = ClassicConsole_24,
		})
		return
	end

	meckx_print({
		Text = "Controller: "..j:getName(),
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "lightGray",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	-- Buttons
	local buttons = {
		"a","b","x","y",
		"leftshoulder","rightshoulder",
		"back","start","guide",
		"leftstick","rightstick",
		"dpup","dpdown","dpleft","dpright"
	}

	meckx_print({
		Text = "Buttons:",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "lightGray",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	for _,btn in ipairs(buttons) do
		if j:isGamepadDown(btn) then
			meckx_print({
				Text = btn.." pressed",
				XPos = drawingX,
				YPos = drawingY,
				ColorName = "white",
				FontStyle = ClassicConsole_24,
			})
			drawingY = drawingY + linebreakSize
		end
	end
	drawingY = drawingY + linebreakSize

	-- Axes (sticks)
	meckx_print({
		Text = "Left Stick:",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "lightGray",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize
	meckx_print({
		Text = "X: "..string.format("%.2f", j:getGamepadAxis("leftx")),
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize
	meckx_print({
		Text = "Y: "..string.format("%.2f", j:getGamepadAxis("lefty")),
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "Right Stick:",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "lightGray",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize
	meckx_print({
		Text = "X: "..string.format("%.2f", j:getGamepadAxis("rightx")),
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize
	meckx_print({
		Text = "Y: "..string.format("%.2f", j:getGamepadAxis("righty")),
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

	-- Triggers
	meckx_print({
		Text = "Triggers:",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "lightGray",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize
	meckx_print({
		Text = "L2: "..string.format("%.2f", j:getGamepadAxis("triggerleft")),
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize
	meckx_print({
		Text = "R2: "..string.format("%.2f", j:getGamepadAxis("triggerright")),
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_24,
	})
	drawingY = drawingY + linebreakSize

end

return Debug_03Controller