
module(..., package.seeall)

local assetsGroup = display.newGroup();

function newHouseTile()

	local house = display.newImage( "resources/images/objects/house.png", true )
	house.x = display.contentCenterX-540 
	house.y = display.contentCenterY-280
	assetsGroup:insert( house )
	return house
end

function newGrassTile()
	local grass = display.newImage('resources/images/objects/grass.png')
	grass.x = display.contentCenterX
	grass.y = display.contentCenterY + 254
	physics.addBody( grass, "static", { friction=0.5, bounce=0.3 } )
	assetsGroup:insert( grass )

	return grass
end	

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

function newWallTile(  )

	local walls = {}

	walls[1] = display.newImage('resources/images/objects/wall.png', display.contentCenterX - 360 , display.contentCenterY+10)	
	physics.addBody( walls[1], "static",{ density=882.0, friction=880.3, bounce=0.4 } )
	assetsGroup:insert( walls[1] )		

	walls[2] = display.newImage('resources/images/objects/wall.png', display.contentCenterX + 320, display.contentCenterY+10)	
	physics.addBody( walls[2], "static",{ density=882.0, friction=880.3, bounce=0.4 } )
	assetsGroup:insert( walls[2] )	

	--walls[3] = display.newImage('resources/images/objects/wall.png', display.contentCenterX + 640 , display.contentCenterY+10)	
	--print( display.screenOriginX )
	--physics.addBody( walls[3], "static",{ density=882.0, friction=880.3, bounce=0.4 } )	
	--assetsGroup:insert( walls[3] )	

	--walls[4] = display.newImage('resources/images/objects/wall.png', display.contentCenterX + 960, display.contentCenterY+10)	
	--physics.addBody( walls[4], "static",{ density=882.0, friction=880.3, bounce=0.4 } )
	--assetsGroup:insert( walls[4] )	

	return walls
end

function newCanTile()
	
	local canImageFile = "resources/images/objects/can.png"

	local cans1 = {}
	cans1["left"] = {}; cans1["right"] = {}

	local cans2 = {}	
	cans2["left"] = {}; cans2["right"] = {}

	local cansBody = { density=0.10, friction=0.1, bounce=0.5  }
	
	local M = 2 ; local N = 2

	for i = 1, N do
		for j = 1, M do

			-- Player1 left
			cans1["left"][M*(i-1) + j] = display.newImage( canImageFile, display.contentCenterX - 280 + (i*24), display.contentCenterY - 100 - (j*40) )
			physics.addBody( cans1["left"][M*(i-1) + j], cansBody )
			assetsGroup:insert( cans1["left"][M*(i-1) + j] )			

			-- Player1 right
			cans1["right"][M*(i-1) + j] = display.newImage( canImageFile, display.contentCenterX + 280 + (i*24), display.contentCenterY - 100 - (j*40) )
			physics.addBody( cans1["right"][M*(i-1) + j], cansBody )		
			assetsGroup:insert( cans1["right"][M*(i-1) + j] )

			-- Player2 left
			cans2["left"][M*(i-1) + j] = display.newImage( canImageFile, display.contentCenterX + 1280 - 280 + (i*24), display.contentCenterY - 100 - (j*40) )
			physics.addBody( cans2["left"][M*(i-1) + j], cansBody )
			assetsGroup:insert( cans2["left"][M*(i-1) + j] )

			-- Player2 right
			cans2["right"][M*(i-1) + j] = display.newImage( canImageFile, display.contentCenterX + 1280 + 280 + (i*24), display.contentCenterY - 100 - (j*40) )
			physics.addBody( cans2["right"][M*(i-1) + j], cansBody )	
			assetsGroup:insert( cans2["right"][M*(i-1) + j] )

		end
	end

	return cans1, cans2
end

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