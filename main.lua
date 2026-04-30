-- THESE ARE THE EXTRA LUA FILES FOR INCLUDE

-- useful engine extension functions
local Extension = require("Extension")
-- save/load feature
local json = require("json")
local SaveLoadLibrary = require("json-saveload")
-- debugging overlays
local Debug_01Variables = require("Debug_01Variables")
local Debug_02SimpleInputs = require("Debug_02SimpleInputs")
local Debug_03Controller = require("Debug_03Controller")
-- screens
local State_01SelectPlayer = require("State_01SelectPlayer")
local State_02SelectMix = require("State_02SelectMix")
local State_03SelectSort = require("State_03SelectSort")
local State_041SelectSongMultipleCharts = require("State_041SelectSongMultipleCharts")
local State_042SelectSongSingleChart = require("State_042SelectSongSingleChart")
local State_05SelectChart = require("State_05SelectChart")
local State_06ChartSelected = require("State_06ChartSelected")
local State_07AddingNewRecord = require("State_07AddingNewRecord")
local State_08EditingRecommendedSpeed = require("State_08EditingRecommendedSpeed")
local State_09EditingRecommendedAV = require("State_09EditingRecommendedAV")
-- overlay screens
local Overlay_Infographic = require("Overlay_Infographic")

-- GLOBAL VARIABLES
--Tee = 0
DatabasePlayers = {}
DatabaseMixes = {}
DatabaseDetails = {}
Joysticks = {}
Game = {}
Input = {}












































-- THESE ARE THE INPUT HANDLING FUNCTIONS.
-- THEY'RE EVENTS. WILL BE TRIGGERED WHEN NEEDED
function love.keypressed(key)

	Input.keyboardHeld[key] = true

	if key == "up" then HandleUp() end
	if key == "down" then HandleDown() end
	if key == "left" then HandleLeft() end
	if key == "right" then HandleRight() end
	if key == "a" then HandleCenter() end
	if key == "b" then HandleBack() end
	if key == "x" then ToggleDebug() end
	if key == "l" then ToggleSongListModeL() end
	if key == "r" then ToggleInfographic() end

end

function love.keyreleased(key)

    Input.keyboardHeld[key] = false

end

function love.gamepadpressed(joystick, button)

	Input.joystickHeld[button] = true

	if button == "dpup" then HandleUp() end
	if button == "dpdown" then HandleDown() end
	if button == "dpleft" then HandleLeft() end
	if button == "dpright" then HandleRight() end
	if button == "a" then HandleCenter() end
	if button == "b" then HandleBack() end
	if button == "x" then ToggleDebug() end
	if button == "leftshoulder" then ToggleSongListModeL() end
	if button == "rightshoulder" then ToggleInfographic() end

end

function love.gamepadreleased(joystick, button)

    Input.joystickHeld[button] = false

end

-- THIS IS CHECKED EVERY FRAME TO IMPLEMENT THE SCROLLING "HELDING DOWN" FEATURE.
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

-- AND THESE ARE THE GLOBAL ACTION HANDLING FUNCTIONS.
function HandleUp()
	if Game.state == 1 then State_01SelectPlayer.UpPressed()
	elseif Game.state == 2 then State_02SelectMix.UpPressed()
	elseif Game.state == 3 then State_03SelectSort.UpPressed()
	elseif Game.state == 41 then State_041SelectSongMultipleCharts.UpPressed()
	elseif Game.state == 42 then State_042SelectSongSingleChart.UpPressed()
	elseif Game.state == 5 then State_05SelectChart.UpPressed()
	elseif Game.state == 6 then State_06ChartSelected.UpPressed()
	elseif Game.state == 7 then State_07AddingNewRecord.UpPressed()
	elseif Game.state == 8 then State_08EditingRecommendedSpeed.UpPressed()
	elseif Game.state == 9 then State_09EditingRecommendedAV.UpPressed() end
end

function HandleDown()
	if Game.state == 1 then State_01SelectPlayer.DownPressed()
	elseif Game.state == 2 then State_02SelectMix.DownPressed()
	elseif Game.state == 3 then State_03SelectSort.DownPressed()
	elseif Game.state == 41 then State_041SelectSongMultipleCharts.DownPressed()
	elseif Game.state == 42 then State_042SelectSongSingleChart.DownPressed()
	elseif Game.state == 5 then State_05SelectChart.DownPressed()
	elseif Game.state == 6 then State_06ChartSelected.DownPressed()
	elseif Game.state == 7 then State_07AddingNewRecord.DownPressed()
	elseif Game.state == 8 then State_08EditingRecommendedSpeed.DownPressed()
	elseif Game.state == 9 then State_09EditingRecommendedAV.DownPressed() end
end

function HandleCenter()
	if Game.state == 1 then State_01SelectPlayer.CenterPressed()
	elseif Game.state == 2 then State_02SelectMix.CenterPressed()
	elseif Game.state == 3 then State_03SelectSort.CenterPressed()
	elseif Game.state == 41 then State_041SelectSongMultipleCharts.CenterPressed()
	elseif Game.state == 42 then State_042SelectSongSingleChart.CenterPressed()
	elseif Game.state == 5 then State_05SelectChart.CenterPressed()
	elseif Game.state == 6 then State_06ChartSelected.CenterPressed()
	elseif Game.state == 7 then State_07AddingNewRecord.CenterPressed()
	elseif Game.state == 8 then State_08EditingRecommendedSpeed.CenterPressed()
	elseif Game.state == 9 then State_09EditingRecommendedAV.CenterPressed() end
end

