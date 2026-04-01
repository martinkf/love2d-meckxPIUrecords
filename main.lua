

-- THESE ARE THE REQUIREMENTS - EXTRA LUA FILES FOR INCLUDE
local drawingVariablesDebugMenu = require("drawingVariablesDebugMenu")
local drawingSimpleInputsDebugMenu = require("drawingSimpleInputsDebugMenu")
local drawingControllerDebugMenu = require("drawingControllerDebugMenu")
local drawingState01 = require("drawingState01")
local drawingState02 = require("drawingState02")
local drawingState03 = require("drawingState03")

-- GLOBAL USEFUL FUNCTIONS (ENGINE TWEAKING)
---@diagnostic disable-next-line: lowercase-global
function printColoredRGB(text, x, y, r, g, b)
    love.graphics.setColor(r, g, b)
    love.graphics.print(text, x, y)
    love.graphics.setColor(1, 1, 1)
end
---@diagnostic disable-next-line: lowercase-global
function printColoredColor(text, x, y, colorName)
	local r, g, b
	if colorName == "white" then r = 1; g = 1; b = 1; end
	if colorName == "lightGray" then r = 0.6; g = 0.6; b = 0.6; end
	if colorName == "darkGray" then r = 0.3; g = 0.3; b = 0.3; end
	if colorName == "black" then r = 0; g = 0; b = 0; end
    love.graphics.setColor(r, g, b)
    love.graphics.print(text, x, y)
    love.graphics.setColor(1, 1, 1)
end
---@diagnostic disable-next-line: lowercase-global
function printColoredWhite(text, x, y)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(text, x, y)
    love.graphics.setColor(1, 1, 1)
end
---@diagnostic disable-next-line: lowercase-global
function printColoredLightGray(text, x, y)
    love.graphics.setColor(0.6, 0.6, 0.6)
    love.graphics.print(text, x, y)
    love.graphics.setColor(1, 1, 1)
end
---@diagnostic disable-next-line: lowercase-global
function printColoredDarkGray(text, x, y)
    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.print(text, x, y)
    love.graphics.setColor(1, 1, 1)
end
---@diagnostic disable-next-line: lowercase-global
function printColoredBlack(text, x, y)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(text, x, y)
    love.graphics.setColor(1, 1, 1)
end

-- GLOBAL VARIABLE DECLARATION
Joysticks = ""
Tee = 0
Game = {}
PlayerDatabase = {}












-- THIS IS THE BOOT FUNCTION.
-- RUNS ONCE, WHEN LOADING GAME
function love.load()
	--engine adjustments
	love.graphics.setFont(love.graphics.newFont(24)) --needed for defining a standard font for printing text

	--initializing engine global variables
	Joysticks = love.joystick.getJoysticks() --needed for input implementation

	--initializing global variables
	Tee = 0
	Game.state = 1
	Game.debug = 0

	Game.selectedPlayerIndex = 1

	PlayerDatabase = {
		{	PlayerName = "MartinTest",

		},
		{	PlayerName = "Using Handpad",

		},
		{	PlayerName = "Using PIU pad",

		},
	}
end













-- THESE ARE THE INPUT HANDLING FUNCTIONS.
-- THEY'RE EVENTS. WILL BE TRIGGERED WHEN NEEDED
function love.keypressed(key)
	if key == "up" then
		UpPressed()
	end
	if key == "down" then
		DownPressed()
	end
	if key == "a" then
		CenterPressed()
	end
	if key == "b" then
		BackPressed()
	end
	if key == "r" then
		ToggleDebug()
	end
end

function love.gamepadpressed(joystick, button)
	if button == "dpup" then
		UpPressed()
	end
	if button == "dpdown" then
		DownPressed()
	end
	if button == "a" then
		CenterPressed()
	end
	if button == "b" then
		BackPressed()
	end
	if button == "rightshoulder" then
		ToggleDebug()
	end
end

-- AND THESE ARE THE ACTION HANDLING FUNCTIONS.
function UpPressed()
	if Game.state == 1 then

		Game.selectedPlayerIndex = Game.selectedPlayerIndex - 1
		if Game.selectedPlayerIndex == 0 then Game.selectedPlayerIndex = #PlayerDatabase end

	elseif Game.state == 2 then
		--
	elseif Game.state == 3 then
		--
	end
end

function DownPressed()
	if Game.state == 1 then

		Game.selectedPlayerIndex = Game.selectedPlayerIndex + 1
		if Game.selectedPlayerIndex > #PlayerDatabase then Game.selectedPlayerIndex = 1 end

	elseif Game.state == 2 then
		--
	elseif Game.state == 3 then
		--
	end
end

function CenterPressed()
	if Game.state == 1 then
		Game.state = 2
	elseif Game.state == 2 then
		Game.state = 3
	end
end

function BackPressed()
	if Game.state == 3 then
		Game.state = 2
	elseif Game.state == 2 then
		Game.state = 1
	end
end

function ToggleDebug()
	if Game.debug == 0 then
		Game.debug = 1
	elseif Game.debug == 1 then
		Game.debug = 2
	elseif Game.debug == 2 then
		Game.debug = 3
	elseif Game.debug == 3 then
		Game.debug = 0
	end
end












-- THESE ARE THE LOGIC LOOP FUNCTIONS.
-- RUNS EVERY FRAME, BEFORE DRAWING
local function updatingLogic()
end

function love.update(dt)
	-- clocks
	Tee = Tee + 1

	-- input handling for joysticks
	Joysticks = love.joystick.getJoysticks()

	-- finally, logic
	updatingLogic()
end














-- THESE ARE THE DRAWING LOOP FUNCTIONS.
-- RUNS EVERY FRAME, AFTER LOGIC
local function drawingUnderlay()
	if Game.state == 1 then
		drawingState01()
	elseif Game.state == 2 then
		drawingState02()
	elseif Game.state == 3 then
		drawingState03()
	end
end

local function drawingOverlay()
	if Game.debug == 1 then
		drawingVariablesDebugMenu()
	elseif Game.debug == 2 then
		drawingSimpleInputsDebugMenu()
	elseif Game.debug == 3 then
		drawingControllerDebugMenu()
	end
end

function love.draw()
	drawingUnderlay()
	drawingOverlay()
end