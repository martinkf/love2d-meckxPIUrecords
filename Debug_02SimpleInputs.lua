local Debug_02SimpleInputs = {}

function Debug_02SimpleInputs.Drawing()
	local j = Joysticks[1]
	local drawingX = 660
	local drawingY = 280
	local linebreakSize = 26

	-- background
	meckx_rect({
		XPos = drawingX - 4,
		YPos = drawingY - 6,
		Width = 1280 - drawingX,
		Height = 720 - drawingY,
		ColorName = "pink",
		RectStyle = "fill",
	})

	-- Joystick information
	if #Joysticks == 0 then
		meckx_print({
			Text = "No controller detected",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "lightGray",
			FontStyle = ClassicConsole_24,
		})
	else
		meckx_print({
			Text = "Controller: "..j:getName(),
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "lightGray",
			FontStyle = ClassicConsole_24,
		})
	end
	drawingY = drawingY + linebreakSize

	-- Joystick buttons
	if j:isGamepadDown("dpup") then
		meckx_print({
			Text = "UP held",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "white",
			FontStyle = ClassicConsole_24,
		})
	else
		meckx_print({
			Text = "UP not held",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "darkGray",
			FontStyle = ClassicConsole_24,
		})
	end
	drawingY = drawingY + linebreakSize

	if j:isGamepadDown("dpdown") then
		meckx_print({
			Text = "DOWN held",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "white",
			FontStyle = ClassicConsole_24,
		})
	else
		meckx_print({
			Text = "DOWN not held",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "darkGray",
			FontStyle = ClassicConsole_24,
		})
	end
	drawingY = drawingY + linebreakSize

	if j:isGamepadDown("dpleft") then
		meckx_print({
			Text = "LEFT held",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "white",
			FontStyle = ClassicConsole_24,
		})
	else
		meckx_print({
			Text = "LEFT not held",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "darkGray",
			FontStyle = ClassicConsole_24,
		})
	end
	drawingY = drawingY + linebreakSize

	if j:isGamepadDown("dpright") then
		meckx_print({
			Text = "RIGHT held",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "white",
			FontStyle = ClassicConsole_24,
		})
	else
		meckx_print({
			Text = "RIGHT not held",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "darkGray",
			FontStyle = ClassicConsole_24,
		})
	end
	drawingY = drawingY + linebreakSize

	if j:isGamepadDown("a") then
		meckx_print({
			Text = "A held",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "white",
			FontStyle = ClassicConsole_24,
		})
	else
		meckx_print({
			Text = "A not held",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "darkGray",
			FontStyle = ClassicConsole_24,
		})
	end
	drawingY = drawingY + linebreakSize

	if j:isGamepadDown("b") then
		meckx_print({
			Text = "B held",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "white",
			FontStyle = ClassicConsole_24,
		})
	else
		meckx_print({
			Text = "B not held",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "darkGray",
			FontStyle = ClassicConsole_24,
		})
	end
	drawingY = drawingY + linebreakSize

	if j:isGamepadDown("rightshoulder") then
		meckx_print({
			Text = "R held",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "white",
			FontStyle = ClassicConsole_24,
		})
	else
		meckx_print({
			Text = "R not held",
			XPos = drawingX,
			YPos = drawingY,
			ColorName = "darkGray",
			FontStyle = ClassicConsole_24,
		})
	end
	drawingY = drawingY + linebreakSize

end

return Debug_02SimpleInputs