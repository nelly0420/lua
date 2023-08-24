local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

-- Load the background music
local backgroundMusic = audio.loadStream("effect/wave.mp3")

-- Play the background music (loops indefinitely)
local bgmChannel = audio.play(backgroundMusic, { loops = -1 })

--------------------------------------------

-- forward declarations and other locals
local playBtn
local saveBtn
local setBtn
local endBtn

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
    -- go to level1.lua scene
    composer.gotoScene( "intro", "fade", 500 )
    return true    -- indicates successful touch
end

local function onsetBtnRelease()
    composer.showOverlay('setting')
    return true
end

local function onsaveBtnRelease()
    -- go to level1.lua scene
    composer.showOverlay( 'save' )
    return true    -- indicates successful touch
end

local function onendBtnRelease()
    -- go to level1.lua scene
    os.exit()
    return true    -- indicates successful touch
end

function scene:create( event )
    local sceneGroup = self.view

    -- display a background image
    local background = display.newImageRect( "ui/title.png", display.actualContentWidth, display.actualContentHeight )
    background.anchorX = 0
    background.anchorY = 0
    background.x = 0 + display.screenOriginX 
    background.y = 0 + display.screenOriginY
    
    -- create/position logo/title image on upper-half of the screen
    local titleLogo = display.newImageRect("ui/logo.png", 600, 300) -- Adjust the size as per your logo dimensions
    titleLogo.x = display.contentCenterX-350
    titleLogo.y = 150 -- Adjust the Y position as needed
    
    -- create a widget button (which will load level1.lua on release)
    playBtn = widget.newButton{
        defaultFile = "ui/btn_start.png",
        overFile = "ui/btn_start.png",
        width = 154, height = 60,
        onRelease = onPlayBtnRelease    -- event listener function
    }
    playBtn.x = display.contentCenterX - 540
    playBtn.y = display.contentHeight - 350
    
    saveBtn = widget.newButton{
        defaultFile = "ui/btn_save.png",
        overFile = "ui/btn_save.png",
        width = 154, height = 60,
        onRelease = onsaveBtnRelease    -- event listener function
    }
    saveBtn.x = display.contentCenterX - 540
    saveBtn.y = display.contentHeight - 250
    
    setBtn = widget.newButton{
        defaultFile = "ui/btn_set.png",
        overFile = "ui/btn_set.png",
        width = 154, height = 60,
        onRelease = onsetBtnRelease    -- event listener function
    }
    setBtn.x = display.contentCenterX - 540
    setBtn.y = display.contentHeight - 150
    
    endBtn = widget.newButton{
        defaultFile = "ui/btn_end.png",
        overFile = "ui/btn_end.png",
        width = 154, height = 60,
        onRelease = onendBtnRelease    -- event listener function
    }
    endBtn.x = display.contentCenterX - 540
    endBtn.y = display.contentHeight - 50

    -- all display objects must be inserted into group
    sceneGroup:insert( background )
    sceneGroup:insert( titleLogo )
    sceneGroup:insert( playBtn )
    sceneGroup:insert( saveBtn )
    sceneGroup:insert( setBtn )
    sceneGroup:insert( endBtn )
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
    elseif phase == "did" then
        -- Called when the scene is now on screen
        
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc.
    end    
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    
    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.
    elseif phase == "did" then
        composer.removeScene("menu")
    end    
end

function scene:destroy( event )
    local sceneGroup = self.view
    
    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc.
    
    if playBtn then
        playBtn:removeSelf()    -- widgets must be manually removed
        playBtn = nil
    end
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
