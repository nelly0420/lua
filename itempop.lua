-----------------------------------------------------------------------------------------
--
-- itempop.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view
	
 	local background = display.newRoundedRect(display.contentWidth*0.55, display.contentHeight*0.9, display.contentWidth*0.4, display.contentHeight*0.13, 10)
 	background.strokeWidth = 10
	background:setStrokeColor( 0.4, 0.2, 0.2 )
 	background:setFillColor(0.6, 0.5, 0.5)
	sceneGroup:insert(background)

	local box = {}
	box[1] = display.newRect(display.contentWidth*0.50, display.contentHeight*0.9, display.contentWidth*0.05, display.contentHeight*0.09, 5)
	box[2] = display.newRect(display.contentWidth*0.58, display.contentHeight*0.9, display.contentWidth*0.05, display.contentHeight*0.09, 5)
	box[3] = display.newRect(display.contentWidth*0.66, display.contentHeight*0.9, display.contentWidth*0.05, display.contentHeight*0.09, 5)

	for i = 1, #box do
      
        box[i].name = "wall"
        box[i].alpha = 0.5 
        sceneGroup:insert(box[i])
    end

 	local title = display.newText("item", display.contentWidth/2.45, display.contentHeight*0.9)
 	title.size = 40

 	function title:tap( event )
		composer.hideOverlay('itempop')
 	end
 	title:addEventListener("tap", title)
 	sceneGroup:insert(title)

	local itemToShow = event.params.itemToShow

	local linkedItem = display.newImageRect(itemToShow, 60, 60)
	linkedItem.x = display.contentCenterX 
	linkedItem.y = display.contentHeight - 70
	sceneGroup:insert(linkedItem)

	local function onLinkedItemTouch(event)
        if event.phase == "ended" then
            -- Put your code here to handle the linked item's touch event
            print("Linked item was clicked!")
			composer.showOverlay('qus')
        end
        return true
    end

    -- Add a touch listener to the linked item
    linkedItem:addEventListener("touch", onLinkedItemTouch)
	 
end

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
		composer.removeScene("itempop")

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