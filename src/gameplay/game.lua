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
local configuration = require( "src.gameplay.configuration" )

-------------------------------------------
-- GROUPS
-------------------------------------------
local state

state = display.newGroup();

-- objetos de cenario
local houseTile, walltiles, can_tiles, grassTile, slingshot, labels, roundLabel, score_cans

-- Variables setup
local projectiles_container = nil;

local update = nil

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
-- PROTOTYPE METHODS
----------------------------------------------

local projectileTouchListener, spawnProjectile, createGameplayScenario, moveCamera, can_collision_proccess
local previsaoColisao, remove_projectile_animation, new_projectile_animation, score_proccess, next_round
local removeGameplayScenario

---------------------------------------------
-- METHODS
---------------------------------------------

function removeGameplayScenario()

	hit = 2

	state:removeEventListener("change", state);	

	assetsTile.removeSky( skyTile )

	assetsTile.removeHouseTile(houseTile)

	assetsTile.removeWallTiles( walltiles )

	assetsTile.removeCanTiles(can_tiles)

	assetsTile.removeGrassTile( grassTile )

	if slingshot then slingshot:removeSelf( ); slingshot = nil; end

	assetsTile.removeScoreboard(score_cans)

	assetsTile.removeScoreLabels(scoreLabel)
end

function createGameplayScenario()

	-- Animacao do ceu
	skyTile = assetsTile.startSky();

	-- carrega a casa
	houseTile = assetsTile.newHouseTile()

	-- carrega a parede no cenario
	walltiles = assetsTile.newWallTile();

	-- carrega as latas em cima da parede
	can_tiles = {};
	can_tiles[1], can_tiles[2], can_tiles[3], can_tiles[4] = assetsTile.newCanTile()

	-- carrega o chao
	grassTile = assetsTile.newGrassTile()

	-- carrega a imagem do slingshot
	slingshot = assetsTile.newSlingshotTile()

	-- carrega as labels identificando os cenários
	label1, label2 = assetsTile.newTitlePlayerLabel()
	timer.performWithDelay( configuration.time_hide_title_player_label, function ( event )	
		label1:removeSelf( );label1=nil;
		label2:removeSelf( );label2=nil;
		end)

	roundLabel = {}
	timer.performWithDelay( configuration.time_show_round_label, function ( event )	
		
		roundLabel[1], roundLabel[2] = assetsTile.newRoundLabel()

		timer.performWithDelay( configuration.time_hide_round_label, function ( event )	
				roundLabel[1]:removeSelf( );roundLabel[1] = nil;
				roundLabel[2]:removeSelf( );roundLabel[2] = nil;
			end)
		end)

	-- as latas de scores dos scoreboards
	score_cans = {};	
	score_cans[1], score_cans[2], score_cans[3], score_cans[4] = assetsTile.new_scoreboard()

	-- carrega as labels identificando os scoreboards
	scoreLabel = {}
	scoreLabel[1], scoreLabel[2], scoreLabel[3], scoreLabel[4] = assetsTile.newScorePlayerLabel()

	if current_player == 1 then
		assetsTile.setAssetsGroupPosition(display.contentCenterX - 2100, nil)
	end	

	Runtime:addEventListener( "enterFrame", moveCamera )	

end

-- animation between of thw two players screen
function moveCamera()

	local p = current_player

	local assetsGroup = assetsTile.getAssetsGroup()
	local velocity = configuration.camera_velocity

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

-- gera uma nova pedra
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

-- nao esta sendo usado, pode ignorar nesse momento
local lastTargettile
function previsaoColisao(t)

	local ps = projectile.newSpecialProjectile(t.x,t.y)
	ps:localToContent( t.x,t.y )
	ps.isVisible = false	

	local s_scale = 1.1

	-- Launch projectile
	ps.bodyType = "dynamic";
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
			
				s_scale = s_scale - configuration.projecttile_variation

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
		
		--
		timer.performWithDelay( configuration.time_start_next_round, function ( event )	
				next_round()
			end)

	end
end

-- nao esta sendo usado por enquanto, pode ignorar
function remove_projectile_animation()
	-- remove a trajetoria anterior
	for i=1,#trajetory do
		if trajetory[i] then
			trajetory[i]:removeSelf( )
		end
	end

	circle_id = 1
	configuration.projecttile_scale = 1.1
end

-- processa a emulacao gráfica do eixo Z para dar impressão de profundidade
function new_projectile_animation(t)
	-- Scale Balls
	if configuration.projecttile_scale > 0 then
		configuration.projecttile_scale = configuration.projecttile_scale - configuration.projecttile_variation	
		t.xScale = configuration.projecttile_scale; t.yScale = configuration.projecttile_scale
		local vx, vy = t:getLinearVelocity()
		t:setLinearVelocity(vx*0.94,vy*0.94)

		local nw, nh 
		local myScaleX, myScaleY = configuration.projecttile_scale, configuration.projecttile_scale

		nw = t.width*myScaleX*0.5;
		nh = t.height*myScaleY*0.5;

		physics.addBody( t, { density=0.15, friction=0.2, bounce=0.5 , shape={-nw,-nh,nw,-nh,nw,nh,-nw,nh}} )

		-- exibe trajetoria 
		--trajetory[circle_id] = assetsTile.newTrajectory(t.x,t.y,.255,.0,.0)					
		--circle_id = circle_id + 1								
	end	
