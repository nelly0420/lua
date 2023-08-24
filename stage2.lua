-- 아라 이동 예시 화면


local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local physics = require("physics")



local function onbackBtnRelease()
    composer.gotoScene("menu", "fade", 500)
    return true -- indicates successful touch
end

local function onbrokenRelease()
    composer.showOverlay('broken')
    return true -- indicates successful touch
end

local function onmossyRelease()
    composer.showOverlay('mossy')
    return true -- indicates successful touchrock
end


local function Ara(self, event)
    print("Collision event triggered")
    if event.phase == "ended" then
        if event.other.name == "wall" then
            print("Character collided with a wall")
            -- Handle wall collision if needed
        end
        if event.other.name == "mossy" then
            print("Character collided with trash")
        end
            -- Handle trash collision
        if event.other.name == "brokentree" then
            print("Character collided with trash")
        end
        if event.other.name == "piece" then
            print("Character collided with a piece")
            display.remove(event.other)  -- Remove the display object
            event.other.isBodyActive = false
        end
        
        
    end

    if event.phase == "began" then
        if event.other.name == "door" then
            print("Character collided with a door")
            timer.performWithDelay(1, function()
                composer.gotoScene("stage3")
            end)
        end
    end
end

local options = {
    isModal = true,
    effect = "fade",
    time = 400,
    params = {
        itemToShow = "ui/alpha.png" -- Replace with the actual path
    }
}

local playerOptions = {
    density = 1.0,
    friction = 0.5,
    bounce = 0.2
    -- ... other properties
}

local wallOptions = {
    density = 2.0,
    friction = 0.5,
    bounce = 0.2
}

local trashOptions = {
    density = 1.0,
    friction = 0.5,
    bounce = 0.3
    -- ... other properties
}

local doorOptions = {
    density = 1.0,
    friction = 0.5,
    bounce = 0.3
    -- ... other properties
}

-- Define collision filters for the new scene
local playerFilter = { categoryBits = 2, maskBits = 1 } -- Player's collision filter
local wallFilter = { categoryBits = 1, maskBits = 2 }
local doorFilter = { categoryBits = 1, maskBits = 2 }   -- Wall's collision filter
-- ... define filters for other objects if needed


