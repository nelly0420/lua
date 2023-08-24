-- 화면 클릭

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local json = require("json")

local function onbackBtnRelease()
    composer.gotoScene("menu", "fade", 500)
    return true -- indicates successful touch
end

local function ontreeRelease()
    composer.showOverlay('tree')
    return true -- indicates successful touch
end

local function onfrogRelease()
    composer.showOverlay('frog')
    return true -- indicates successful touch
end

local function onpieceRelease()
    composer.showOverlay('piece')
    return true -- indicates successful touch
end



local function Ara(self, event)
    print("Collision event triggered")
    if event.phase == "began" then
        if event.other.name == "tree" then
            print("Character collided with a tree")
            composer.gotoScene("prolog4", "fade", 500)
        end
    end
end

local playerOptions = {
    density = 1.0,
    friction = 0.5,
    bounce = 0.2,
    -- ... other properties
}

local treeOptions = {
    density = 2.0,
    friction = 0.5,
    bounce = 0.2,
    filter = { categoryBits = 2, maskBits = 1 } -- Adjust maskBits accordingly
    -- ... other properties
}

function scene:create(event)
    local sceneGroup = self.view

    physics.start()
    physics.setGravity(0, 0)


    local background = display.newImageRect("ui/mossylake2.png",  display.actualContentWidth, display.actualContentHeight)
    background.anchorX = 0
    background.anchorY = 0



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

    local tree = widget.newButton {
        
        defaultFile = "ui/bigtree.png",
        overFile = "ui/bigtreeC.png",
        width = 100,
        height = 840,
        onRelease = ontreeRelease -- event listener function
    }
    tree.x=display.contentCenterX - 520
    tree.y= display.contentHeight - 300
    tree.alpha = 0.01 

    local tree2 = display.newRect(display.contentCenterX - 520,display.contentHeight - 300,130,840)
    tree2:setFillColor(0, 0, 0, 0)  -- Make the collider transparent
    tree2.alpha = 0.01 
    physics.addBody(tree2, "static", treeOptions)
    tree2.name = "tree"
    tree2.collision = Ara
    tree2:addEventListener("collision")

    local tree3 = display.newImageRect("ui/bigtree.png",850,840)
    tree3.x= display.contentCenterX - 220
    tree3.y= display.contentCenterX - 220
   

    local frog = widget.newButton {
        
        defaultFile = "ui/frog.png",
        overFile = "ui/frogC.png",
        width = 85,
        height = 100,
        onRelease = onfrogRelease -- event listener function
    }
    frog.x = display.contentCenterX - 300
    frog.y = display.contentHeight - 330

    local piece = widget.newButton {
        
        defaultFile = "ui/piece.png",
        overFile = "ui/pieceC.png",
        width = 380,
        height = 400,
        onRelease = onpieceRelease -- event listener function
    }
    piece.x = display.contentCenterX + 480
    piece.y = display.contentHeight - 330


    local piece2 = display.newImageRect("ui/piece.png",480,500)
    piece2.x = display.contentCenterX + 480
    piece2.y = display.contentHeight - 330



    sceneGroup:insert(background)
    sceneGroup:insert(tree2)
    sceneGroup:insert(tree3)
    sceneGroup:insert(tree)
    sceneGroup:insert(piece)
    sceneGroup:insert(piece2)
    sceneGroup:insert(frog)
    sceneGroup:insert(backBtn)
    

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
    player = display.newImageRect("ui/player.png", 270, 270) -- Initialize the player object
    player.x, player.y = 600, 600
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
        composer.removeScene("prolog3")
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