function HandleBack()
	if Game.state == 2 then State_02SelectMix.BackPressed()
	elseif Game.state == 3 then State_03SelectSort.BackPressed()
	elseif Game.state == 41 then State_041SelectSongMultipleCharts.BackPressed()
	elseif Game.state == 42 then State_042SelectSongSingleChart.BackPressed()
	elseif Game.state == 5 then State_05SelectChart.BackPressed()
	elseif Game.state == 6 then State_06ChartSelected.BackPressed()
	elseif Game.state == 7 then State_07AddingNewRecord.BackPressed()
	elseif Game.state == 8 then State_08EditingRecommendedSpeed.BackPressed()
	elseif Game.state == 9 then State_09EditingRecommendedAV.BackPressed() end
end

function HandleLeft()
	if Game.state == 7 then State_07AddingNewRecord.LeftPressed()
	elseif Game.state == 8 then State_08EditingRecommendedSpeed.LeftPressed()
	elseif Game.state == 9 then State_09EditingRecommendedAV.LeftPressed() end
end

function HandleRight()
	if Game.state == 7 then State_07AddingNewRecord.RightPressed()
	elseif Game.state == 8 then State_08EditingRecommendedSpeed.RightPressed()
	elseif Game.state == 9 then State_09EditingRecommendedAV.RightPressed() end
end

function ToggleDebug()
	if Game.debug == 0 then Game.debug = 1
	elseif Game.debug == 1 then Game.debug = 2
	elseif Game.debug == 2 then Game.debug = 3
	elseif Game.debug == 3 then	Game.debug = 0 end
end

function ToggleInfographic()

	if Game.state == 42 then
		if Game.infographic == 0 then Game.infographic = 1 else Game.infographic = 0 end
	end

end

function ToggleSongListModeL()

	if Game.state == 41 or Game.state == 42 then
		if Game.songListModeL == 0 then Game.songListModeL = 1 else Game.songListModeL = 0 end
	end

end












































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

	--initializing save/load feature
	MemorycardData = LoadFromMemorycard()
	SaveToMemorycard()

	-- DATABASEPLAYERS
	local file = love.filesystem.read("memorycard.json")
	local data = json.decode(file)
	DatabasePlayers = {}
	if data and data.Players then
		for playerName, _ in pairs(data.Players) do
			DatabasePlayers[#DatabasePlayers + 1] = {
				PlayerName = playerName
			}
		end
	end
	table.sort(DatabasePlayers, function(a, b)
		return a.PlayerName < b.PlayerName
	end)
	-- DATABASEMIXES
	DatabaseMixes = require("Database_Mixes")
	-- DATABASEDETAILS
	DatabaseDetails = require("Database_Details")

	--initializing global variables
	--Tee = 0
	Game.state = 1
	Game.debug = 0
	Game.infographic = 0
	Game.songListModeL = 0

	Game.baseDrawingY = (love._os == "Horizon") and 6 or -3

	Game.selectedPlayerIndex = 1
	Game.selectedPlayerName = DatabasePlayers[1].PlayerName

	Game.selectedMixIndex = 0
	Game.selectedMixName = ""

	Game.selectedSortIndex = 0
	Game.selectedSortName = ""
	Game.selectedSortTotalSongs = 0

	Game.selectedSongIndex = 0
	Game.selectedSongName = ""
	Game.selectedSongArrayOfCharts = {}

	Game.selectedChartIndex = 0
	Game.selectedChartName = ""
	Game.selectedChartDifficultyName = ""
	Game.selectedChartRecommendedSpeed = ""
	Game.selectedChartRecommendedAV = ""

	Game.selectedChartOptIndex = 0
	Game.selectedChartOptName = ""



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


















































-- THESE ARE THE LOGIC LOOP FUNCTIONS.
-- RUNS EVERY FRAME, BEFORE DRAWING
function love.update(dt)

	-- clocks, if i ever need that
	--Tee = Tee + 1

	-- input handling for joysticks -- on switch, joysticks can connect at any time in the game, not just boot
	-- hence we're always checking for the little fuckers
	Joysticks = love.joystick.getJoysticks()

	-- input handling for helding-down scrolling
	InputHandling_UpDown(dt)

	-- finally, logic
	--nothing here yet lol

end




































-- THESE ARE THE DRAWING LOOP FUNCTIONS.
-- RUNS EVERY FRAME, AFTER LOGIC
local function drawingUnderlay()

	if Game.state == 1 then State_01SelectPlayer.Drawing()
	elseif Game.state == 2 then State_02SelectMix.Drawing()
	elseif Game.state == 3 then State_03SelectSort.Drawing()
	elseif Game.state == 41 then State_041SelectSongMultipleCharts.Drawing()
	elseif Game.state == 42 then State_042SelectSongSingleChart.Drawing()
	elseif Game.state == 5 then State_05SelectChart.Drawing()
	elseif Game.state == 6 then State_06ChartSelected.Drawing()
	elseif Game.state == 7 then State_07AddingNewRecord.Drawing()
	elseif Game.state == 8 then State_08EditingRecommendedSpeed.Drawing()
	elseif Game.state == 9 then State_09EditingRecommendedAV.Drawing() end

end

local function drawingOverlay()

	if ((Game.infographic == 1) and (Game.state == 42)) then Overlay_Infographic.Drawing() end

	if Game.debug == 1 then Debug_01Variables.Drawing()
	elseif Game.debug == 2 then Debug_02SimpleInputs.Drawing()
	elseif Game.debug == 3 then Debug_03Controller.Drawing() end

end

function love.draw()
	drawingUnderlay()
	drawingOverlay()
end