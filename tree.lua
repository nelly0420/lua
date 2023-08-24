-- 화면 클릭

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local json = require("json")



local function ontreeRelease()
    composer.showOverlay('tree')
    return true -- indicates successful touch
end


function scene:create(event)
    local sceneGroup = self.view


    

    local textbox = display.newImageRect("ui/dialog.png", display.contentCenterX+630, display.contentHeight - 500)
    textbox.x = 640
    textbox.y = 610


    local speaker = display.newText( "나무 한 그루...", display.contentWidth * 0.45, display.contentHeight * 0.85, display.contentWidth - 180, 150)
    speaker:setFillColor(0, 0, 0)
    speaker.size = 43
    speaker.alignX = "left"

    local content = display.newText( "관리되지 않아서 나뭇잎이 무성해졌다. 낡은 유원지와 어울리지 않게 여전히 파릇파릇하지만, 녹색 이파리들이 무서울 정도로 크다.", display.contentWidth * 0.45, display.contentHeight * 0.87, display.actualContentWidth - 180, -120)
    content:setFillColor(0, 0, 0) -- Set the fill color to black
    content.size = 37
    content.alignX = "left"

   
    function textbox:tap( event )
		composer.hideOverlay('tree')
 	end
 	textbox:addEventListener("tap", textbox)


   
    
   
    sceneGroup:insert(textbox)
    sceneGroup:insert(speaker)
    sceneGroup:insert(content)
   
    
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
    elseif phase == "did" then
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
    elseif phase == "did" then
        composer.removeScene("tree")
    end
end

function scene:destroy(event)
    local sceneGroup = self.view
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