end

-- processa o score dos players e atualiza o scoreboard
function score_proccess(player)

	configuration.game_score_player[player] = configuration.game_score_player[player] + 4*player

	for i=1,configuration.game_score_player[player] do
		timer.performWithDelay(10+i*110, function(e)

		score_cans[player][i].isVisible = true -- could index 1 or 2 - i did this to not write an if/else statemment
		score_cans[5 - player][i].isVisible = true -- could be index 4 or 3		
		scoreLabel[player].text = "Player "..player.." >> "..i -- could index 1 or 2 - i did this to not write an if/else statemment
		scoreLabel[5 - player].text = "Player "..player.." >> "..i-- could be index 4 or 3							
			
		-- Play increasing score
		gamelib.playIncreasingScore()							
		end)
	end
end

-- detecta colisao da pedra com com as latas e atualiza a gui
function can_collision_proccess(t)

	local M = 2; local N = 2;	

	local side = nil	

	if hit == 0 then
		for i = 1, N do
			for j = 1, M do
				if (gamelib.hitTestObjects( t, can_tiles[1][M * (i-1) + j]) ) then
					-- Play the hit can
					gamelib.playHitCan()

					t.isSensor = false
					walltiles[1]:toFront()								
					physics.removeBody( walltiles[1] )							
					hit = 1
					side = 1

					break; -- stop checking hit cans						
				--end

				elseif (gamelib.hitTestObjects( t, can_tiles[2][M * (i-1) + j]) ) then
					-- Play the hit can
					gamelib.playHitCan()

					t.isSensor = false
					walltiles[2]:toFront()
					physics.removeBody( walltiles[2] )
					hit = 1
					side = 2

					break; -- stop checking hit cans									
				end							
			end
		end
	end

	-- atualiza a grade de score
	if hit == 1 then
		hit = 2		
		score_proccess(side)					
	end	
end

-- prepare the gameplay to the next round
function next_round()

	if configuration.game_total_rounds > configuration.game_current_round then

		-- next round
		configuration.game_current_round = configuration.game_current_round + 1

		-- collision detection mode on
		hit = 0 

		-- deal with scores
		configuration.game_final_score_player[1] = configuration.game_score_player[1]
		configuration.game_final_score_player[2] = configuration.game_score_player[2]
		configuration.game_score_player[1] = 0
		configuration.game_score_player[2] = 0	

		-- reload scoreboards
		score_cans = assetsTile.hidePointsScoreboards(score_cans)

		-- adiciona fisica novamente ao muro para sustentar as novas latas
		physics.addBody( walltiles[1], "static", configuration.wallBody )
		physics.addBody( walltiles[2], "static", configuration.wallBody )

		-- cria o label de novo round
		roundLabel[1], roundLabel[2] = assetsTile.newRoundLabel()

		-- remove as latas do round anterior
		assetsTile.removeCanTiles(can_tiles)

		-- cria novas latas
		can_tiles[1], can_tiles[2], can_tiles[3], can_tiles[4] = assetsTile.newCanTile()

		timer.performWithDelay( configuration.time_hide_round_label, function ( event )	
				roundLabel[1]:removeSelf( );roundLabel[1] = nil;
				roundLabel[2]:removeSelf( );roundLabel[2] = nil;
			end)


		spawnProjectile(); -- new projectile please		

	else
    	removeGameplayScenario()
	    composer.removeScene('src.gameplay.game')
	    composer.gotoScene( "src.gameplay.results", "fade", 400)
	end
end

-- processa os eventos de toque do dedo em cima da pedra
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
--				if system.getTimer() > cronometro_inicio + 4 then
--					previsaoColisao(t)		
--					cronometro_ligado = 0	
--				end	

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

				--
				t:applyForce((display.contentCenterX - e.x)*configuration.projecttile_force_multiplier, (slingshot.y - e.y)*configuration.projecttile_force_multiplier, t.x, t.y);				
				--t:applyForce((slingshot.x - t.x)*0.4*configuration.projecttile_force_multiplier, (slingshot.y - t.y)*0.4*configuration.projecttile_force_multiplier, t.x, t.y);
				t:applyTorque( configuration.projecttile_torque )
				t.isFixedRotation = false;
				
				Runtime:removeEventListener('enterFrame', update)	
				
				-- remove a animacao da trajetoria da pedra anterior
				--remove_projectile_animation()

				configuration.projecttile_scale = 1.1

				update = function(e)
					-- diminui a escala da pedra e traça sua trajetoria

					new_projectile_animation(t)

					-- monitora colisao com as latas
					can_collision_proccess(t)					
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

	-- carrega a imagem do slingshot
	timer.performWithDelay(configuration.time_delay_toshow_slingshot, function ( event )	

		configuration.game_total_rounds = math.random( 1, configuration.game_max_allowed_rounds )
		print( "Total de rounds a ser disputados: "..configuration.game_total_rounds )

		projectile.ready = true; -- Tell the projectile it's good to go!

		state:addEventListener("change", state); -- Create listnener for state changes in the game

		spawnProjectile(); -- Spawn the first projectile.

		end)

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