function scene:create(event)
    local sceneGroup = self.view

    physics.start()
    physics.setGravity(0, 0)


    local background = display.newImageRect("ui/river.png",  display.actualContentWidth, display.actualContentHeight)
    background.anchorX = 0
    background.anchorY = 0

    local grass = display.newImageRect("ui/grass.png",1000, 500)
    grass.x = 605
    grass.y = 520

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

    local piece1 = widget.newButton {
        
        defaultFile = "ui/piece1.png",
        overFile = "ui/piece1C.png",
        width = 120,
        height = 150,
        onRelease = onbrokenRelease -- event listener function
    }
    piece1.x = display.contentCenterX -250
    piece1.y = display.contentHeight - 250
    
    local piece = display.newImageRect("ui/piece1.png",110,140)
    piece.x = display.contentCenterX -250
    piece.y = display.contentHeight - 250
    piece.name = "piece"
    physics.addBody(piece, "static", trashOptions)
    piece.collision = Ara
    piece:addEventListener("collision")


    local mossy = widget.newButton {
        
        defaultFile = "ui/mossy1.png",
        overFile = "ui/mossy1C.png",
        width = 130,
        height = 130,
        onRelease = onmossyRelease -- event listener function
    }
    mossy.x = display.contentCenterX +380
    mossy.y = display.contentHeight - 480
    
    local mossy1 = display.newImageRect("ui/mossy1.png",110,110)
    mossy1.x = display.contentCenterX +380
    mossy1.y = display.contentHeight - 480
    mossy1.name = "mossy"
    physics.addBody(mossy, "static", trashOptions)
    mossy1.collision = Ara
    mossy1:addEventListener("collision")

    local mossy2 = widget.newButton {
        
        defaultFile = "ui/mossy2.png",
        overFile = "ui/mossy2C.png",
        width = 140,
        height = 140,
        onRelease = onmossyRelease -- event listener function
    }
    mossy2.x = display.contentCenterX +180
    mossy2.y = display.contentHeight - 280
    
    local mossy3 = display.newImageRect("ui/mossy2.png",120,120)
    mossy3.x = display.contentCenterX +180
    mossy3.y = display.contentHeight - 280
    mossy3.name = "mossy"
    physics.addBody(mossy, "static", trashOptions)
    mossy3.collision = Ara
    mossy3:addEventListener("collision")

    local brokentree = widget.newButton {
        
        defaultFile = "ui/brokentree2.png",
        overFile = "ui/brokentree2C.png",
        width = 130,
        height = 130,
        onRelease = onbrokenRelease -- event listener function
    }
    brokentree.x = display.contentCenterX -50
    brokentree.y = display.contentHeight - 400
    
    local brokentree1 = display.newImageRect("ui/brokentree2.png",120,120)
    brokentree1.x = display.contentCenterX -50
    brokentree1.y = display.contentHeight - 400
    brokentree1.name = "brokentree"
    physics.addBody(brokentree1, "static", trashOptions)
    brokentree1.collision = Ara
    brokentree1:addEventListener("collision")

    local brokentree2 = widget.newButton {
        
        defaultFile = "ui/brokentree.png",
        overFile = "ui/brokentreeC.png",
        width = 150,
        height = 130,
        onRelease = onbrokenRelease -- event listener function
    }
    brokentree2.x = display.contentCenterX +80
    brokentree2.y = display.contentHeight - 600
    
    local brokentree3 = display.newImageRect("ui/brokentree.png",140,120)
    brokentree3.x = display.contentCenterX +80
    brokentree3.y = display.contentHeight - 600
    brokentree3.name = "brokentree"
    physics.addBody(brokentree3, "static", trashOptions)
    brokentree3.collision = Ara
    brokentree3:addEventListener("collision")


    local rock = widget.newButton {
        
        defaultFile = "ui/rock.png",
        overFile = "ui/rockC.png",
        width = 130,
        height = 130,
        onRelease = onbrokenRelease -- event listener function
    }
    rock.x = display.contentCenterX -150
    rock.y = display.contentHeight -480
    
    local rock1 = display.newImageRect("ui/rock.png",100,100)
    rock1.x = display.contentCenterX -150
    rock1.y = display.contentHeight -480
    rock1.name = " rock"
    physics.addBody(rock1, "static", trashOptions)
    rock1.collision = Ara
    rock1:addEventListener("collision")

    local setting = display.newText("item", display.contentCenterX-300, display.contentHeight-65)
	setting.size = 45
	setting:setFillColor(1)

	function setting:tap( event )
		composer.showOverlay("itempop", options)
	end
	setting:addEventListener("tap", setting)


    local player_outline_none = graphics.newOutline(1, "ui/s4Ara.png")
    player = display.newImageRect("ui/s4Ara.png", 150, 125) -- Initialize the player object
    player.x, player.y = 100, 200
    player.name = "player"
    physics.addBody(player, "dynamic", playerOptions)
    player.collision = Ara
    player.filter = playerFilter
    player:addEventListener("collision")
    


    sceneGroup:insert(background)
    sceneGroup:insert(grass)
   
    sceneGroup:insert(rock1)
    sceneGroup:insert(rock)
    sceneGroup:insert(backBtn)
    sceneGroup:insert(player)
    sceneGroup:insert(setting)
    sceneGroup:insert(piece1)
    sceneGroup:insert(piece)
    sceneGroup:insert(mossy1)
    sceneGroup:insert(mossy)
    sceneGroup:insert(mossy3)
    sceneGroup:insert(mossy2)
    sceneGroup:insert(brokentree1)
    sceneGroup:insert(brokentree)
    sceneGroup:insert(brokentree3)
    sceneGroup:insert(brokentree2)
    
    

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
        transition.to(player, {time = 100, y = y - 40})
        elseif (event.target.name == "down") then
        transition.to(player, {time = 100, y = y + 40})
        elseif (event.target.name == "left") then
            if currentDirection == "right" then
                player:scale(-1, 1)
                currentDirection = "left"
            end
        transition.to(player, {time = 100, x = x - 40})
        elseif (event.target.name == "right") then
            if currentDirection == "left" then
                player:scale(-1, 1)
                currentDirection = "right"
            end
        transition.to(player, {time = 100, x = x + 40})
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
    wall[4] = display.newImageRect("ui/wall2.jpg", 2000, 30)
    wall[4].x = 260
    wall[4].y = 13
  
    
    for i = 1, #wall do
        physics.addBody(wall[i], "static", wallOptions)
        wall[i].name = "wall"
        wall[i].alpha = 0 
        wall[i].collision = Ara
        wall[i].filter = wallFilter
        wall[i]:addEventListener("collision")
        sceneGroup:insert(wall[i])
    end

    local door = display.newImageRect("ui/pipe.png", 50, 180)
    door.x = 1255
    door.y = 635
    door.name = "door"
    physics.addBody(door, "static", doorOptions)
    door.collision = Ara
    door.filter = doorFilter
    door:addEventListener("collision")
    sceneGroup:insert(door)

end

    


function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        physics.start()
        
    elseif phase == "did" then
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then  
        physics.pause()  
    elseif phase == "did" then
        physics.start()
        composer.removeScene("stage2")
        
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
