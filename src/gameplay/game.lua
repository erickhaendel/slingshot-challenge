------------------------------------------------------------------------------------------------------------------------------
-- game.lua
-- Dewcription: gameplay file
-- @author Samuel Martins <samuellunamartins@gmail.com>
-- @version 1.00
-- @date 06/29/2014
-- @website http://www.psyfun.com.br
-- @license MIT license
--
-- The MIT License (MIT)
--
-- Copyright (c) 2014 psyfun
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--
------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------
-- LIBs
-------------------------------------------
require( "src.infra.includeall" )

-- my libs
local assetsTile 			= require( "src.gameplay.assets" )
local assets_audio			= require( "src.gameplay.assets_audio" )
local gamelib 				= require( "src.gameplay.gamelib" )
local configuration 		= require( "src.gameplay.configuration" )
local project_tiles_lib		= require( "src.gameplay.assets.project_tiles" )
local band_line_tiles_lib 	= require( "src.gameplay.assets.band_line_tiles" )
local candisposal 			= require( "src.gameplay.cans_disposal" )
-------------------------------------------
-- GROUPS
-------------------------------------------
local state

state = display.newGroup();

local update = nil

local slingshot_container = display.newGroup();

----------------------------------------------
-- PROTOTYPE METHODS
----------------------------------------------

local projectileTouchListener, can_collision_proccess
local remove_projectile_animation, new_projectile_animation, score_proccess, next_round
local next_turn

---------------------------------------------
-- METHODS
---------------------------------------------

-- gera uma nova pedra
function spawnProjectile()
	
	projectiles_container = project_tiles_lib.newProjectile();
	-- Flag projectiles for removal
	projectiles_container.ready = true;
	projectiles_container.remove = true;
	
	-- Reset the indexing for the visual attributes of the catapult.
	slingshot_container:insert(projectiles_container);

	-- Add an event listener to the projectile.
	projectiles_container:addEventListener("touch", projectileTouchListener);		
end

