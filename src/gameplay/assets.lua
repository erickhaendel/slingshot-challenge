
module(..., package.seeall)

local assetsGroup = display.newGroup();

function getAssetsGroup()
	return assetsGroup
end

function setAssetsGroupPosition(x,y)

	if x then assetsGroup.x = x; end
	if y then assetsGroup.y = y; end
end

----------------------------------------------------------
-- HOUSE TILES											--
----------------------------------------------------------

function newHouseTile()

	local house = display.newImage( "resources/images/objects/house.png", true )
	house.x = display.contentCenterX-540 
	house.y = display.contentCenterY-280
	assetsGroup:insert( house )
	return house
end

----------------------------------------------------------
-- GROUND TILES											--
----------------------------------------------------------

function newGrassTile()

	local grassTable = {}

	grassTable[1] = display.newImage('resources/images/objects/grass.png')
	grassTable[1].x = display.contentCenterX
	grassTable[1].y = display.contentCenterY + 254
	physics.addBody( grassTable[1], "static", { friction=0.5, bounce=0.3 } )
	assetsGroup:insert( grassTable[1] )

	grassTable[2] = display.newImage('resources/images/objects/grass.png')
	grassTable[2].x = display.contentCenterX + 1445
	grassTable[2].y = display.contentCenterY + 254
	physics.addBody( grassTable[2], "static", { friction=0.5, bounce=0.3 } )
	assetsGroup:insert( grassTable[2] )	

	return grassTable
end	

----------------------------------------------------------
-- SLINGSHOT TILES										--
----------------------------------------------------------

function newSlingshotTile()
	local slingshot = display.newImage("resources/images/objects/slingshot.png",true);
	slingshot.x = display.contentCenterX
	slingshot.y = _H - 100;
	assetsGroup:insert( slingshot )

	--local slingshot2 = display.newImage("resources/images/objects/slingshot.png",true);
	--slingshot2.x = display.contentCenterX
	--slingshot2.y = _H - 100;	

	return slingshot
end

----------------------------------------------------------
-- WALL TILES											--
----------------------------------------------------------

function newWallTile(  )

	local walls = {}

	walls[1] = display.newImage('resources/images/objects/wall.png', display.contentCenterX - 360 , display.contentCenterY+10)	
	physics.addBody( walls[1], "static",{ density=882.0, friction=880.3, bounce=0.4 } )
	assetsGroup:insert( walls[1] )		

	walls[2] = display.newImage('resources/images/objects/wall.png', display.contentCenterX + 360, display.contentCenterY+10)	
	physics.addBody( walls[2], "static",{ density=882.0, friction=880.3, bounce=0.4 } )
	assetsGroup:insert( walls[2] )	

	walls[3] = display.newImage('resources/images/objects/wall.png', display.contentCenterX + 1085 , display.contentCenterY+10)	
	physics.addBody( walls[3], "static",{ density=882.0, friction=880.3, bounce=0.4 } )	
	assetsGroup:insert( walls[3] )	

	walls[4] = display.newImage('resources/images/objects/wall.png', display.contentCenterX + 1805, display.contentCenterY+10)	
	physics.addBody( walls[4], "static",{ density=882.0, friction=880.3, bounce=0.4 } )
	assetsGroup:insert( walls[4] )	

	return walls
end

----------------------------------------------------------
-- CAN TILES											--
----------------------------------------------------------

