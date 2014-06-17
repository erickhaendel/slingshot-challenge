local physics = require("physics")
physics.start()

physics.setScale( 40 )

-- Hide Status Bar
display.setStatusBar(display.HiddenStatusBar)

local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight

-- Graphics

local bg = display.newImage('bg.png')
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local sky = display.newImage('sky.png')
sky.x = display.contentCenterX
sky.y = display.contentCenterY - 160

local grass = display.newImage('grass.png')
grass.x = display.contentCenterX
grass.y = display.contentCenterY + 350
physics.addBody( grass, "static", { friction=0.5, bounce=0.3 } )

-- [Title View]
local playBtn
local titleView

local stone

local slingshot

local wall = display.newImage('wall.png', display.contentCenterX, display.contentCenterY+20)	
physics.addBody( wall, "static",{ density=882.0, friction=880.3, bounce=0.4 } )	

local cans = {}

-- Score

local score

-- Alert

local alertView

-- Sounds

local pong = audio.loadSound('pong.mp3')

-- Variables

local scoreTF
local scale = 1.1
local variation = 0.05
local stoneX = 0
local stoneY = 0
local stoneVar = 0.5

-- Functions

local Main = {}
local startButtonListeners = {}
local showGameView = {}
local gameListeners = {}
local startGame = {}
local hitTestObjects = {}
local update = {}
local moveStone = {}
local alert = {}

-- Main Function

function Main()
	playBtn = display.newImage('playBtn.png', display.contentCenterX, display.contentCenterY)
	titleView = display.newGroup( playBtn)
	
	startButtonListeners('add')
end

function startButtonListeners(action)
	if(action == 'add') then
		playBtn:addEventListener('tap', showGameView)
		print( "oi1" )
	else
		print( "oi2" )
		playBtn:removeEventListener('tap', showGameView)
	end
end

local function resetStone()
	stone.bodyType = "static"
	stone.x = display.contentCenterX
	stone.y = display.contentHeight
	stone:setLinearVelocity( 0, 0 ) -- stop stone moving
	stone.angularVelocity = 0 -- stop stone rotating
end

function showGameView:tap(e)
	transition.to(
		titleView, {
			time = 300, 
			x = -titleView.height, 
			onComplete = function() 
				startButtonListeners('rmv') 
				display.remove(titleView) 
				titleView = nil 
				bg:addEventListener('tap', startGame) 
			end})
	
	-- [Add GFX]

	local M = 6
	for i = 1, 6 do
		for j = 1, M do
		cans[M*(i-1) + j] = display.newImage( "can.png", display.contentCenterX - 50 + (i*24), display.contentCenterY - 100 - (j*40) )
		physics.addBody( cans[M*(i-1) + j], { density=0.10, friction=0.1, bounce=0.5 } )
		end
	end

	-- Slingshot	
	slingshot = display.newImage('slingshot.png', display.contentCenterX, display.contentHeight)

	-- Stone
	stone = display.newImage('stone.png', display.contentCenterX, display.contentHeight)

	-- Score
	score = display.newImage('score.png', display.contentCenterX*1.30, display.contentCenterY*0.07)
	scoreTF = display.newText('0', display.contentCenterX*1.70, display.contentCenterY*0.07, 'Marker Felt', 30)
	scoreTF:setTextColor(238, 238, 238)
	
	gameListeners('add')
end

function gameListeners(action)

	-- 
	if(action == 'add') then
		bg:addEventListener('touch', moveStone)
	-- 
	else
		bg:removeEventListener('touch', moveStone)
		Runtime:removeEventListener('enterFrame', update)
	end
end

function startGame()
	bg:removeEventListener('tap', startGame)
	Runtime:addEventListener('enterFrame', update)
end

-- descobri a direcao da bola em relacao a raquete
function hitTestObjects(obj1, obj2)
        local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
        local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
        local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
        local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
        return (left or right) and (up or down)
end

local hit = 0

function update()

	if hit == 0 then
		for i=1,36 do
			if (hitTestObjects(stone, cans[i])) then
				physics.addBody( stone, { density=1000.20, friction=0.1, bounce=0.5 } )
				stone:removeSelf()				
				hit = 1				
			end
		end
	end


	if hit == 0 then
		-- Scale Balls
		scale = scale - variation
		stone.xScale = scale
		stone.yScale = scale

		-- Move Ball
		stone.x = stone.x - stoneX
		stone.y = stone.y - 20
	end
end

function moveStone(e)
	print( e.phase )

	if (e.stone == "began") then

	elseif(e.stone == 'moved') then -- moved

	elseif(e.phase == "ended") then
		
	end

	stone.x = e.x
	stone.y = e.y

end

Main()