-- detecta colisao da pedra com com as latas e atualiza a gui
function can_collision_proccess(t)

	local M = 2; local N = 2;	

	local side = nil	

	if configuration.game_is_shooted == 1 and configuration.game_is_hit == 0 then
		for i = 1, N do
			for j = 1, M do

				-- PAREDE 01
				if (gamelib.hitTestObjects( t, assetsTile.can_tiles_obj[1][M * (i-1) + j]) ) then
					-- Play the hit can
					assets_audio.playHitCan()

					t.isSensor = false

					assetsTile.wall_tile_animation( 1 )	
					configuration.game_is_hit = 1
					side = 1

					configuration.game_hit_choose[configuration.game_current_player][configuration.game_current_round] = 1 -- own can
					score_proccess()
					break; -- stop checking hit cans						

				-- PAREDE 2
				elseif (gamelib.hitTestObjects( t, assetsTile.can_tiles_obj[2][M * (i-1) + j]) ) then
					-- Play the hit can
					assets_audio.playHitCan()

					t.isSensor = false

					assetsTile.wall_tile_animation( 2 )				
					configuration.game_is_hit = 1
					side = 2
					configuration.game_hit_choose[configuration.game_current_player][configuration.game_current_round] = 2 -- friend can
					score_proccess()
					break; -- stop checking hit cans	

				-- PAREDE 3								
				elseif (gamelib.hitTestObjects( t, assetsTile.can_tiles_obj[3][M * (i-1) + j]) ) then
					-- Play the hit can
					assets_audio.playHitCan()

					t.isSensor = false

					assetsTile.wall_tile_animation( 3 )	
					configuration.game_is_hit = 1
					side = 2

					configuration.game_hit_choose[configuration.game_current_player][configuration.game_current_round] = 2 -- own can
					score_proccess()
					break; -- stop checking hit cans						

				-- PAREDE 4
				elseif (gamelib.hitTestObjects( t, assetsTile.can_tiles_obj[4][M * (i-1) + j]) ) then
					-- Play the hit can
					assets_audio.playHitCan()

					t.isSensor = false

					assetsTile.wall_tile_animation( 4 )					
					configuration.game_is_hit = 1
					side = 1

					configuration.game_hit_choose[configuration.game_current_player][configuration.game_current_round] = 1 -- friend can
					score_proccess()
					break; -- stop checking hit cans									
				end	
				
			end
		end
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
			assets_audio.playBandStretch()
			
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
				band_line_tiles_lib.removeBandLine( )

				myLineBack, myLine = band_line_tiles_lib.newBandLine( t )
				
				-- Insert the components of the catapult into a group.
				--slingshot_container:insert(slingshot_tiles_obj);
				slingshot_container:insert(myLineBack);
				slingshot_container:insert(t);
				slingshot_container:insert(myLine);

				-- Boundary for the projectile when grabbed	
				-- evita que estique o elastico infinitamente	
				t.x,t.y = gamelib.getBoundaryProjectile( e, t )

			-- If the projectile touch event ends (player lets go)...
			elseif(e.phase == "ended" or e.phase == "cancelled") then

				configuration.game_is_shooted = 1

				-- Remove projectile touch so player can't grab it back and re-use after firing.
				projectiles_container:removeEventListener("touch", projectileTouchListener);
				-- Reset the stage focus
				display.getCurrentStage():setFocus(nil);
				t.isFocus = false;
				
				-- Play the release sound
				assets_audio.playProjecttileShot()
				
				-- Remove the elastic band
				band_line_tiles_lib.removeBandLine( )
				
				-- Launch projectile
				t.bodyType = "dynamic";

				-- FORCA X, FORCA Y, X, Y
				t:applyForce(
					(display.contentCenterX - e.x)*configuration.projecttile_force_multiplier, 
					( assetsTile.slingshot_tiles_obj[configuration.game_current_player].y - e.y)*configuration.projecttile_force_multiplier, 
					t.x, 
					t.y);				
				
				t:applyTorque( configuration.projecttile_torque )
				t.isFixedRotation = false;
				
				Runtime:removeEventListener('enterFrame', update)	
				
				-- remove a animacao da trajetoria da pedra anterior
				--remove_projectile_animation()

				configuration.projecttile_scale = 1.1

				update = function(e)
					-- diminui a escala da pedra e traça sua trajetoria

					project_tiles_lib.new_projectile_animation(t)

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


-- GAME STATE CHANGE FUNCTION
function state:change(e)

	if(e.state == "fire") then
		
		--
		timer.performWithDelay( configuration.time_start_next_round, function ( event )	

				-- terminou o jogo
				if configuration.game_total_rounds < configuration.game_current_round then					

			    	assetsTile.removeGameplayScenario()

			    	-- Destroi eventos criados
					state:removeEventListener("change", state);	
					Runtime:removeEventListener( "enterFrame", assetsTile.moveCamera )
					projectiles_container:removeEventListener("touch", projectileTouchListener);

				    composer.removeScene('src.gameplay.game')
				    composer.gotoScene( "src.gameplay.results", "fade", 400)
				
				elseif configuration.game_current_turn == 1 then
					print( "Prox turno" )
					next_turn()
						-- avanca um round					
				elseif configuration.game_current_turn == 2 then
					print( "prox round" )
					next_round()
				end
			end)

	end
end

