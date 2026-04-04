local Extension = {}

-- LOCAL HELPER VARIABLE
local colors = {
    white = {1, 1, 1},
    lightestGray = {0.8, 0.8, 0.8},
    lightGray = {0.6, 0.6, 0.6},
    darkGray = {0.4, 0.4, 0.4},
    darkestGray = {0.2, 0.2, 0.2},
    black = {0, 0, 0},

    blue = {0, 0, 1},
    magenta = {1, 0, 1},
    red = {1, 0, 0},
    yellow = {1, 1, 0},
	green = {0, 1, 0},
	cyan = {0, 1, 1},

    meckx_01Pink_light = {1, 0, 1},
    meckx_02Blue_light = {0, 0.6, 1},
    meckx_03Green_light = {0.2, 0.7, 0},
    meckx_04Yellow_light = {0.9, 0.8, 0.2},
    meckx_05Orange_light = {1, 0.45, 0},
    meckx_06Red_light = {1, 0, 0},

    meckx_01Pink_dark = {0.4, 0, 0.4},
    meckx_02Blue_dark = {0, 0.15, 0.6},
    meckx_03Green_dark = {0.05, 0.3, 0},
    meckx_04Yellow_dark = {0.35, 0.3, 0},
    meckx_05Orange_dark = {0.4, 0.2, 0},
    meckx_06Red_dark = {0.4, 0, 0},
}

-- LOCAL HELPER FUNCTION
local function getColor(name)
    local grabbed = colors[name] or colors["white"]
    return grabbed[1], grabbed[2], grabbed[3]
end










































-- GLOBAL USEFUL FUNCTIONS (ENGINE TWEAKING)
---@diagnostic disable-next-line: lowercase-global
function meckx_clearScreen(args)
	local r, g, b = getColor(args.ColorName)

	love.graphics.clear(r, g, b)
end

---@diagnostic disable-next-line: lowercase-global
function meckx_print(args)
	local text = args.Text
	local xPos = args.XPos
	local yPos = args.YPos
	local r, g, b = getColor(args.ColorName)
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
	local r, g, b = getColor(args.ColorName)
	local rectStyle = args.RectStyle --"fill" or "idk"
	local transparency = args.Transparency

	love.graphics.setColor(r, g, b, transparency)
	love.graphics.rectangle(rectStyle, xPos, yPos, width, height)
	love.graphics.setColor(1, 1, 1, 1)
end











































return Extension