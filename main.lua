

-- THESE ARE THE REQUIREMENTS - EXTRA LUA FILES FOR INCLUDE
local drawingVariablesDebugMenu = require("drawingVariablesDebugMenu")
local drawingSimpleInputsDebugMenu = require("drawingSimpleInputsDebugMenu")
local drawingControllerDebugMenu = require("drawingControllerDebugMenu")
local drawingState01 = require("drawingState01")
local drawingState02 = require("drawingState02")
local drawingState03 = require("drawingState03")

-- GLOBAL USEFUL FUNCTIONS (ENGINE TWEAKING)
---@diagnostic disable-next-line: lowercase-global
function printColored(text, x, y, r, g, b)
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
function printColoredDarkGray(text, x, y)
    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.print(text, x, y)
    love.graphics.setColor(1, 1, 1)
end
---@diagnostic disable-next-line: lowercase-global
function printColoredLightGray(text, x, y)
    love.graphics.setColor(0.6, 0.6, 0.6)
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
		{	PlayerName = "Using Handpad",

		},
		{	PlayerName = "Using PIU pad",

		},
	}
end













-- THESE ARE THE INPUT HANDLING FUNCTIONS.
-- THEY'RE EVENTS. WILL BE TRIGGERED WHEN NEEDED
function love.keypressed(key)
	if key == "r" then
		ToggleDebug()
	end
	if key == "a" then
		CenterPressed()
	end
	if key == "b" then
		BackPressed()
	end
end

function love.gamepadpressed(joystick, button)
	if button == "rightshoulder" then
		ToggleDebug()
	elseif button == "a" then
		CenterPressed()
	elseif button == "b" then
		BackPressed()
	end
end

-- AND THESE ARE THE ACTION HANDLING FUNCTIONS.
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