-- processa o score dos players e atualiza o scoreboard
function score_proccess()

	local player = configuration.game_current_player -- alias
	
	local intend_to_hit = configuration.game_hit_choose[configuration.game_current_player][configuration.game_current_round] -- alias

	local cans_disposal = candisposal.prepare_cans_disposition(  )

	local points_p1 = 0
	local points_p2 = 0

	-- contagem de pontos
	for i=1,configuration.pack_of_cans do

		-- player 1 , current round => colorful can == 1 ? true
		if cans_disposal[1][configuration.game_current_round][i] == 1 then
			points_p1 = points_p1 + 1
		end

		-- player 2, current round => colorful can == 1 ? true
		if cans_disposal[2][configuration.game_current_round][i] == 1 then
			points_p2 = points_p2 + 1
		end		
	end

	-- cenario 01, jogador 1 acerta suas proprias latas
	if player == 1 and intend_to_hit == 1  then
		configuration.game_score_player[1] = configuration.game_score_player[1] + points_p1

	-- cenario 01, jogador 1 acerta as latas do jogador 2
	elseif player == 1 and intend_to_hit == 2 then
		configuration.game_score_player[2] = configuration.game_score_player[2] + points_p2

	-- cenario 02, jogador 1 acerta as latas do jogador 1
	elseif player == 2 and intend_to_hit == 1 then
		configuration.game_score_player[1] = configuration.game_score_player[1] + points_p1

	-- cenario 02, jogador 2 acerta suas proprias latas
	elseif player == 2 and intend_to_hit == 2 then
		configuration.game_score_player[2] = configuration.game_score_player[2] + points_p2
	end

	-- exibe os pontos na grade
	assetsTile.score_animation( intend_to_hit )
end



-- prepare the gameplay to the next round
function next_turn()

	if configuration.game_current_turn == 1 then 

		configuration.game_current_turn = 2
		gamelib.changeCurrentPlayer()
	end

	-- collision detection mode on
	configuration.game_is_shooted = 0
	configuration.game_is_hit = 0

	gamelib.debug_gameplay()

	Runtime:addEventListener( "enterFrame", assetsTile.moveCamera )

	timer.performWithDelay(configuration.time_delay_toshow_slingshot, function ( event )	

		spawnProjectile(); -- Spawn the first projectile.

		Runtime:removeEventListener( "enterFrame", assetsTile.moveCamera )

		end)	
end

-- prepare the gameplay to the next round
function next_round()

		-- reset turn
		configuration.game_current_turn = 1

		-- change the current player
		gamelib.changeCurrentPlayer()

		-- next round
		configuration.game_current_round = configuration.game_current_round + 1

		-- collision detection mode on
		configuration.game_is_shooted = 0
		configuration.game_is_hit = 0

		-- deal with scores
		configuration.game_final_score_player[1] = configuration.game_score_player[1]
		configuration.game_final_score_player[2] = configuration.game_score_player[2]
		configuration.game_score_player[1] = 0
		configuration.game_score_player[2] = 0	

		-- reload scoreboards
		assetsTile.hidePointsScoreboards()

		-- adiciona fisica novamente ao muro para sustentar as novas latas
		assetsTile.reconfigure_wall_tile( 1 )
		assetsTile.reconfigure_wall_tile( 2 )		
		assetsTile.reconfigure_wall_tile( 3 )
		assetsTile.reconfigure_wall_tile( 4 )

		-- cria o label de novo round
		assetsTile.reload_round_tiles( )

		-- cria novas latas
		assetsTile.reload_can_tiles( )

		Runtime:addEventListener( "enterFrame", assetsTile.moveCamera )

		timer.performWithDelay(configuration.time_delay_toshow_slingshot, function ( event )	

			spawnProjectile(); -- Spawn the first projectile.

			Runtime:removeEventListener( "enterFrame", assetsTile.moveCamera )

			end)		

end

function start_game()
	-- fisica ligado
	physics.start();	

	-- sempre inicia pelo primeiro turno, independente do jogador
	configuration.game_current_turn = 1

	-- escolhe entre o jogador 1 ou 2 quem vai iniciar primeiro o jogo
	configuration.game_current_player = math.random( 1, 2 )

	assetsTile.createGameplayScenario() -- carrega objetos do cenario

	Runtime:addEventListener( "enterFrame", assetsTile.moveCamera)

	timer.performWithDelay(configuration.time_delay_toshow_slingshot, function ( event )	

		state:addEventListener("change", state); -- Create listnener for state changes in the game

		spawnProjectile(); -- Spawn the first projectile.

		Runtime:removeEventListener( "enterFrame", assetsTile.moveCamera )

		end)

	-- Inicia a musica do gameplay
	assets_audio.startBackgroundMusic( )
end

---------------------------------------------------------------------------------

local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	start_game()

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