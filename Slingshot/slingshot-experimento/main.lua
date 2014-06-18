
-- Global vars set up
_W = display.contentWidth;
_H = display.contentHeight;

display.setStatusBar( display.HiddenStatusBar )

m = {}
m.random = math.random;

local state = display.newGroup();
local skyGroup = display.newGroup();

-- Imports
local movieclip = require("movieclip");
local physics = require("physics");
physics.start();
-- Import projectile classes
local projectile = require("projectile");

-- Variables setup
local projectiles_container = nil;
local force_multiplier = 10;
local velocity = m.random(50,100);

local state_value = nil;

-- Audio
local shot = audio.loadSound("sounds/band-release.wav");
local band_stretch = audio.loadSound("sounds/stretch-1.wav");

-- Transfer variables to the projectile classes
projectile.shot = shot;
projectile.band_stretch = band_stretch;


local sky = display.newImage( "images/sky.png", true )
skyGroup:insert( sky )
sky.x = -50
sky.y = display.contentCenterY-280

local sky2 = display.newImage( "images/sky.png", true )
skyGroup:insert( sky2 )
sky2.x = 1230 
sky2.y = display.contentCenterY-280

local sky3 = display.newImage( "images/sky.png", true )
skyGroup:insert( sky3 )
sky3.x = 2510 
sky3.y = display.contentCenterY-280

local house = display.newImage( "images/house.png", true )
house.x = display.contentCenterX-540 
house.y = display.contentCenterY-280

local grass = display.newImage('images/grass.png')
grass.x = display.contentCenterX
grass.y = display.contentCenterY + 254
physics.addBody( grass, "static", { friction=0.5, bounce=0.3 } )
--background:insert(grass);

local leftWall = display.newImage('images/leftWall.png', display.contentCenterX-350, display.contentCenterY+10)	
physics.addBody( leftWall, "static",{ density=882.0, friction=880.3, bounce=0.4 } )	

local rightWall = display.newImage('images/rightWall.png', display.contentCenterX+512, display.contentCenterY+10)	
physics.addBody( rightWall, "static",{ density=882.0, friction=880.3, bounce=0.4 } )	

local cansPlayer1 = {}
function loadCansPlayer1()
	local M = 2; local N = 2
	for i = 1, N do
		for j = 1, M do
		cansPlayer1[M*(i-1) + j] = display.newImage( "images/can.png", display.contentCenterX - 320 + (i*24), display.contentCenterY - 100 - (j*40) )
		physics.addBody( cansPlayer1[M*(i-1) + j], { density=0.10, friction=0.1, bounce=0.5 } )
		end
	end
end

local cansPlayer2 = {}
function loadCansPlayer2()
	local M = 2; local N = 2
	for i = 1, N do
		for j = 1, M do
		cansPlayer2[M*(i-1) + j] = display.newImage( "images/can.png", display.contentCenterX + 320 + (i*24), display.contentCenterY - 100 - (j*40) )
		physics.addBody( cansPlayer2[M*(i-1) + j], { density=0.10, friction=0.1, bounce=0.5 } )
		end
	end
end

local background = display.newGroup();

local slingshot_container = display.newGroup();

-- Build the catapult
-- Front strut
local slingshot = display.newImage("images/slingshot.png",true);
slingshot.x = display.contentCenterX
slingshot.y = _H - 100;

-- Variables
local scoreTF
local scale = 1.1
local variation = 0.03
local stoneX = 0
local stoneY = 0
local stoneVar = 0.5
local update = nil

-- Score
score = display.newImage('images/score.png', display.contentCenterX*1.30, display.contentCenterY*0.07)
scoreTF = display.newText('0', display.contentCenterX*1.70, display.contentCenterY*0.07, 'Marker Felt', 30)
scoreTF:setFillColor(238, 238, 238)
	
local stone = nil
local hit = 0

-- descobri a direcao da bola em relacao a raquete
function hitTestObjects(obj1, obj2)
        local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
        local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
        local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
        local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
        return (left or right) and (up or down)
end

-- Camera follows bolder automatically
local function moveSky()
	if (skyGroup.x > -1270) then
		skyGroup.x = skyGroup.x -0.2
	else
		skyGroup.x = 0
	end
end

function unloadCansPlayer1()
	local M = 2; local N = 2	
	for i = 1, N do
		for j = 1, M do
		display.remove( cansPlayer1[M*(i-1) + j] )
		cansPlayer1[M*(i-1) + j] = nil		
		end
	end	
end

function unloadCansPlayer2()
	local M = 2; local N = 2	
	for i = 1, N do
		for j = 1, M do
		display.remove( cansPlayer2[M*(i-1) + j] )
		cansPlayer2[M*(i-1) + j] = nil		
		end
	end	
end

function resetGameplay()
	hit = 0
	background:remove(leftWall);	
	background:remove(rightWall);		
	unloadCansPlayer1()
	unloadCansPlayer2()	
	cansPlayer1 = {}	
	cansPlayer2 = {}
	loadCansPlayer1()	
	loadCansPlayer2()
	background = display.newGroup();
	physics.addBody( leftWall, "static",{ density=882.0, friction=880.3, bounce=0.4 } )	
	physics.addBody( rightWall, "static",{ density=882.0, friction=880.3, bounce=0.4 } )	
end

resetGameplay()

needReset = 0

