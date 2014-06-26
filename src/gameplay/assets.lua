
module(..., package.seeall)

local configuration = require( "src.gameplay.configuration" )

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

	local house = display.newImage( configuration.house_image_filename, true )
	house.x = configuration.house_position_x; house.y = configuration.house_position_y
	assetsGroup:insert( house )
	return house
end

----------------------------------------------------------
-- GROUND TILES											--
----------------------------------------------------------

function newGrassTile()

	local grassTable = {}

	for i=1,2 do
		grassTable[i] = display.newImage(configuration.grass_image_filename)
		grassTable[i].x = configuration.grass_position_x[i]; grassTable[i].y = configuration.grass_position_y[i]
		physics.addBody( grassTable[i], "static", grassBody )
		assetsGroup:insert( grassTable[i] )
	end

	return grassTable
end	

----------------------------------------------------------
-- SLINGSHOT TILES										--
----------------------------------------------------------

function newSlingshotTile()
	local slingshot = display.newImage(configuration.slingshot_image_filename,true);
	slingshot.x = configuration.slingshot_position_x[1]; slingshot.y = configuration.slingshot_position_y[1]
	assetsGroup:insert( slingshot )

	return slingshot
end

----------------------------------------------------------
-- WALL TILES											--
----------------------------------------------------------

function newWallTile(  )

	local walls = {}

	for i=1,4 do
		walls[i] = display.newImage(configuration.wall_image_filename, configuration.wall_x[i] , configuration.wall_y[i] )	
		physics.addBody( walls[i], "static", configuration.wallBody )
		assetsGroup:insert( walls[i] )		
	end
	
	return walls
end

----------------------------------------------------------
-- CAN TILES											--
----------------------------------------------------------
function newScoreCanTile(color, px, py)

	local can = display.newImage( "resources/images/objects/"..color.."-can-score.png", px, py )
	assetsGroup:insert( can )	
	return can
end

function newCanTile()
				
	local cans = {}
	cans[1] = {}; cans[2] = {}
	cans[3] = {}; cans[4] = {}

	local myScaleX, myScaleY = 0.5, 0.5
	local M = 2 ; local N = 2

	filename = {}
	filename[1] = configuration.can_image_dir..configuration.player1_can; filename[4] = filename[1]
	filename[2] = configuration.can_image_dir..configuration.player2_can; filename[3] = filename[2]

	local current_can = {}
	for i = 1, N do
		for j = 1, M do
			local nw, nh 	
			
			for k=1,4 do
				current_can[k] = cans[k][M * (i-1) + j]
				current_can[k] = display.newImage( filename[k], configuration.cans_x[k] + (i*24), configuration.cans_y[k] - (j*40) )

				current_can[k].xScale = configuration.can_xScale
				current_can[k].yScale = configuration.can_yScale

				nw = current_can[k].width * myScaleX * 0.5
				nh = current_can[k].height * myScaleY * 0.5

				local cansBody = { density=0.10, friction=0.1, bounce=0.5 , shape={-nw,-nh,nw,-nh,nw,nh,-nw,nh}}

				physics.addBody( current_can[k], cansBody )

				cans[k][M * (i-1) + j] = current_can[k]
				
				assetsGroup:insert( current_can[k] )	
			end

		end
	end

	return cans[1], cans[2], cans[3], cans[4]
end

----------------------------------------------------------
-- BAND SLINGSHOT										--
----------------------------------------------------------

-- insere o elastico no cenario
function newBandLine( t )

	-- Init the elastic band.
	local myLine = nil;
	local myLineBack = nil;	

	-- If the projectile is in the top left position
	if(t.x < display.contentCenterX and t.y < _H - 165)then
		myLineBack = display.newLine(t.x - 30, t.y, configuration.myLineBack_x2, configuration.myLineBack_y2);
		myLine = display.newLine(t.x - 30, t.y, configuration.myLine_x2, configuration.myLine_y2);
	-- If the projectile is in the top right position
	elseif(t.x > display.contentCenterX and t.y < _H - 165)then
		myLineBack = display.newLine(t.x + 10, t.y - 25,  configuration.myLineBack_x2, configuration.myLineBack_y2);
		myLine = display.newLine(t.x + 10, t.y - 25,  configuration.myLine_x2, configuration.myLine_y2);
	-- If the projectile is in the bottom left position
	elseif(t.x < display.contentCenterX and t.y > _H - 165)then
		myLineBack = display.newLine(t.x - 25, t.y + 20,  configuration.myLineBack_x2, configuration.myLineBack_y2);
		myLine = display.newLine(t.x - 25, t.y + 20,  configuration.myLine_x2, configuration.myLine_y2);
	-- If the projectile is in the bottom right position
	elseif(t.x > display.contentCenterX and t.y > _H - 165)then
		myLineBack = display.newLine(t.x - 15, t.y + 30,  configuration.myLineBack_x2, configuration.myLineBack_y2);
		myLine = display.newLine(t.x - 15, t.y + 30,  configuration.myLine_x2, configuration.myLine_y2);
	else
	-- Default position (just in case).
		myLineBack = display.newLine(t.x - 25, t.y, configuration.myLineBack_x2, configuration.myLineBack_y2);
		myLine = display.newLine(t.x - 25, t.y,   configuration.myLine_x2, configuration.myLine_y2);
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

