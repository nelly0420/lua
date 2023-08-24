
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals

local saveBtn
local setBtn
local backBtn


-- 'onRelease' event listener for playBtn
local function onsaveBtnRelease()
	
	-- go to level1.lua scene
	--composer.gotoScene( "level1", "fade", 500 )
	

	return true	-- indicates successful touch
	
end



local function onbackBtnRelease()
	
	-- go to level1.lua scene
	composer.gotoScene( "menu", "fade", 500 )
	
	return true	-- indicates successful touch
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "image/title_ex.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newImageRect( "image/logo.png", display.actualContentWidth, display.actualContentHeight )
	titleLogo.x = display.contentCenterX
	titleLogo.y = 100
	
	

	-- create a widget button (which will loads level1.lua on release)
	soundBtn = widget.newButton{
		label = "▶ 세이브 기록",
		labelColor = { default={ 1.0 }, over={ 0.5 } },
		defaultFile = "ui/btn_nil.png",
		overFile = "ui/btn_nil.png",
		width = 154, height = 60,
		onRelease = onsoundBtnRelease	-- event listener function
	}
	soundBtn.x = display.contentCenterX - 550
	soundBtn.y = display.contentHeight - 330
	


	backBtn = widget.newButton{
		label = "▶돌아가기",
		labelColor = { default={ 1.0 }, over={ 0.5 } },
		defaultFile = "ui/btn_nil.png",
		overFile = "ui/btn_nil.png",
		width = 154, height = 60,
		onRelease = onbackBtnRelease	-- event listener function
	}
	backBtn.x = display.contentCenterX - 550
	backBtn.y = display.contentHeight - 230

	

	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( soundBtn )
	sceneGroup:insert( backBtn )
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
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene

