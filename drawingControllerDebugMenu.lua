return function()
	--love.graphics.clear(0.1, 0.1, 0.1)
	-- background rectangle
	love.graphics.setColor(1, 0, 0) -- red
	love.graphics.rectangle("fill", 720-4, 10-6, 1280-(720), 720-10)
	love.graphics.setColor(1, 1, 1) -- reset to white

	local j = Joysticks[1]

	local x = 720
	local y = 10

	if #Joysticks == 0 then
		love.graphics.print("No controller detected", x, 10)
		return
	end

	love.graphics.print("Controller: "..j:getName(), x, y)
	y = y + 30

	-- Buttons
	local buttons = {
		"a","b","x","y",
		"leftshoulder","rightshoulder",
		"back","start","guide",
		"leftstick","rightstick",
		"dpup","dpdown","dpleft","dpright"
	}

	love.graphics.print("Buttons:", x, y)
	y = y + 30

	for _,btn in ipairs(buttons) do
		if j:isGamepadDown(btn) then
		love.graphics.print(btn.." pressed", x, y)
		y = y + 26
		end
	end

	y = y + 20

	-- Axes (sticks)
	love.graphics.print("Left Stick:", x, y)
	y = y + 26
	love.graphics.print("X: "..string.format("%.2f", j:getGamepadAxis("leftx")), x, y)
	y = y + 26
	love.graphics.print("Y: "..string.format("%.2f", j:getGamepadAxis("lefty")), x, y)
	y = y + 30

	love.graphics.print("Right Stick:", x, y)
	y = y + 26
	love.graphics.print("X: "..string.format("%.2f", j:getGamepadAxis("rightx")), x, y)
	y = y + 26
	love.graphics.print("Y: "..string.format("%.2f", j:getGamepadAxis("righty")), x, y)
	y = y + 30

	-- Triggers
	love.graphics.print("Triggers:", x, y)
	y = y + 26
	love.graphics.print("L2: "..string.format("%.2f", j:getGamepadAxis("triggerleft")), x, y)
	y = y + 26
	love.graphics.print("R2: "..string.format("%.2f", j:getGamepadAxis("triggerright")), x, y)

	y = y + 30

	-- Keyboard (when on PC)
	local keys = {
		"a","b","c","d",
		"up","down","left","right",
		"space","lshift","rshift",
		"escape","return","tab"
	}

	love.graphics.print("Keys:", x, y)
	y = y + 30

	for _, key in ipairs(keys) do
		if love.keyboard.isDown(key) then
			love.graphics.print(key .. " pressed", x, y)
			y = y + 26
		end
	end
end