-- load the sky animation
function startSky()

	local skys = {}

	for i=1,4 do
		skys[i] = display.newImage( configuration.sky_image_filename, true )
		skyGroup:insert( skys[i] )
		skys[i].x = configuration.sky_x[i]
		skys[i].y = configuration.sky_y[i]
	end

	Runtime:addEventListener( "enterFrame", moveSky )	

	assetsGroup:insert( skyGroup )	

	return skyGroup
end

-- 
function newTitlePlayerLabel()

	local labels = {}

	for i=1,2 do
		labels[i] = display.newText( "Player "..i, configuration.title_player_label_x[i], configuration.title_player_label_y[i], native.systemFont, 72 )
		labels[i]:setFillColor( .82, .35 , .35 )
		assetsGroup:insert( labels[i] )
	end

	return labels[1], labels[2]
end

-- 
function newScorePlayerLabel()

	local scoreLabels = {}
	local j = 1
	for i=1,4 do
		scoreLabels[i] = display.newText( "Player "..j.." >> 0", configuration.score_player_label_x[i], configuration.score_player_label_y[i], native.systemFont, 30 )
		scoreLabels[i]:setFillColor( 1, 1 , 1 )
		assetsGroup:insert( scoreLabels[i] )
		scoreLabels[i]:toFront( )
		if j == 2 then j = 1; else j = j + 1; end
	end

	return scoreLabels[1], scoreLabels[2], scoreLabels[3], scoreLabels[4]
end

-- cria todos os objetos de score dos scoreboards
function new_scoreboard()

	local score_cans = {}
	score_cans[1] = {}; score_cans[2] = {}
	score_cans[3] = {}; score_cans[4] = {}

	filename = {}
	filename[1] = configuration.can_image_dir..configuration.player1_score_can; filename[4] = filename[1]
	filename[2] = configuration.can_image_dir..configuration.player2_score_can; filename[3] = filename[2]

	-- define a inclinacao da matriz de latas
	local offset_inclination_right = 50 -- se mudar a imagem de grass vai ter que ajustar esses valores
	local offset_inclination_left = -27	-- se mudar a imagem de grass vai ter que ajustar esses valores

	-- define a distancia entre as latas
	local offset_between_cans_x = 60
	local offset_between_cans_y = 40
	local offset_proportional_vertical_distance1 = {} -- player 1
	local offset_proportional_vertical_distance2 = {} -- player2

	for i=1,4 do	
		offset_proportional_vertical_distance1[i] = 1
		offset_proportional_vertical_distance2[i] = 1		
	end

	local offset_can_scale = 1

	local M = 4 ; local N = 5

	for k = 1, 4 do	
		for j = 1, M do
			for i = 1, N do
				-- fix the correct offset of the can on the scoreboard
				local offset_inclination
				local offset_p_v_d
				if k % 2 == 0 then -- player 2
					offset_inclination = offset_inclination_left; 
					offset_p_v_d = offset_proportional_vertical_distance2[k]
				else -- player 1
					offset_inclination = offset_inclination_right; 
					offset_p_v_d = offset_proportional_vertical_distance1[k]
				end

				-- load the can image
				score_cans[k][M * (i-1) + j] = display.newImage( 
					filename[k], 
					configuration.score_cans_x[k] + (i*offset_between_cans_x*offset_p_v_d) + j*offset_inclination, 
					configuration.score_cans_y[k] - (j*offset_between_cans_y*offset_p_v_d) )

				score_cans[k][M * (i-1) + j].isVisible = false

				-- insert the image in a group
				assetsGroup:insert( score_cans[k][M * (i-1) + j] )	
			end

			offset_proportional_vertical_distance1[k] = offset_proportional_vertical_distance1[k] - 0.082
			offset_proportional_vertical_distance2[k] = offset_proportional_vertical_distance2[k] - 0.088
		end
	end
	
	return score_cans[1], score_cans[2], score_cans[3], score_cans[4]
end