Runtime:addEventListener( "enterFrame", moveSky )
--[[

projectile TOUCH FUNCTION

]]--
local function projectileTouchListener(e)

	moveSky()

	-- The current projectile on screen
	local t = e.target;
	-- If the projectile is 'ready' to be used
	if(t.ready) then
		-- if the touch event has started...
		if(e.phase == "began") then

			-- Play the band stretch
			audio.play(band_stretch);
			-- Set the stage focus to the touched projectile
			display.getCurrentStage():setFocus( t );
			t.isFocus = true;
			t.bodyType = "kinematic";
			
			-- Stop current physics motion, if any
			t:setLinearVelocity(0,0);
			t.angularVelocity = 0;
			
			-- Init the elastic band.
			local myLine = nil;
			local myLineBack = nil;
		
		-- If the target of the touch event is the focus...
		elseif(t.isFocus) then
			-- If the target of the touch event moves...
			--

			if(e.phase == "moved") then
				
				-- If the band exists... refresh the drawing of the line on the stage.
				if(myLine) then
					myLine.parent:remove(myLine); -- erase previous line
					myLineBack.parent:remove(myLineBack); -- erase previous line
					myLine = nil;
					myLineBack = nil;
				end

				local myLine_x2 = display.contentCenterX - 49
				local myLine_y2 = _H - 180

				local myLineBack_x2 = display.contentCenterX + 49
				local myLineBack_y2 = _H - 180
				
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
				
				-- Insert the components of the catapult into a group.
				slingshot_container:insert(slingshot);
				slingshot_container:insert(myLineBack);
				slingshot_container:insert(t);
				slingshot_container:insert(myLine);

				
				-- Boundary for the projectile when grabbed			
				local bounds = e.target.stageBounds;
				bounds.xMin = 5
				bounds.yMin = display.contentHeight - 5;
				bounds.xMax = display.contentWidth;
				bounds.yMax = display.contentHeight - 250;
				
				if(e.y > bounds.yMax) then t.y = e.y; end
				
				if(e.x < bounds.xMax) then t.x = e.x; end
				
				if(e.y > bounds.yMin) then t.y = bounds.yMin; end
				
				if(e.x < bounds.xMin) then t.x = bounds.xMin; end				
			
			-- If the projectile touch event ends (player lets go)...
			elseif(e.phase == "ended" or e.phase == "cancelled") then

				-- Remove projectile touch so player can't grab it back and re-use after firing.
				projectiles_container:removeEventListener("touch", projectileTouchListener);
				-- Reset the stage focus
				display.getCurrentStage():setFocus(nil);
				t.isFocus = false;
				
				-- Play the release sound
				audio.play(shot);
				
				-- Remove the elastic band
				if(myLine) then
					myLine.parent:remove(myLine); -- erase previous line
					myLineBack.parent:remove(myLineBack); -- erase previous line
					myLine = nil;
					myLineBack = nil;
				end
				
				-- Launch projectile
				t.bodyType = "dynamic";
				t:applyForce((display.contentCenterX - e.x)*force_multiplier, (_H - 160 - e.y)*force_multiplier, t.x, t.y);
				t:applyTorque( 100 )
				t.isFixedRotation = false;
				
				-- atualiza o ponteiro para a pedra atual para obedecer a escala

				Runtime:removeEventListener('enterFrame', update)	
				
				update = nil
				scale = 1.1
				update = function(e)

						-- Scale Balls
						if scale > 0 then
							scale = scale - variation	
							t.xScale = scale
							t.yScale = scale
							local vx, vy = t:getLinearVelocity()
							vx = vx*0.93
							vy = vy*0.93
							t:setLinearVelocity(vx,vy)
						else
							if (hitTestObjects(t, leftWall)) then
								local smoke = display.newImage('images/smoke.gif', display.contentCenterX, display.contentCenterY)


							end
						end	

					--if hit == 0 then
						local M = 2; local N = 2;
						for i=1,(M*N) do
							if (hitTestObjects(t, cansPlayer1[i])) then
								t.isSensor = false
								physics.removeBody( leftWall )
								background:insert(leftWall);								
								--hit = 1		
								needReset = needReset + 1
							end
							if (hitTestObjects(t, cansPlayer2[i])) then
								t.isSensor = false
								physics.removeBody( rightWall )
								background:insert(rightWall);								
								--hit = 1	
								needReset = needReset + 1
							end							
						end
					--end
					
				end				

				Runtime:addEventListener('enterFrame', update)

				if needReset == 2 then
					needReset = 0
					resetGameplay()
				end

				-- Wait a second before the catapult is reloaded (Avoids conflicts).
				t.timer = timer.performWithDelay(1000, function(e)
				state:dispatchEvent({name="change", state="fire"});

				if(e.count == 1) then
					timer.cancel(t.timer);
					t.timer = nil;
				end
				
				end, 1)							
			end
		
		end
	
	end

end

--[[

SPAWN projectile FUNCTION

]]--
local function spawnProjectile()

	-- If there is a projectile available then...
	if(projectile.ready)then
	
		projectiles_container = projectile.newProjectile();
		-- Flag projectiles for removal
		projectiles_container.ready = true;
		projectiles_container.remove = true;
		
		-- Reset the indexing for the visual attributes of the catapult.
		slingshot_container:insert(projectiles_container);
		slingshot_container:insert(slingshot);

		-- Add an event listener to the projectile.
		projectiles_container:addEventListener("touch", projectileTouchListener);
		
	end

end
--[[

GAME STATE CHANGE FUNCTION

]]--
function state:change(e)

	if(e.state == "fire") then
	
		-- You fired...
		-- new projectile please
		spawnProjectile();
			
	end

end

-- Tell the projectile it's good to go!
projectile.ready = true;
-- Spawn the first projectile.
spawnProjectile();
-- Create listnener for state changes in the game
state:addEventListener("change", state);
