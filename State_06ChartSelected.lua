local State_06ChartSelected = {}

-- LOCAL VARIABLES

local chartOptions = {
	"Add new record",
	"Edit recommended speed"
}

-- GLOBAL FUNCTIONS
function ResetState06()
	--
end

-- INPUT HANDLING

function State_06ChartSelected.UpPressed()

	Game.selectedChartOptIndex = Game.selectedChartOptIndex - 1
	if Game.selectedChartOptIndex == 0 then Game.selectedChartOptIndex = #chartOptions end
	Game.selectedChartOptName = chartOptions[Game.selectedChartOptIndex]

end

function State_06ChartSelected.DownPressed()

	Game.selectedChartOptIndex = Game.selectedChartOptIndex + 1
	if Game.selectedChartOptIndex > #chartOptions then Game.selectedChartOptIndex = 1 end
	Game.selectedChartOptName = chartOptions[Game.selectedChartOptIndex]

end

function State_06ChartSelected.CenterPressed()

	if Game.selectedChartOptIndex == 1 then
		ResetState07()
		Game.state = 7
	elseif Game.selectedChartOptIndex == 2 then
		ResetState08()
		Game.state = 8
	end

end

function State_06ChartSelected.BackPressed()

	Game.selectedChartOptIndex = 0
	Game.selectedChartOptName = ""

	if Game.selectedSortName == "Full Display Mode" then
		-- then we will return to a "multiple-chart songwheel"
		Game.selectedChartIndex = 0
		Game.selectedChartName = ""
		Game.selectedChartDifficultyName = ""
		Game.selectedChartRecommendedSpeed = ""
		Game.state = 41
	else
		-- we will return to a "single-chart songwheel"
		Game.state = 42
	end

end









































-- DRAWING

function State_06ChartSelected.Drawing()
	local drawingX = 6
	local drawingY = Game.baseDrawingY
	local linebreakSize = 42

	-- background
	meckx_clearScreen({
		ColorName = "backgroundGray",
	})
	meckx_rect({
		XPos = 0,
		YPos = 0,
		Width = 1280,
		Height = 44,
		ColorName = "red",
		RectStyle = "fill",
		Transparency = 1,
	})

	-- contents
	local text = Game.selectedSongName
	local textSize = #text
	meckx_print({
		Text = Game.selectedSongName,
		XPos = drawingX+(((53-#text)/2)*24),
		YPos = drawingY-2,
		ColorName = "yellow",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_rect({
		XPos = 0,
		YPos = 44,
		Width = 1280,
		Height = 40,
		ColorName = FetchChartColorEnabled(Game.selectedSongName, Game.selectedChartName),
		RectStyle = "fill",
		Transparency = 1,
	})
	local text2 = Game.selectedChartDifficultyName .. " - " .. Game.selectedChartName .. " - [" .. Game.selectedChartRecommendedSpeed .. "]"
	meckx_print({
		Text = text2,
		XPos = drawingX+(((53-#text2)/2)*24),
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	meckx_print({
		Text = "----------------- 06. CHART OPTIONS -----------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	for i=1,#chartOptions,1 do
		meckx_print({
			Text = (i == Game.selectedChartOptIndex) and "> "..chartOptions[i] or chartOptions[i],
			XPos = (i == Game.selectedChartOptIndex) and drawingX or drawingX+24,
			YPos = drawingY,
			ColorName = "white",
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize
	end

	meckx_print({
		Text = "---------------------- RECORDS ----------------------",
		XPos = drawingX,
		YPos = drawingY,
		ColorName = "white",
		FontStyle = ClassicConsole_48,
	})
	drawingY = drawingY + linebreakSize

	local arrayOfRecords = FetchArrayOfRecords(Game.selectedPlayerName, Game.selectedSongName, Game.selectedChartName)

	for j=1,#arrayOfRecords do
		meckx_print({
			Text = "#"..j,
			XPos = drawingX+(1*24),
			YPos = drawingY,
			ColorName = "white",
			FontStyle = ClassicConsole_48,
		})

		local actualText = "-"
		local actualText2 = ""
		local actualTextP = ""
		local actualTextG = ""
		local actualTextD = ""
		local actualTextB = ""
		local actualTextM = ""
		local actualColor = "lightGray"
		local scoreObject = arrayOfRecords[j]
		if scoreObject then
			actualText = scoreObject.DisplayStars .. " " .. scoreObject.DisplayAccuracy
			actualText2 = scoreObject.Date .. " " .. scoreObject.Time
			actualTextP = string.format("%04d", scoreObject.Perfects)
			actualTextG = string.format("%04d", scoreObject.Greats)
			actualTextD = string.format("%04d", scoreObject.Goods)
			actualTextB = string.format("%04d", scoreObject.Bads)
			actualTextM = string.format("%04d", scoreObject.Misses)
			actualColor = FetchScoreColorOfThisScore(arrayOfRecords[j])
		end
		local textPos = 52-#actualText

		meckx_print({
			Text = actualText,
			XPos = drawingX+(textPos*24),
			YPos = drawingY,
			ColorName = actualColor,
			FontStyle = ClassicConsole_48,
		})
		drawingY = drawingY + linebreakSize

		meckx_print({
			Text = actualText2,
			XPos = drawingX+(6*24),
			YPos = drawingY,
			ColorName = actualColor,
			FontStyle = ClassicConsole_48,
		})
		meckx_print({ Text = "|", XPos = drawingX+(26*24), YPos = drawingY, ColorName = "white", FontStyle = ClassicConsole_48, })
		meckx_print({
			Text = actualTextP,
			XPos = drawingX+(27*24),
			YPos = drawingY,
			ColorName = "meckx_02Blue_light",
			FontStyle = ClassicConsole_48,
		})
		meckx_print({ Text = "|", XPos = drawingX+(31*24), YPos = drawingY, ColorName = "white", FontStyle = ClassicConsole_48, })
		meckx_print({
			Text = actualTextG,
			XPos = drawingX+(32*24),
			YPos = drawingY,
			ColorName = "meckx_03Green_light",
			FontStyle = ClassicConsole_48,
		})
		meckx_print({ Text = "|", XPos = drawingX+(36*24), YPos = drawingY, ColorName = "white", FontStyle = ClassicConsole_48, })
		meckx_print({
			Text = actualTextD,
			XPos = drawingX+(37*24),
			YPos = drawingY,
			ColorName = "meckx_04Yellow_light",
			FontStyle = ClassicConsole_48,
		})
		meckx_print({ Text = "|", XPos = drawingX+(41*24), YPos = drawingY, ColorName = "white", FontStyle = ClassicConsole_48, })
		meckx_print({
			Text = actualTextB,
			XPos = drawingX+(42*24),
			YPos = drawingY,
			ColorName = "meckx_01Pink_light",
			FontStyle = ClassicConsole_48,
		})
		meckx_print({ Text = "|", XPos = drawingX+(46*24), YPos = drawingY, ColorName = "white", FontStyle = ClassicConsole_48, })
		meckx_print({
			Text = actualTextM,
			XPos = drawingX+(47*24),
			YPos = drawingY,
			ColorName = "meckx_06Red_light",
			FontStyle = ClassicConsole_48,
		})
		meckx_print({ Text = "|", XPos = drawingX+(51*24), YPos = drawingY, ColorName = "white", FontStyle = ClassicConsole_48, })
		drawingY = drawingY + linebreakSize
	end
end











































return State_06ChartSelected