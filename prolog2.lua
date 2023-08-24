-- 아라 이동 예시 화면


local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local json = require("json")
local physics = require("physics")



local function onbackBtnRelease()
    composer.gotoScene("menu", "fade", 500)
    return true -- indicates successful touch
end

local function onnextBtnRelease()
    composer.gotoScene("prolog3", "fade", 500)
    return true -- indicates successful touch
end

local options = {
    isModal = true,
    effect = "fade",
    time = 400,
    params = {
        itemToShow = "ui/alpha.png" -- Replace with the actual path
    }
}



local function Ara(self, event)
    print("Collision event triggered")
    if event.phase == "ended" then
        if event.other.name == "wall" then
            print("Character collided with a wall")
            
            timer.performWithDelay(500, function()
                physics.removeBody(event.other)

                player.y = player.y - 1
            end)
        end
    end
end

local playerOptions = {
    density = 1.0,
    friction = 0.5,
    bounce = 0.2,
    -- ... other properties
}

local wallOptions = {
    density = 2.0,
    friction = 0.5,
    bounce = 0.2,
    filter = { categoryBits = 2, maskBits = 1 }, -- Adjust maskBits accordingly
    -- ... other properties
}

function scene:create(event)
    local sceneGroup = self.view

    physics.start()
    physics.setGravity(0, 0)
    

    local dialog = display.newGroup()

    local background = display.newRect(dialog, 0, 0, display.actualContentWidth, display.actualContentHeight)
    background.anchorX = 0
    background.anchorY = 0

    local textbox = display.newRect(dialog, display.contentCenterX, display.contentHeight - 110, 1280, 300)

    local speaker = display.newText(dialog, "", display.contentWidth * 0.45, display.contentHeight * 0.84, display.contentWidth - 180, 150)
    speaker:setFillColor(0, 0, 0)
    speaker.size = 43
    speaker.alignX = "center"

    local content = display.newText(dialog, "", display.contentWidth * 0.65, display.contentHeight * 0.1, display.actualContentWidth - 180, -120)
    content:setFillColor(1, 1, 1) -- Set the fill color to black
    content.size = 37
    content.alignX = "center"

    local Data = jsonParse("json/prolog2.json")

    local index = 0

    local function nextScript(event)
        index = index + 1
        if (index > #Data) then
			display.remove(content)
            return
        end

        background.fill = {
            type = "image",
            filename = Data[index].background
        }
        textbox.fill = {
            type = "image",
            filename = Data[index].textbox
        }
        speaker.text = Data[index].speaker
        content.text = Data[index].content
       
        
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

    local nextBtn = widget.newButton {
        label = "▶다음",
        defaultFile = "ui/btn_nil.png",
        overFile = "ui/btn_nil.png",
        width = 154,
        height = 60,
        onRelease = onnextBtnRelease -- event listener function
    }
    nextBtn.x = display.contentCenterX + 550
    nextBtn.y = display.contentHeight - 700

    local setting = display.newText("item", display.contentCenterX-300, display.contentHeight-65)
	setting.size = 45
	setting:setFillColor(1)

	function setting:tap( event )
		composer.showOverlay("itempop", options)
	end
	setting:addEventListener("tap", setting)


    sceneGroup:insert(dialog)

   
    

    sceneGroup:insert(backBtn)
    sceneGroup:insert(nextBtn)
    sceneGroup:insert(setting)

    local arrow = {}
	arrow[1] = display.newImageRect("image/arrow_left.png", 38, 64)
	arrow[1].x, arrow[1].y = 50,600
	arrow[1].name = "left"
	arrow[2] = display.newImageRect("image/arrow_up.png", 60, 64)
	arrow[2].x, arrow[2].y = arrow[1].x+86, 510
	arrow[2].name = "up"
	arrow[3] = display.newImageRect("image/arrow_right.png", 38, 64)
	arrow[3].x, arrow[3].y = arrow[2].x+86, 600
	arrow[3].name = "right"
    arrow[4] = display.newImageRect("image/arrow_down.png", 55, 64)
	arrow[4].x, arrow[4].y = arrow[1].x+86, 690
	arrow[4].name = "down"
    arrow[5] = display.newImageRect("image/arrow_center.png", 84, 84)
	arrow[5].x, arrow[5].y = arrow[1].x+86, 600
	arrow[5].name = "dash"
    

	arrow[6] = "right"    -- 토끼의 방향 정보
	   
    local player_outline_none = graphics.newOutline(1, "ui/player.png")
    player = display.newImageRect("ui/player.png", 250, 250) -- Initialize the player object
    player.x, player.y = 500, 500
    player.name = "player"
    physics.addBody(player, "dynamic", playerOptions)
    player.collision = Ara
    player:addEventListener("collision")
    sceneGroup:insert(player)

    local isDashing = false  -- Flag to track if the player is currently dashing

    local function dash(direction)
        if not isDashing then
            local x, y = player.x, player.y
            local dashDistance = 100  -- Set your desired dash distance
    
            if (direction == "left") then
                transition.to(player, {time = 50, x = x - dashDistance})
            elseif (direction == "right") then
                transition.to(player, {time = 50, x = x + dashDistance})
            elseif (direction == "up") then
                transition.to(player, {time = 50, y = y - dashDistance})
            elseif (direction == "down") then
                transition.to(player, {time = 50, y = y + dashDistance})
            end
    
            isDashing = true
    
            timer.performWithDelay(300, function()
                isDashing = false
            end)
        end
    end
    


    local currentDirection = "right"  -- Initialize the current direction

    function arrowTab(event)
        local x, y = player.x, player.y
    
        if (event.target.name == "up") then
        transition.to(player, {time = 100, y = y - 30})
        elseif (event.target.name == "down") then
        transition.to(player, {time = 100, y = y + 30})
        elseif (event.target.name == "left") then
            if currentDirection == "right" then
                player:scale(-1, 1)
                currentDirection = "left"
            end
        transition.to(player, {time = 100, x = x - 30})
        elseif (event.target.name == "right") then
            if currentDirection == "left" then
                player:scale(-1, 1)
                currentDirection = "right"
            end
        transition.to(player, {time = 100, x = x + 30})
        elseif (event.target.name == "dash") then
            dash(currentDirection)  -- Dash in the current direction
        end
    end

    for i = 1, 5 do
        arrow[i]:addEventListener("tap", arrowTab)
        sceneGroup:insert(arrow[i])
    end

	
    local wall = {}
    wall[1] = display.newImageRect("ui/wall2.jpg", 2000, 30)
    wall[1].x = 260
    wall[1].y = 720
    wall[2] = display.newImageRect("ui/wall.jpg", 30, 1000)
    wall[2].x = 8
    wall[2].y = 250
    wall[3] = display.newImageRect("ui/wall.jpg", 30, 1000)
    wall[3].x = 1275
    wall[3].y = 250
    
    
    for i = 1, #wall do
        physics.addBody(wall[i], "static", wallOptions)
        wall[i].name = "wall"
        wall[i].alpha = 0.01 
        wall[i].collision = Ara
        wall[i]:addEventListener("collision")
        sceneGroup:insert(wall[i])
    end
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
        composer.removeScene("prolog2")
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
