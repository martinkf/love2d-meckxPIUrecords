-- THESE ARE THE EXTRA LUA FILES FOR INCLUDE

-- useful engine extension functions
local Extension = require("Extension")
-- debugging overlays
local Debug_01Variables = require("Debug_01Variables")
local Debug_02SimpleInputs = require("Debug_02SimpleInputs")
local Debug_03Controller = require("Debug_03Controller")
-- screens
local State01 = require("State01")
local State02 = require("State02")
local State03 = require("State03")
local State04or05 = require("State04or05")




































-- GLOBAL VARIABLES

Joysticks = {}
Tee = 0
Game = {}
PlayerDatabase = {}
MixDatabase = {}
ChartDatabase = {}
Input = {}










































-- THIS IS THE BOOT FUNCTION.
-- RUNS ONCE, WHEN LOADING GAME
function love.load()
	--engine adjustments (setting font)
	DefaultFont = love.graphics.newFont(24)
	ClassicConsole_48 = love.graphics.newFont("fonts/clacon2.ttf", 48)
	ClassicConsole_24 = love.graphics.newFont("fonts/clacon2.ttf", 24)
	love.graphics.setFont(DefaultFont)

	--initializing engine global variables
	Joysticks = love.joystick.getJoysticks() --needed for input implementation

	--initializing sfx - sound breaks Switch, let's not implement sound...
	--SfxMove = love.audio.newSource("sounds/SfxMove.mp3", "static")
	--SfxCenter = love.audio.newSource("sounds/SfxCenter.mp3", "static")
	--SfxBack = love.audio.newSource("sounds/SfxBack.mp3", "static")

	--initializing global variables
	Tee = 0
	Game.state = 1
	Game.debug = 3

	Game.selectedPlayerIndex = 1
	Game.selectedPlayerName = "MartinTest"
	Game.selectedMixIndex = 0
	Game.selectedMixName = ""
	Game.selectedSortIndex = 0
	Game.selectedSortName = ""
	Game.selectedSongIndex = 0
	Game.selectedSongName = ""
	Game.selectedSongArrayOfCharts = {}
	Game.selectedChartIndex = 0
	Game.selectedChartName = ""
	Game.selectedChartDifficulty = ""

	PlayerDatabase = require("PlayerDatabase")
	MixDatabase = require("MixDatabase")
	ChartDatabase = require("ChartDatabase")

	Input.keyboardHeld = {}
	Input.joystickHeld = {}
    Input.upHoldTime = 0
    Input.downHoldTime = 0
    Input.upRepeatTimer = 0
    Input.downRepeatTimer = 0

	Input.delayBeforeRepeat = 0.2
    Input.slowRate = 0.2
	Input.fastThreshold = 2
    Input.fastRate = 0.075


end
















































-- THESE ARE THE INPUT HANDLING FUNCTIONS.
-- THEY'RE EVENTS. WILL BE TRIGGERED WHEN NEEDED
function love.keypressed(key)

	Input.keyboardHeld[key] = true

	if key == "up" then HandleUp() end
	if key == "down" then HandleDown() end
	if key == "a" then HandleCenter() end
	if key == "b" then HandleBack() end
	if key == "r" then ToggleDebug() end

end

function love.keyreleased(key)

    Input.keyboardHeld[key] = false

end

function love.gamepadpressed(joystick, button)

	Input.joystickHeld[button] = true

	if button == "dpup" then HandleUp() end
	if button == "dpdown" then HandleDown() end
	if button == "a" then HandleCenter() end
	if button == "b" then HandleBack() end
	if button == "rightshoulder" then ToggleDebug() end

end

function love.gamepadreleased(joystick, button)

    Input.joystickHeld[button] = false

end

-- AND THESE ARE THE GLOBAL ACTION HANDLING FUNCTIONS.
function HandleUp()
	if Game.state == 1 then State01.UpPressed()
	elseif Game.state == 2 then State02.UpPressed()
	elseif Game.state == 3 then State03.UpPressed()
	elseif Game.state == 4 then State04or05.UpPressedState04()
	elseif Game.state == 5 then State04or05.UpPressedState05() end
