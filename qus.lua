-----------------------------------------------------------------------------------------
--
-- qus.lua
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")

local function onYesRelease()
    composer.gotoScene("stage1story")
    return true -- indicates successful touch
end

local function onNoRelease()
    composer.hideOverlay("qus")
    return true -- indicates successful touch
end

function scene:create( event )
    local sceneGroup = self.view

    local title = display.newText("아이템을 사용하시겠습니까?", display.contentWidth/2, display.contentHeight*0.3)
    title.size = 30

    local yesBtn = widget.newButton {
        label = "Yes",
        defaultFile = "ui/btn_nil.png",
        overFile = "ui/btn_nil.png",
        width = 154,
        height = 60,
        onRelease = onYesRelease -- Use the correct function name here
    }
    yesBtn.x = display.contentCenterX - 150
    yesBtn.y = display.contentHeight - 400

    local noBtn = widget.newButton {
        label = "NO",
        defaultFile = "ui/btn_nil.png",
        overFile = "ui/btn_nil.png",
        width = 154,
        height = 60,
        onRelease = onNoRelease -- Use the correct function name here
    }
    noBtn.x = display.contentCenterX + 130
    noBtn.y = display.contentHeight - 400

    sceneGroup:insert(title)
    sceneGroup:insert(yesBtn)
    sceneGroup:insert(noBtn)
end

-- The rest of your scene functions...



function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		composer.removeScene("qus")

	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene