-------------------------------------------
-- LIBs
-------------------------------------------
require( "src.infra.includeall" )

-- corona libs
local physics 		= require("physics");

-- my libs
local projectile 	= require( "src.gameplay.projectile" )
local assetsTile 	= require( "src.gameplay.assets" )
local gamelib 		= require( "src.gameplay.gamelib" )

-------------------------------------------
-- GROUPS
-------------------------------------------
local state

state = display.newGroup();

-- objetos de cenario
local houseTile, walltiles, can_tiles1, can_tiles2, grassTile, slingshot, labels

-- Variables setup
local projectiles_container = nil;
local force_multiplier = 10;

-- Variables - usado para calcular a escala da pedra lançada
local scale = 1.1
local variation = 0.03
local stoneX = 0
local stoneY = 0
local stoneVar = 0.5
local update = nil
local state_value = nil;


local slingshot_container = display.newGroup();

-- flag de colisao
local hit = 0

-- contador de pontos da trajetoria
local circle_id = 1
local trajetory = {}

-- flag mira
local cronometro_inicio = 0
local cronometro_ligado = 1

-- INFO PLAYER
current_player = 1

----------------------------------------------
-- METHODS
----------------------------------------------

local  projectileTouchListener, spawnProjectile, createGameplayScenario, moveCamera

function moveCamera()

	local p = current_player

	local assetsGroup = assetsTile.getAssetsGroup()
	local velocity = 4

	-- Vai do cenario 1 para o 2
	if p == 2 then
		if (assetsGroup.x > -1450) then
			assetsGroup.x = assetsGroup.x - velocity
		end

	-- vai do cenario 2 para o 1
	elseif p == 1 then		
		if (assetsGroup.x < 0) then
			assetsGroup.x = assetsGroup.x + velocity
		end
	end
end

function createGameplayScenario()

	-- Animacao do ceu
	skyTile = assetsTile.startSky();

	-- carrega a casa
	houseTile = assetsTile.newHouseTile()

	-- carrega a parede no cenario
	walltiles = assetsTile.newWallTile();

	-- carrega as latas em cima da parede
	can_tiles1, can_tiles2 = assetsTile.newCanTile()

	-- carrega o chao
	grassTile = assetsTile.newGrassTile()

	-- carrega a imagem do slingshot
	slingshot = assetsTile.newSlingshotTile()

	-- carrega as labels identificando os cenários
	label1, label2 = assetsTile.newPlayerLabel()
	timer.performWithDelay( 13500, function ( event )	
		label1:removeSelf( );label1=nil;
		label2:removeSelf( );label2=nil;
		end)

	if current_player == 1 then
		assetsTile.setAssetsGroupPosition(display.contentCenterX - 2100, nil)
	end

	Runtime:addEventListener( "enterFrame", moveCamera )		
end

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

local lastTargettile
function previsaoColisao(t)

	local ps = projectile.newSpecialProjectile(t.x,t.y)
	ps:localToContent( t.x,t.y )
	ps.isVisible = false	

	local s_scale = 1.1

	-- Launch projectile
	ps.bodyType = "dynamic";
	--t:applyForce((display.contentCenterX - e.x)*force_multiplier, (_H - 160 - e.y)*force_multiplier, t.x, t.y);
	ps:applyForce((slingshot.x - ps.x)*0.4*10, (slingshot.y - ps.y)*0.4*10, ps.x, ps.y);
	ps.isFixedRotation = false;

	-- Register to call t's timer method an infinite number of times
	local timer1 = timer.performWithDelay( 1, function ( event )	
	
			-- remove a mira caso tenha lançado a pedra
			if lastTargettile then
				lastTargettile:removeSelf( );
				lastTargettile = nil
			end		

			if s_scale > 0.5 then
			
				s_scale = s_scale - variation	

				local vx, vy = ps:getLinearVelocity()
				ps:setLinearVelocity(vx*0.94,vy*0.94)

			else
	    		timer.cancel( event.source ) 
				ps.isFocus = true;
				ps.isVisible = true	
				ps.bodyType = "static";			
				
				ps:setLinearVelocity(0,0); -- Stop current physics motion, if any
				ps.angularVelocity = 0;
				lastTargettile = ps
			end	
		end
	, 0 )