function newCanTile()
	
	local yellowCanImageFile = "resources/images/objects/yellow-can.png"
	local greenCanImageFile = "resources/images/objects/green-can.png"
	local whiteCanImageFile = "resources/images/objects/white-can.png"
	local blueCanImageFile = "resources/images/objects/blue-can.png"
	local redCanImageFile = "resources/images/objects/red-can.png"
				
	local cans1 = {}
	cans1["left"] = {}; cans1["right"] = {}

	local cans2 = {}	
	cans2["left"] = {}; cans2["right"] = {}

	local myScaleX, myScaleY = 0.5, 0.5
	local M = 2 ; local N = 2

	for i = 1, N do
		for j = 1, M do
			local nw, nh 
			-- Player1 left
			cans1["left"][M*(i-1) + j] = display.newImage( yellowCanImageFile, display.contentCenterX - 280 + (i*24), display.contentCenterY - 100 - (j*40) )
			cans1["left"][M*(i-1) + j].xScale = 0.50; 
			cans1["left"][M*(i-1) + j].yScale = 0.50;
			nw = cans1["left"][M*(i-1) + j].width*myScaleX*0.5;
			nh = cans1["left"][M*(i-1) + j].height*myScaleY*0.5;
			physics.addBody( cans1["left"][M*(i-1) + j], { density=0.10, friction=0.1, bounce=0.5 , shape={-nw,-nh,nw,-nh,nw,nh,-nw,nh}} )
			assetsGroup:insert( cans1["left"][M*(i-1) + j] )			

			-- Player1 right
			cans1["right"][M*(i-1) + j] = display.newImage( greenCanImageFile, display.contentCenterX + 280 + (i*24), display.contentCenterY - 100 - (j*40) )		
			cans1["right"][M*(i-1) + j].xScale = 0.50; 
			cans1["right"][M*(i-1) + j].yScale = 0.50;
			nw = cans1["right"][M*(i-1) + j].width*myScaleX*0.5;
			nh = cans1["right"][M*(i-1) + j].height*myScaleY*0.5;
			physics.addBody( cans1["right"][M*(i-1) + j], { density=0.10, friction=0.1, bounce=0.5 , shape={-nw,-nh,nw,-nh,nw,nh,-nw,nh}} )	
			assetsGroup:insert( cans1["right"][M*(i-1) + j] )

			-- Player2 left
			cans2["left"][M*(i-1) + j] = display.newImage( greenCanImageFile, display.contentCenterX + 1280 - 280 + (i*24), display.contentCenterY - 100 - (j*40) )
			cans2["left"][M*(i-1) + j].xScale = 0.50; 
			cans2["left"][M*(i-1) + j].yScale = 0.50;
			nw = cans2["left"][M*(i-1) + j].width*myScaleX*0.5;
			nh = cans2["left"][M*(i-1) + j].height*myScaleY*0.5;		
			physics.addBody( cans2["left"][M*(i-1) + j], { density=0.10, friction=0.1, bounce=0.5 , shape={-nw,-nh,nw,-nh,nw,nh,-nw,nh}} )	
			assetsGroup:insert( cans2["left"][M*(i-1) + j] )

			-- Player2 right
			cans2["right"][M*(i-1) + j] = display.newImage( yellowCanImageFile, display.contentCenterX + 1280 + 280 + (i*24), display.contentCenterY - 100 - (j*40) )
			cans2["right"][M*(i-1) + j].xScale = 0.50; 
			cans2["right"][M*(i-1) + j].yScale = 0.50;
			nw = cans2["right"][M*(i-1) + j].width*myScaleX*0.5;
			nh = cans2["right"][M*(i-1) + j].height*myScaleY*0.5;			
			physics.addBody( cans2["right"][M*(i-1) + j], { density=0.10, friction=0.1, bounce=0.5 , shape={-nw,-nh,nw,-nh,nw,nh,-nw,nh}} )		
			assetsGroup:insert( cans2["right"][M*(i-1) + j] )

		end
	end

	return cans1, cans2
end

----------------------------------------------------------
-- BAND SLINGSHOT										--
----------------------------------------------------------

