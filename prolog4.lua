-- 화면 클릭

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local json = require("json")

local function onbackBtnRelease()
    composer.gotoScene("menu", "fade", 500)
    return true -- indicates successful touch
end



function scene:create(event)
    local sceneGroup = self.view

    local dialog = display.newGroup()

    local background = display.newRect(dialog, 0, 0, display.actualContentWidth, display.actualContentHeight)
    background.anchorX = 0
    background.anchorY = 0

    local textbox = display.newRect(dialog, display.contentCenterX, display.contentHeight - 110, 1280, 300)
    local profile = display.newRect(dialog, display.contentCenterX-450, display.contentHeight - 110, 300, 280)

    local speaker = display.newText(dialog, "", display.contentWidth * 0.56, display.contentHeight * 0.80, display.contentWidth - 180, 150)
    speaker:setFillColor(0, 0, 0)
    speaker.size = 42
    speaker.alignX = "left"

    local content = display.newText(dialog, "", display.contentWidth * 0.56, display.contentHeight * 0.84, display.actualContentWidth - 180, -120)
    content:setFillColor(0, 0, 0) -- Set the fill color to black
    content.size = 35
    content.alignX = "left"

    

    local Data = jsonParse("json/prolog4.json")

    local index = 0
    
    local eff 

    local function loadEff(filename)
        if filename and filename ~= "" then
            eff = audio.loadSound(filename)
        else
            eff = nil
        end
    end

   

    local function nextScript(event)
        index = index + 1
        if (index > #Data) then
            composer.gotoScene("prolog5")
            return
        end

        background.fill = {
            type = "image",
            filename = Data[index].background
        }
        textbox.fill = {
            type = "image",
            filename = "ui/dialog.png"
        }
        profile.fill = {
            type = "image",
            filename = Data[index].profile
        }
        speaker.text = Data[index].speaker
        content.text = Data[index].content

        loadEff(Data[index].eff)

        if eff then
            audio.play(eff)
        end
    end

    dialog:addEventListener("tap", nextScript)
    nextScript()

    local backBtn = widget.newButton {
        label = "▶돌아가기",
        defaultFile = "ui/btn_nil.png",
        overFile = "ui/btn_nil.png",
        width = 154,
        height = 60,
        onRelease = onbackBtnRelease -- event listener function
    }
    backBtn.x = display.contentCenterX - 550
    backBtn.y = display.contentHeight - 700

    
    sceneGroup:insert(dialog)
    sceneGroup:insert(backBtn)
    
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
        composer.removeScene("prolog4")
        audio.pause(eff)
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
