-------------------------------------------
-- LIBs
-------------------------------------------
require( "src.infra.includeall" )

-- corona libs
local physics 		= require("physics");

-- my libs
local projectile 	= require( "src.gameplay.projectile" )
local skyanimation 	= require( "src.gameplay.sky" )
local assetsTile 	= require( "src.gameplay.assets" )

-------------------------------------------
-- GROUPS
-------------------------------------------
local background, state

state = display.newGroup();

m = {}
m.random = math.random;

-- fisica ligado
physics.start();

-- Animacao do ceu
skyanimation.start();

-- carrega a casa
local houseTile = assetsTile.newHouseTile()

-- carrega a parede no cenario
local walltiles =assetsTile.newWallTile();

-- carrega as latas em cima da parede
local can_tiles1, can_tiles2 = assetsTile.newCanTile()

-- carrega o chao
local grassTile = assetsTile.newGrassTile()

-- carrega a imagem do slingshot
local slingshot = assetsTile.newSlingshotTile()

-- Variables setup
local projectiles_container = nil;
local force_multiplier = 10;
local velocity = m.random(50,100);

-- Variables
local scale = 1.1
local variation = 0.03
local stoneX = 0
local stoneY = 0
local stoneVar = 0.5
local update = nil

local state_value = nil;

-- Audio
local gameplay_song = audio.loadStream( "resources/audio/songs/gameplay.wav" )
local shot = audio.loadSound("resources/audio/effects/band-release.wav");
local band_stretch = audio.loadSound("resources/audio/effects/stretch-1.wav");

audio.stop( 1 )
gameMusicChannel = audio.play( gameplay_song, { channel=1, loops=-1, fadein=5000 } )

----------------------------------
-- SCENARIO
---------------------------------

-- Transfer variables to the projectile classes
projectile.shot = shot;
projectile.band_stretch = band_stretch;

local slingshot_container = display.newGroup();

local stone = nil
local hit = 0

----------------------------------------------
-- METHODS
----------------------------------------------

local  hitTestObjects, projectileTouchListener, spawnProjectile

function spawnProjectile()
	
	if(projectile.ready)then -- If there is a projectile available then...
	
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

-- GAME STATE CHANGE FUNCTION
function state:change(e)
	if(e.state == "fire") then
		-- You fired...
		spawnProjectile(); -- new projectile please
	end
end

function hitTestObjects(obj1, obj2)
    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
    return (left or right) and (up or down)
end

function projectileTouchListener(e)

	-- The current projectile on screen
	local t = e.target;
	-- If the projectile is 'ready' to be used
	if(t.ready) then
		
		if(e.phase == "began") then -- if the touch event has started...

			audio.play(band_stretch); -- Play the band stretch
			
			display.getCurrentStage():setFocus( t ); -- Set the stage focus to the touched projectile
			t.isFocus = true;
			t.bodyType = "kinematic";			
			
			t:setLinearVelocity(0,0); -- Stop current physics motion, if any
			t.angularVelocity = 0;
			
			-- Init the elastic band.
			local myLine = nil;
			local myLineBack = nil;
		
		elseif(t.isFocus) then -- If the target of the touch event is the focus...
			
			if(e.phase == "moved") then -- If the target of the touch event moves...
				
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
				bounds.xMin = 250
				bounds.yMin = display.contentHeight - 5;
				bounds.xMax = display.contentWidth -250;
				bounds.yMax = display.contentHeight - 250;
				
				-- limita a corda do estilingue para não puxar infinitamente
				if(e.y > bounds.yMax) then t.y = e.y; end	 -- limita na parte 		
				if(e.x < bounds.xMax) then t.x = e.x; end	 -- limita a direita
				if(e.y > bounds.yMin) then t.y = bounds.yMin; end -- limita na parte
				if(e.x < bounds.xMin) then t.x = bounds.xMin; end -- limita a esquerda
			
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
				
				scale = 1.1
				update = function(e)

						-- Scale Balls
						if scale > 0 then
							scale = scale - variation	
							t.xScale = scale; t.yScale = scale
							local vx, vy = t:getLinearVelocity()
							t:setLinearVelocity(vx*0.94,vy*0.94)
						end	

					if hit == 0 then
						local M = 2; local N = 2;
						for i=1,(M*N) do
							if (hitTestObjects(t, can_tiles1["left"][i])) then
								t.isSensor = false
								walltiles[1]:toFront()								
								physics.removeBody( walltiles[1] )							
								hit = 1	
							end						
							if (hitTestObjects(t, can_tiles1["right"][i])) then
								t.isSensor = false
								walltiles[2]:toFront()
								physics.removeBody( walltiles[2] )
								hit = 1
							end							
						end
					end
					
				end				

				Runtime:addEventListener('enterFrame', update)

				-- Wait a second before the catapult is reloaded (Avoids conflicts).
				t.timer = timer.performWithDelay(1000, 
					function(e)
						state:dispatchEvent({name="change", state="fire"});

						if(e.count == 1) then
							timer.cancel(t.timer);
							t.timer = nil;
						end
					
					end
				, 1)							
			end
		
		end
	
	end

end

projectile.ready = true; -- Tell the projectile it's good to go!

spawnProjectile(); -- Spawn the first projectile.

state:addEventListener("change", state); -- Create listnener for state changes in the game


---------------------------------------------------------------------------------

local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	elseif phase == "did" then
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
	elseif phase == "did" then
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene