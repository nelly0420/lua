-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local json = require "json"
local gameManager = require("gameManager")  -- Require your game manager module

local function onSystemEvent(event)
    if event.type == "applicationSuspend" or event.type == "applicationExit" then
        gameManager.autoSave()  -- Call the autoSave function from your game manager
    end
end

-- Add the system event listener
Runtime:addEventListener("system", onSystemEvent)

-- Initialize your game manager module
gameManager.init()

function jsonParse( src )
	local filename = system.pathForFile( src )
	
	local data, pos, msg
	data, pos, msg = json.decodeFile(filename)

	-- 디버깅
	if data then
		return data
	else
		print("WARNING: " .. pos, msg)
		return nil
	end
end
-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"

-- load menu screen
composer.gotoScene( "stage2" )