-- insere o elastico no cenario
function newBandLine( t )
	local myLine_x2 = display.contentCenterX - 49
	local myLine_y2 = _H - 180

	local myLineBack_x2 = display.contentCenterX + 49
	local myLineBack_y2 = _H - 180	

	-- Init the elastic band.
	local myLine = nil;
	local myLineBack = nil;	

	-- If the projectile is in the top left position
	if(t.x < display.contentCenterX and t.y < _H - 165)then
		myLineBack = display.newLine(t.x - 30, t.y, myLineBack_x2, myLineBack_y2);
		myLine = display.newLine(t.x - 30, t.y, myLine_x2, myLine_y2);
	-- If the projectile is in the top right position
	elseif(t.x > display.contentCenterX and t.y < _H - 165)then
		myLineBack = display.newLine(t.x + 10, t.y - 25,  myLineBack_x2, myLineBack_y2);
		myLine = display.newLine(t.x + 10, t.y - 25,  myLine_x2, myLine_y2);
	-- If the projectile is in the bottom left position
	elseif(t.x < display.contentCenterX and t.y > _H - 165)then
		myLineBack = display.newLine(t.x - 25, t.y + 20,  myLineBack_x2, myLineBack_y2);
		myLine = display.newLine(t.x - 25, t.y + 20,  myLine_x2, myLine_y2);
	-- If the projectile is in the bottom right position
	elseif(t.x > display.contentCenterX and t.y > _H - 165)then
		myLineBack = display.newLine(t.x - 15, t.y + 30,  myLineBack_x2, myLineBack_y2);
		myLine = display.newLine(t.x - 15, t.y + 30,  myLine_x2, myLine_y2);
	else
	-- Default position (just in case).
		myLineBack = display.newLine(t.x - 25, t.y, myLineBack_x2, myLineBack_y2);
		myLine = display.newLine(t.x - 25, t.y,   myLine_x2, myLine_y2);
	end

	-- Set the elastic band's visual attributes
	myLineBack:setStrokeColor(255,255,255);
	myLineBack.strokeWidth = 9;

	myLine:setStrokeColor(255,255,255);
	myLine.strokeWidth = 11;

	return myLineBack, myLine
end

-- remove o elastico do cenario
function removeBandLine( )
	if(myLine and myLine.parent) then	
		myLine.parent:remove(myLine); -- erase previous line
		myLineBack.parent:remove(myLineBack); -- erase previous line
		myLine = nil;
		myLineBack = nil;
	end
end

function newTrajectory(x,y,r,g,b)
	local myCircle = display.newCircle( x, y, 5 )
	myCircle:setFillColor(r, g, b) 
	--myCircle:setStrokeColor(140, 140, 140) 
	--myCircle.strokeWidth = 5
	--myCircle:setStrokeColor( .255, .0, .0 )	

	assetsGroup:insert( myCircle )

	return myCircle
end

function newTargetTile(x,y)
	local target = display.newImage('resources/images/objects/target.png')
	target.x = x
	target.y = y

	return target
end	
----------------------------------------------------------
-- SKY ANIMATION										--
----------------------------------------------------------
-- Camera follows bolder automatically
local skyGroup = display.newGroup();

local function moveSky()
	if (skyGroup.x > -960) then
		skyGroup.x = skyGroup.x -0.2
	else
		skyGroup.x = 0
	end
end

--display.contentCenterX
function startSky()

	local sky = display.newImage( "resources/images/objects/sky.png", true )
	skyGroup:insert( sky )
	sky.x = display.contentCenterX - 1210
	sky.y = display.contentCenterY-280

	local sky2 = display.newImage( "resources/images/objects/sky.png", true )
	skyGroup:insert( sky2 )
	sky2.x = display.contentCenterX + 70
	sky2.y = display.contentCenterY-280

	local sky3 = display.newImage( "resources/images/objects/sky.png", true )
	skyGroup:insert( sky3 )
	sky3.x = display.contentCenterX +1350
	sky3.y = display.contentCenterY-280

	local sky4 = display.newImage( "resources/images/objects/sky.png", true )
	skyGroup:insert( sky4 )
	sky4.x = display.contentCenterX + 2630
	sky4.y = display.contentCenterY-280

	Runtime:addEventListener( "enterFrame", moveSky )	

	assetsGroup:insert( skyGroup )	

	return skyGroup
end

function newPlayerLabel()

	local labels = {}

	labels[1] = display.newText( "Player 1", display.contentCenterX, display.contentCenterY-280, native.systemFont, 72 )
	labels[1]:setFillColor( .82, .35 , .35 )
	assetsGroup:insert( labels[1] )

	labels[2] = display.newText( "Player 2", display.contentCenterX + 1400, display.contentCenterY-280, native.systemFont, 72 )
	labels[2]:setFillColor( .82, .35 , .35 )
	assetsGroup:insert( labels[2] )

	return labels[1], labels[2]
end