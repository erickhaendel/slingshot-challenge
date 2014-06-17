-- gameplay

display.setStatusBar(display.HiddenStatusBar)

-- Graphics

-- [Background]

local bg = display.newImage('resources/images/textures/scenario/skybox.png')
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local playBtn

-- Instructions

local ins

-- Paddle

local paddle
local paddleTop
local paddleBottom

-- Ball

local ball

-- Score

local score

-- Alert

local alertView


local scoreTF
local scale = 1.1
local variation = 0.05
local ballX = 0
local ballY = 0
local ballVar = 0.5

-- Functions

local Main = {}
local startButtonListeners = {}
local showGameView = {}
local gameListeners = {}
local startGame = {}
local hitTestObjects = {}
local update = {}
local movePaddle = {}
local alert = {}

-- Main Function

function Main()

	playBtn = display.newImage('resources/images/button/play.png', display.contentCenterX, display.contentCenterY)

	titleView = display.newGroup(playBtn)
	
	startButtonListeners('add')
end

function startButtonListeners(action)
	if(action == 'add') then
		playBtn:addEventListener('tap', showGameView)
	else
		playBtn:removeEventListener('tap', showGameView)
	end
end

function showGameView:tap(e)
	transition.to(titleView, {time = 300, x = -titleView.height, onComplete = function() startButtonListeners('rmv') display.remove(titleView) titleView = nil bg:addEventListener('tap', startGame) end})
	
	-- [Add GFX]
	
	-- Instructions
	
	ins = display.newImage('ins.png', display.contentCenterX, display.contentCenterY*1.50)
	
	-- Paddle
	
	paddleBottom = display.newImage('paddleBottom.png', display.contentCenterX, display.contentCenterY+73)
	paddleTop = display.newImage('paddleTop.png', display.contentCenterX, display.contentCenterY)
	paddle = display.newGroup(paddleBottom, paddleTop)
	
	-- Ball
	
	ball = display.newImage('ball.png', display.contentCenterX, display.contentCenterY)
	ball:scale(scale, scale)
	
	-- Score
	
	score = display.newImage('score.png', display.contentCenterX*1.30, display.contentCenterY*0.07)
	scoreTF = display.newText('0', display.contentCenterX*1.70, display.contentCenterY*0.07, 'Marker Felt', 30)
	scoreTF:setTextColor(238, 238, 238)
	
	gameListeners('add')
end

function gameListeners(action)
	if(action == 'add') then
		bg:addEventListener('touch', movePaddle)
	else
		bg:removeEventListener('touch', movePaddle)
		Runtime:removeEventListener('enterFrame', update)
	end
end

function startGame()
	display.remove(ins)
	bg:removeEventListener('tap', startGame)
	Runtime:addEventListener('enterFrame', update)
end

function hitTestObjects(obj1, obj2)
        local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
        local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
        local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
        local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
        return (left or right) and (up or down)
end

function update()
	-- Scale Balls
	scale = scale - variation
	ball.xScale = scale
	ball.yScale = scale
	
	-- Raising
	if(math.floor(ball.xScale * 10) >= 15) then
		variation = 0.05
	end
	-- Missed
	if(math.floor(ball.xScale * 10) < 3) then
		alert()
	end
	
	-- Move Ball
	
	ball.x = ball.x - ballX
	ball.y = ball.y - ballY
	
	-- Falling and Hit with paddle
	if(math.floor(ball.xScale * 10) == 3 and hitTestObjects(paddleTop, ball)) then
		variation = -0.05
		-- Increase Score
		scoreTF.text = tostring(tonumber(scoreTF.text) + 1)
		-- Play Sound
		audio.play(pong)
		-- Move Ball based on where it hits
		if(ball.x < paddle.x + 50) then
			ballX = (math.random() * 0.5) + ballVar
		end
		if(ball.x  > paddle.x) then
			ballX = (math.random() * -0.5) - ballVar
		end
		if(ball.y < paddle.y + 75) then
			ballY = (math.random() * 0.5) + ballVar
		end
		if(ball.y > paddle.y - 70) then
			ballY = (math.random() * -0.5) - ballVar
		end
		-- Increase moving distance
		ballVar = ballVar + 0.025 -- Every four hits increases 0.1
	end
end

function movePaddle(e)
	if(e.phase == 'moved') then
		paddle.x = e.x
		paddle.y = e.y
	end
end

function alert()
	gameListeners('rmv')
	alert = display.newImage('alert.png', (display.contentWidth * 0.5) - 105, (display.contentHeight * 0.5) - 55)
	transition.from(alert, {time = 300, xScale = 0.5, yScale = 0.5})
end

Main()