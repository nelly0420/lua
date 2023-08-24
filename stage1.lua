-- 아라 이동 예시 화면


local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local json = require("json")
local physics = require("physics")

local playerLife = 3 

local function onbackBtnRelease()
    composer.gotoScene("menu", "fade", 500)
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

local heart = {}



local function updateHeartsDisplay()
    for i = 1, 3 do
        if i <= playerLife then
            heart[i].isVisible = true
        else
            heart[i].isVisible = false
        end
    end

    if playerLife <= 0 then
        composer.gotoScene("ending")
    end
end


local function handleCollision(event)
    local function deferredCollisionHandler()
        local phase = event.phase
        

        if phase == "began" then
            
            if event.other.name == "trash" then
                -- Handle trash collision
                event.other:removeSelf()  -- Use event.other instead of other
                if playerLife > 0 then
                    playerLife = playerLife - 1
                    updateHeartsDisplay()
                end
            end
            
            if event.other.name == "door" then
                print("Collided with door")
                composer.gotoScene("stage2")
            end
        end
    end

    timer.performWithDelay(1, deferredCollisionHandler) -- Introduce a delay to ensure safe deferred handling
    return true
end




local playerOptions = {
    density = 1.0,
    friction = 0.5,
    bounce = 0.2
    -- ... other properties
}

local wallOptions = {
    density = 2.0,
    friction = 0.5,
    bounce = 0.2,
    
    -- ... other properties
}

local trashOptions = {
    density = 0.5,
    friction = 0.3,
    bounce = 0.2
    -- ... other properties
}

local doorOptions = {
    density = 1.0,
    friction = 0.5,
    bounce = 0.3,
    
    -- ... other properties
}

function scene:create(event)
    local sceneGroup = self.view


    physics.start()
    physics.setGravity(0, 0)


    local background = display.newImageRect("ui/river.png",  display.actualContentWidth, display.actualContentHeight)
    background.anchorX = 0
    background.anchorY = 0

    local randomplace = display.newImageRect("ui/null.png",  display.actualContentWidth-200, display.actualContentHeight-150)
    randomplace.x = display.contentCenterX +100
    randomplace.y = display.contentHeight -350
    randomplace.alpha = 0

   
   
    local grass = display.newImageRect("ui/grass.png",800, 400)
    grass.x = 615
    grass.y = 470

   
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

    local setting = display.newText("item", display.contentCenterX-300, display.contentHeight-65)
	setting.size = 45
	setting:setFillColor(1)

    function setting:tap( event )
		composer.showOverlay("itempop", options)
	end
	setting:addEventListener("tap", setting)
 

    sceneGroup:insert(background)
    sceneGroup:insert(randomplace)
    sceneGroup:insert(grass)
    sceneGroup:insert(backBtn)

    for i = 1, 3 do
        heart[i] = display.newImageRect("image/heart.jpg", 60, 60)
        heart[i].x = display.contentCenterX + (i-1) * 70
        heart[i].y = display.contentHeight - 680
        sceneGroup:insert(heart[i])  -- Insert each heart into the sceneGroup
    end
   
    
    
    local object

    local randomObjectsGroup = display.newGroup()  -- Create a group for random objects
    sceneGroup:insert(randomObjectsGroup)
    
    local function createRandomObjects()
        local minObjects = 5  -- Minimum number of objects
        local maxObjects = 9  -- Random number of objects between 4 and 12
    
        local minX = randomplace.x - randomplace.width/2 + 10
        local maxX = randomplace.x + randomplace.width/2  - 60
        local minY = randomplace.y - randomplace.height/2 + 10
        local maxY = randomplace.y + randomplace.height/2 - 60
    
        -- Generate the minimum number of objects
        for i = minObjects, maxObjects do
            local objectType = math.random(1, 2)  -- Choose between 1 and 2
            local randomX = math.random(minX, maxX)
            local randomY = math.random(minY, maxY)
    
            local object
    
            if objectType == 1 then
                -- Create a random rectangle
                object = display.newImageRect("ui/mossy1.png",60, 60)
            else
                -- Create a random image (you need to provide your image file)
                object = display.newImageRect("ui/brokentree.png", 75, 75)
            end
    
            physics.addBody(object, "static", trashOptions)
            object.name = "trash"
            object.x = randomX
            object.y = randomY
            object.rotation = math.random(360)  -- Set a random rotation
            -- Set a random transparency
            
            randomObjectsGroup:insert(object)  -- Insert the object into the random objects group
        end
    end
    
    -- Call the function to create random objects
    createRandomObjects()
    
    -- ... (other code)
    
    -- Move this line after the createRandomObjects function call
    sceneGroup:insert(setting)
    setting:toFront()

    local timeValue = 10 -- Initialize the time value

    local timeText = display.newText({
        text = tostring(timeValue),
        x = display.contentWidth * 0.96,
        y = display.contentHeight * 0.05,
        font = native.systemFont,
        fontSize = 50
    })
    timeText:setFillColor(0, 0, 0, 0.5)  -- Use the fill color for the text
    sceneGroup:insert(timeText)
    
    local function counter(event)
        if composer.getSceneName("current") == "stage1" then  -- Check if current scene is "stage1"
            timeValue = timeValue - 1
            timeText.text = tostring(timeValue)  -- Update the text in timeText
            
            if timeValue == 5 then
                timeText:setFillColor(1, 0, 0)  -- Change text color using setFillColor
            end
    
            if timeValue == -1 then
                timeText.alpha = 0
                composer.gotoScene("ending")
            end
        end
    end
    
    
    timeAttack = timer.performWithDelay(1000, counter, 11)
    

   
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
	   
    local player_outline_none = graphics.newOutline(1, "ui/s4Ara.png")
    player = display.newImageRect("ui/s4Ara.png", 150, 125) -- Initialize the player object
    player.x, player.y = 100, 200
    player.name = "player"
    physics.addBody(player, "dynamic", playerOptions)
    player:addEventListener("collision",handleCollision)
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

    local door = display.newImageRect("ui/pipe.png", 50, 180)
    door.x = 1255
    door.y = 635
    door.name = "door"
    physics.addBody(door, "static", doorOptions)
    door:addEventListener("collision",handleCollision)
    sceneGroup:insert(door)


	
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
        wall[i].alpha = 0.01 
        wall[i]:addEventListener("collision",handleCollision)
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
        
        composer.removeScene("stage1")

        if randomObjectsGroup then
            randomObjectsGroup:removeSelf()
            randomObjectsGroup = nil
        end
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