end

-- GAME STATE CHANGE FUNCTION
function state:change(e)

	if(e.state == "fire") then
		-- You fired...
		spawnProjectile(); -- new projectile please
	end
end

function projectileTouchListener(e)

	-- The current projectile on screen
	local t = e.target;

	-- If the projectile is 'ready' to be used
	if(t.ready) then

		if(e.phase == "began") then -- if the touch event has started...

			-- Play the band stretch
			gamelib.playBandStretch()
			
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
				assetsTile.removeBandLine( )

				myLineBack, myLine = assetsTile.newBandLine( t )
				
				-- Insert the components of the catapult into a group.
				slingshot_container:insert(slingshot);
				slingshot_container:insert(myLineBack);
				slingshot_container:insert(t);
				slingshot_container:insert(myLine);

				-- Boundary for the projectile when grabbed	
				-- evita que estique o elastico infinitamente	
				t.x,t.y = gamelib.getBoundaryProjectile( e, t )

				if cronometro_ligado == 0 then				
					cronometro_inicio = system.getTimer()
					cronometro_ligado = 1
				end

				-- intervalo de um segundo para iniciar o calculo da mira
				if system.getTimer() > cronometro_inicio + 4 then
					previsaoColisao(t)		
					cronometro_ligado = 0	
				end	

			-- If the projectile touch event ends (player lets go)...
			elseif(e.phase == "ended" or e.phase == "cancelled") then

				if lastTargettile then
					lastTargettile:removeSelf( );
					lastTargettile = nil
				end	

				-- Remove projectile touch so player can't grab it back and re-use after firing.
				projectiles_container:removeEventListener("touch", projectileTouchListener);
				-- Reset the stage focus
				display.getCurrentStage():setFocus(nil);
				t.isFocus = false;
				
				-- Play the release sound
				gamelib.playProjecttileShot()
				
				-- Remove the elastic band
				assetsTile.removeBandLine( )
				
				-- Launch projectile
				t.bodyType = "dynamic";

				t:applyForce((slingshot.x - t.x)*0.4*10, (slingshot.y - t.y)*0.4*10, t.x, t.y);
				t:applyTorque( 100 )
				t.isFixedRotation = false;
				
				-- atualiza o ponteiro para a pedra atual para obedecer a escala

				Runtime:removeEventListener('enterFrame', update)	
				
				-- remove a trajetoria anterior
				for i=1,#trajetory do
					if trajetory[i] then
						trajetory[i]:removeSelf( )
					end
				end
				circle_id = 1

				scale = 1.1

				update = function(e)

						-- Scale Balls
						if scale > 0 then
							scale = scale - variation	
							t.xScale = scale; t.yScale = scale
							local vx, vy = t:getLinearVelocity()
							t:setLinearVelocity(vx*0.94,vy*0.94)

							local nw, nh 
							local myScaleX, myScaleY = scale, scale

							nw = t.width*myScaleX*0.5;
							nh = t.height*myScaleY*0.5;

							physics.addBody( t, { density=0.15, friction=0.2, bounce=0.5 , shape={-nw,-nh,nw,-nh,nw,nh,-nw,nh}} )

							-- exibe trajetoria
							trajetory[circle_id] = assetsTile.newTrajectory(t.x,t.y,.255,.0,.0)					
							circle_id = circle_id + 1								
						end	

					if hit == 0 then
						local M = 2; local N = 2;
						for i=1,(M*N) do
							if (gamelib.hitTestObjects(t, can_tiles1["left"][i])) then
								t.isSensor = false
								walltiles[1]:toFront()								
								physics.removeBody( walltiles[1] )							
								hit = 1	
							end						
							if (gamelib.hitTestObjects(t, can_tiles1["right"][i])) then
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

---------------------------------------------------------------------------------

local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- fisica ligado
	physics.start();	

	createGameplayScenario() -- carrega objetos do cenario

	projectile.ready = true; -- Tell the projectile it's good to go!

	spawnProjectile(); -- Spawn the first projectile.

	state:addEventListener("change", state); -- Create listnener for state changes in the game

	-- Inicia a musica do gameplay
	gamelib.startBackgroundMusic( )

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