end

function HandleDown()
	if Game.state == 1 then State01.DownPressed()
	elseif Game.state == 2 then State02.DownPressed()
	elseif Game.state == 3 then State03.DownPressed()
	elseif Game.state == 4 then State04or05.DownPressedState04()
	elseif Game.state == 5 then State04or05.DownPressedState05() end
end

function HandleCenter()
	if Game.state == 1 then State01.CenterPressed()
	elseif Game.state == 2 then State02.CenterPressed()
	elseif Game.state == 3 then State03.CenterPressed()
	elseif Game.state == 4 then State04or05.CenterPressedState04() end
end

function HandleBack()
	if Game.state == 2 then State02.BackPressed()
	elseif Game.state == 3 then State03.BackPressed()
	elseif Game.state == 4 then State04or05.BackPressedState04()
	elseif Game.state == 5 then State04or05.BackPressedState05() end
end

function ToggleDebug()
	if Game.debug == 0 then Game.debug = 1
	elseif Game.debug == 1 then Game.debug = 2
	elseif Game.debug == 2 then Game.debug = 3
	elseif Game.debug == 3 then	Game.debug = 0 end
end



































function InputHandling_UpDown(dt)

    -- UP handling
    if Input.keyboardHeld["up"] or Input.joystickHeld["dpup"] then
		Input.upHoldTime = Input.upHoldTime + dt

		if Input.upHoldTime >= Input.delayBeforeRepeat then
			local rate = (Input.upHoldTime > Input.fastThreshold) and Input.fastRate or Input.slowRate

			Input.upRepeatTimer = Input.upRepeatTimer + dt
			if Input.upRepeatTimer >= rate then
				HandleUp()
				Input.upRepeatTimer = 0
			end
		end
	else
		Input.upHoldTime = 0
		Input.upRepeatTimer = 0
	end

    -- DOWN handling
    if Input.keyboardHeld["down"] or Input.joystickHeld["dpdown"] then
		Input.downHoldTime = Input.downHoldTime + dt

		if Input.downHoldTime >= Input.delayBeforeRepeat then
			local rate = (Input.downHoldTime > Input.fastThreshold) and Input.fastRate or Input.slowRate

			Input.downRepeatTimer = Input.downRepeatTimer + dt
			if Input.downRepeatTimer >= rate then
				HandleDown()
				Input.downRepeatTimer = 0
			end
		end
	else
		Input.downHoldTime = 0
		Input.downRepeatTimer = 0
	end

end
































































-- THESE ARE THE LOGIC LOOP FUNCTIONS.
-- RUNS EVERY FRAME, BEFORE DRAWING
function love.update(dt)
	-- clocks
	Tee = Tee + 1

	-- input handling for joysticks -- on switch, joysticks can connect at any time in the game, not just boot
	Joysticks = love.joystick.getJoysticks()

	-- input handling for smooth scrolling
	InputHandling_UpDown(dt)

	-- finally, logic
	--nothing here yet lol
end




































-- THESE ARE THE DRAWING LOOP FUNCTIONS.
-- RUNS EVERY FRAME, AFTER LOGIC
local function drawingUnderlay()

	if Game.state == 1 then
		State01.Drawing()
	elseif Game.state == 2 then
		State02.Drawing()
	elseif Game.state == 3 then
		State03.Drawing()
	elseif Game.state == 4 or Game.state == 5 then
		State04or05.Drawing()
	end

end

local function drawingOverlay()

	if Game.debug == 1 then
		Debug_01Variables.Drawing()
	elseif Game.debug == 2 then
		Debug_02SimpleInputs.Drawing()
	elseif Game.debug == 3 then
		Debug_03Controller.Drawing()
	end

end

function love.draw()
	drawingUnderlay()
	drawingOverlay()
end