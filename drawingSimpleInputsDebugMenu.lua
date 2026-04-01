return function()
	local j = Joysticks[1]
	local drawingX = 720
	local drawingY = 10
	local linebreakSize = 26

	--love.graphics.clear(0, 0, 0)
	-- background rectangle
	love.graphics.setColor(1, 0, 1) -- pink
	love.graphics.rectangle("fill", drawingX-4, drawingY-6, 1280-(drawingX), 720-drawingY)
	love.graphics.setColor(1, 1, 1) -- reset to white

	-- Joystick information
	if #Joysticks == 0 then
		printColoredLightGray("No controller detected", drawingX, drawingY)
	else
		printColoredLightGray("Controller: "..j:getName(), drawingX, drawingY)
	end

	drawingY = drawingY + linebreakSize

	-- Joystick buttons
	if j:isGamepadDown("dpup") then
		printColoredWhite("UP held", drawingX, drawingY)
	else
		printColoredDarkGray("UP not held", drawingX, drawingY)
	end
	drawingY = drawingY + linebreakSize

	if j:isGamepadDown("dpdown") then
		printColoredWhite("DOWN held", drawingX, drawingY)
	else
		printColoredDarkGray("DOWN not held", drawingX, drawingY)
	end
	drawingY = drawingY + linebreakSize

	if j:isGamepadDown("dpleft") then
		printColoredWhite("LEFT held", drawingX, drawingY)
	else
		printColoredDarkGray("LEFT not held", drawingX, drawingY)
	end
	drawingY = drawingY + linebreakSize

	if j:isGamepadDown("dpright") then
		printColoredWhite("RIGHT held", drawingX, drawingY)
	else
		printColoredDarkGray("RIGHT not held", drawingX, drawingY)
	end
	drawingY = drawingY + linebreakSize

	if j:isGamepadDown("a") then
		printColoredWhite("A held", drawingX, drawingY)
	else
		printColoredDarkGray("A not held", drawingX, drawingY)
	end
	drawingY = drawingY + linebreakSize

	if j:isGamepadDown("b") then
		printColoredWhite("B held", drawingX, drawingY)
	else
		printColoredDarkGray("B not held", drawingX, drawingY)
	end
	drawingY = drawingY + linebreakSize

	if j:isGamepadDown("rightshoulder") then
		printColoredWhite("R held", drawingX, drawingY)
	else
		printColoredDarkGray("R not held", drawingX, drawingY)
	end
	drawingY = drawingY + linebreakSize





	-- Holding Keyboard (when on PC)
	-- comment these out when deploying to Switch!!!!

--[[

	printColoredLightGray("Holding down PC Keyboard keys", drawingX, drawingY)
	drawingY = drawingY + linebreakSize

	if love.keyboard.isDown("up") then
		printColoredWhite("Keyboard UP ARROW is pressed", drawingX, drawingY)
	else
		printColoredDarkGray("Keyboard UP ARROW not pressed", drawingX, drawingY)
	end
	drawingY = drawingY + linebreakSize

	if love.keyboard.isDown("down") then
		printColoredWhite("Keyboard DOWN ARROW is pressed", drawingX, drawingY)
	else
		printColoredDarkGray("Keyboard DOWN ARROW not pressed", drawingX, drawingY)
	end
	drawingY = drawingY + linebreakSize

	if love.keyboard.isDown("left") then
		printColoredWhite("Keyboard LEFT ARROW is pressed", drawingX, drawingY)
	else
		printColoredDarkGray("Keyboard LEFT ARROW not pressed", drawingX, drawingY)
	end
	drawingY = drawingY + linebreakSize

	if love.keyboard.isDown("right") then
		printColoredWhite("Keyboard RIGHT ARROW is pressed", drawingX, drawingY)
	else
		printColoredDarkGray("Keyboard RIGHT ARROW not pressed", drawingX, drawingY)
	end
	drawingY = drawingY + linebreakSize

	if love.keyboard.isDown("a") then
		printColoredWhite("Keyboard A is pressed", drawingX, drawingY)
	else
		printColoredDarkGray("Keyboard A not pressed", drawingX, drawingY)
	end
	drawingY = drawingY + linebreakSize

	if love.keyboard.isDown("b") then
		printColoredWhite("Keyboard B is pressed", drawingX, drawingY)
	else
		printColoredDarkGray("Keyboard B not pressed", drawingX, drawingY)
	end
	drawingY = drawingY + linebreakSize

	if love.keyboard.isDown("r") then
		printColoredWhite("Keyboard R is pressed", drawingX, drawingY)
	else
		printColoredDarkGray("Keyboard R not pressed", drawingX, drawingY)
	end
	drawingY = drawingY + linebreakSize
	
	-- not used, for reference
	local keys = {
		"a","b","c","d",
		"up","down","left","right",
		"space","lshift","rshift",
		"escape","return","tab"
	}
	
]]--

end