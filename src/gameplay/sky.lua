
module(..., package.seeall)

-- Camera follows bolder automatically
local skyGroup = display.newGroup();

local function moveSky()
	if (skyGroup.x > -1270) then
		skyGroup.x = skyGroup.x -0.2
	else
		skyGroup.x = 0
	end
end

--display.contentCenterX
function start()

	local sky = display.newImage( "resources/images/objects/sky.png", true )
	skyGroup:insert( sky )
	sky.x = -50
	sky.y = display.contentCenterY-280

	local sky2 = display.newImage( "resources/images/objects/sky.png", true )
	skyGroup:insert( sky2 )
	sky2.x = 1230 
	sky2.y = display.contentCenterY-280

	local sky3 = display.newImage( "resources/images/objects/sky.png", true )
	skyGroup:insert( sky3 )
	sky3.x = 2510 
	sky3.y = display.contentCenterY-280

	Runtime:addEventListener( "enterFrame", moveSky )	
end

function stop()
	Runtime:removeEventListener( "enterFrame", moveSky )	
end

