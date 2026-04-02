local Extension = {}

-- GLOBAL USEFUL FUNCTIONS (ENGINE TWEAKING)
---@diagnostic disable-next-line: lowercase-global
function meckx_clearScreen(args)
	local r,g,b
	if args.ColorName == "white" then r = 1; g = 1; b = 1;
	elseif args.ColorName == "lightGray" then r = 0.6; g = 0.6; b = 0.6;
	elseif args.ColorName == "darkGray" then r = 0.3; g = 0.3; b = 0.3;
	elseif args.ColorName == "black" then r = 0; g = 0; b = 0;
	elseif args.ColorName == "blue" then r = 0; g = 0; b = 1;
	elseif args.ColorName == "pink" then r = 1; g = 0; b = 1;
	elseif args.ColorName == "red" then r = 1; g = 0; b = 0; end

	love.graphics.clear(r, g, b)
end

---@diagnostic disable-next-line: lowercase-global
function meckx_print(args)
	local text = args.Text
	local xPos = args.XPos
	local yPos = args.YPos
	local r,g,b
	if args.ColorName == "white" then r = 1; g = 1; b = 1;
	elseif args.ColorName == "lightGray" then r = 0.6; g = 0.6; b = 0.6;
	elseif args.ColorName == "darkGray" then r = 0.3; g = 0.3; b = 0.3;
	elseif args.ColorName == "black" then r = 0; g = 0; b = 0;
	elseif args.ColorName == "blue" then r = 0; g = 0; b = 1;
	elseif args.ColorName == "pink" then r = 1; g = 0; b = 1;
	elseif args.ColorName == "red" then r = 1; g = 0; b = 0; end
	local fontStyle = args.FontStyle

	love.graphics.setColor(r, g, b)
	love.graphics.setFont(fontStyle)
    love.graphics.print(text, xPos, yPos)
    love.graphics.setColor(1, 1, 1)
	love.graphics.setFont(DefaultFont)
end

---@diagnostic disable-next-line: lowercase-global
function meckx_rect(args)
	local xPos = args.XPos
	local yPos = args.YPos
	local width = args.Width
	local height = args.Height
	local r,g,b
	if args.ColorName == "white" then r = 1; g = 1; b = 1;
	elseif args.ColorName == "lightGray" then r = 0.6; g = 0.6; b = 0.6;
	elseif args.ColorName == "darkGray" then r = 0.3; g = 0.3; b = 0.3;
	elseif args.ColorName == "black" then r = 0; g = 0; b = 0;
	elseif args.ColorName == "blue" then r = 0; g = 0; b = 1;
	elseif args.ColorName == "pink" then r = 1; g = 0; b = 1;
	elseif args.ColorName == "red" then r = 1; g = 0; b = 0; end
	local rectStyle = args.RectStyle --"fill" or "idk"

	love.graphics.setColor(r, g, b)
	love.graphics.rectangle(rectStyle, xPos, yPos, width, height)
	love.graphics.setColor(1, 1, 1)
end

return Extension