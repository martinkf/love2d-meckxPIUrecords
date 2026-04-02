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
local State04 = require("State04")




































-- GLOBAL VARIABLES

Joysticks = ""
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

	--initializing sfx
	SfxMove = love.audio.newSource("sounds/move.ogg", "static")
	SfxCenter = love.audio.newSource("sounds/S_C_MOVE.mp3", "static")
	SfxBack = love.audio.newSource("sounds/ChannelWheel change.ogg", "static")

	--initializing global variables
	Tee = 0
	Game.state = 1
	Game.debug = 0

	Game.selectedPlayerIndex = 1
	Game.selectedPlayerName = "MartinTest"
	Game.selectedMixIndex = 1
	Game.selectedMixName = "O.B.G Season Evolution"
	Game.selectedSortIndex = 1
	Game.selectedSortName = "Full Display Mode"
	Game.selectedSongIndex = 1
	Game.selectedSongName = "ANOTHER TRUTH | CORDIALITY"
	Game.selectedSongArrayOfCharts = {}

	PlayerDatabase = require("PlayerDatabase")
	MixDatabase = require("MixDatabase")
	ChartDatabase = require("ChartDatabase")

	Input.upHeld = false
    Input.downHeld = false
    Input.upHoldTime = 0
    Input.downHoldTime = 0
    Input.upRepeatTimer = 0
    Input.downRepeatTimer = 0

	Input.delayBeforeRepeat = 0.25
    Input.slowRate = 0.05
	Input.fastThreshold = 3
    Input.fastRate = 0.025


end
















































-- THESE ARE THE INPUT HANDLING FUNCTIONS.
-- THEY'RE EVENTS. WILL BE TRIGGERED WHEN NEEDED
function love.keypressed(key)
	if key == "up" then
		HandleUp()
	end
	if key == "down" then
		HandleDown()
	end
	if key == "a" then
		if Game.state == 1 then State01.CenterPressed()
		elseif Game.state == 2 then State02.CenterPressed()
		elseif Game.state == 3 then State03.CenterPressed()
		elseif Game.state == 4 then State04.CenterPressed() end
	end
	if key == "b" then
		if Game.state == 1 then State01.BackPressed()
		elseif Game.state == 2 then State02.BackPressed()
		elseif Game.state == 3 then State03.BackPressed()
		elseif Game.state == 4 then State04.BackPressed() end
	end
	if key == "r" then
		ToggleDebug()
	end
end

function love.gamepadpressed(joystick, button)
	if button == "dpup" then
		if Game.state == 1 then State01.UpPressed()
		elseif Game.state == 2 then State02.UpPressed()
		elseif Game.state == 3 then State03.UpPressed()
		elseif Game.state == 4 then State04.UpPressed() end
	end
	if button == "dpdown" then
		if Game.state == 1 then State01.DownPressed()
		elseif Game.state == 2 then State02.DownPressed()
		elseif Game.state == 3 then State03.DownPressed()
		elseif Game.state == 4 then State04.DownPressed() end
	end
	if button == "a" then
		if Game.state == 1 then State01.CenterPressed()
		elseif Game.state == 2 then State02.CenterPressed()
		elseif Game.state == 3 then State03.CenterPressed()
		elseif Game.state == 4 then State04.CenterPressed() end
	end
	if button == "b" then
		if Game.state == 1 then State01.BackPressed()
		elseif Game.state == 2 then State02.BackPressed()
		elseif Game.state == 3 then State03.BackPressed()
		elseif Game.state == 4 then State04.BackPressed() end
	end
	if button == "rightshoulder" then
		ToggleDebug()
	end
end

-- AND THESE ARE THE GLOBAL ACTION HANDLING FUNCTIONS.
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

function HandleUp()
	if Game.state == 1 then State01.UpPressed()
	elseif Game.state == 2 then State02.UpPressed()
	elseif Game.state == 3 then State03.UpPressed()
	elseif Game.state == 4 then State04.UpPressed() end
end

function HandleDown()
	if Game.state == 1 then State01.DownPressed()
	elseif Game.state == 2 then State02.DownPressed()
	elseif Game.state == 3 then State03.DownPressed()
	elseif Game.state == 4 then State04.DownPressed() end
end



































function InputHandling_UpDown(dt)
    local j = Joysticks[1]

	-- for pc
    --local upNow = love.keyboard.isDown("up") or (j and j:isGamepadDown("dpup"))
	--local downNow = love.keyboard.isDown("down") or (j and j:isGamepadDown("dpdown"))
	-- for switch
	local upNow = j and j:isGamepadDown("dpup")
    local downNow = j and j:isGamepadDown("dpdown")

    -- UP handling
    if upNow then
        if not Input.upHeld then
            Input.upHeld = true
            Input.upHoldTime = 0
            Input.upRepeatTimer = 0
        else
            Input.upHoldTime = Input.upHoldTime + dt

            if Input.upHoldTime >= Input.delayBeforeRepeat then
                local rate = (Input.upHoldTime > Input.fastThreshold) and Input.fastRate or Input.slowRate

                Input.upRepeatTimer = Input.upRepeatTimer + dt
                if Input.upRepeatTimer >= rate then
                    HandleUp()
                    Input.upRepeatTimer = 0
                end
            end
        end
    else
        Input.upHeld = false
        Input.upHoldTime = 0
        Input.upRepeatTimer = 0
    end

    -- DOWN handling
    if downNow then
        if not Input.downHeld then
            Input.downHeld = true
            Input.downHoldTime = 0
            Input.downRepeatTimer = 0
        else
            Input.downHoldTime = Input.downHoldTime + dt

            if Input.downHoldTime >= Input.delayBeforeRepeat then
                local rate = (Input.downHoldTime > Input.fastThreshold) and Input.fastRate or Input.slowRate

                Input.downRepeatTimer = Input.downRepeatTimer + dt
                if Input.downRepeatTimer >= rate then
                    HandleDown()
                    Input.downRepeatTimer = 0
                end
            end
        end
    else
        Input.downHeld = false
        Input.downHoldTime = 0
        Input.downRepeatTimer = 0
    end
end
































































-- THESE ARE THE LOGIC LOOP FUNCTIONS.
-- RUNS EVERY FRAME, BEFORE DRAWING
function love.update(dt)
	-- clocks
	Tee = Tee + 1

	-- input handling for joysticks
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
	elseif Game.state == 4 then
		State04.Drawing()
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