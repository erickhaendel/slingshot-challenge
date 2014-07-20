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

-- Assets
local assets_image 				= require( "src.gameplay.assets" )
local assets_audio				= require( "src.gameplay.assets_audio" )
local projectile_tiles_lib		= require( "src.gameplay.assets.projectile_tiles" )
local band_line_tiles_lib 		= require( "src.gameplay.assets.band_line_tiles" )

-- utils
local gamelib 					= require( "src.gameplay.gamelib" )
local configuration 			= require( "src.gameplay.configuration" )

-- Process
local collision_process_lib 	= require( "src.gameplay.process.collision" )
local score_process_lib 		= require( "src.gameplay.process.score" )
local projectile_process_lib 	= require( "src.gameplay.process.projectile" )

-- Network
local network_pregameplay   	= require( "src.network.gameplaysync" )
local player1_obj           	= require( "src.player.player1" )
local player2_obj           	= require( "src.player.player2" )

-- sprite
local donottouch_sprite_lib 	= require( "src.gameplay.assets.donottouch_sprite" )

-------------------------------------------
-- GROUPS
-------------------------------------------
configuration.state_object = display.newGroup();

local slingshot_container = display.newGroup();

----------------------------------------------
-- PROTOTYPE METHODS
----------------------------------------------
local projectileTouchListener, remove_projectile_animation, new_projectile_animation, next_round, next_turn, donottouch_warn

---------------------------------------------
-- METHODS
---------------------------------------------

-- gera uma nova pedra
function spawnProjectile()
	
	-- If there is a projectile available then...
	if(projectile_tiles_lib.ready)then

		projectiles_container = projectile_tiles_lib.newProjectile();

		-- Flag projectiles for removal
		projectiles_container.ready = true;
		projectiles_container.remove = true;
		
		-- Reset the indexing for the visual attributes of the catapult.
		slingshot_container:insert(projectiles_container);

		-- Add an event listener to the projectile.
		projectiles_container:addEventListener("touch", projectileTouchListener);

		configuration.projectile_object = projectiles_container
	end	
end

-- processa os eventos de toque do dedo em cima da pedra
function projectileTouchListener(e)

	-- The current projectile on screen
	local stone = e.target;

		-- If the projectile is 'ready' to be used
		if(stone.ready) then		

				if(e.phase == "began") then -- if the touch event has started...

					stone = projectile_process_lib.ready_to_launch_process(stone)
					-- copia da pedra, usado pelo pubnub
					configuration.projectile_object = stone				

					-- Init the elastic band.
					local myLine = nil;
					local myLineBack = nil;
				
				elseif(stone.isFocus) then -- If the target of the touch event is the focus...

					if configuration.game_current_player == configuration.game_i_am_player_number then 					

					if(e.phase == "moved") then -- If the target of the touch event moves...

						-- If the band exists... refresh the drawing of the line on the stage.
						band_line_tiles_lib.removeBandLine( )

						myLineBack, myLine = band_line_tiles_lib.newBandLine( stone )
						
						-- Insert the components of the catapult into a group.
						--slingshot_container:insert(slingshot_tiles_obj);
						slingshot_container:insert(myLineBack);
						slingshot_container:insert(stone);
						slingshot_container:insert(myLine);

						-- Boundary for the projectile when grabbed	
						-- evita que estique o elastico infinitamente	
						stone = projectile_process_lib.launching_process(stone, e)

					-- If the projectile touch event ends (player lets go)...
					elseif(e.phase == "ended" or e.phase == "cancelled") then

						-- Remove projectile touch so player can't grab it back and re-use after firing.
						projectiles_container:removeEventListener("touch", projectileTouchListener);

						-- Remove the elastic band
						band_line_tiles_lib.removeBandLine( )

						stone = projectile_process_lib.launched_process(stone, e,  assets_image, configuration.state_object)
												
					end
				end
				
				end
			
		
		end

	--end

end

-- GAME STATE CHANGE FUNCTION
function configuration.state_object:change(e)

	if(e.state == "fire") then
		--
		timer.performWithDelay( configuration.time_start_next_round, function ( event )	

				-- terminou o jogo
				if configuration.game_total_rounds <= configuration.game_current_round and configuration.game_current_turn == 2 then					

			    	assets_image.removeGameplayScenario()

			    	-- Destroi eventos criados
					configuration.state_object:removeEventListener("change", configuration.state_object);

					Runtime:removeEventListener("touch", donottouch_warn)		
					
					Runtime:removeEventListener( "enterFrame", assets_image.moveCamera )
					projectiles_container:removeEventListener("touch", projectileTouchListener);

					configuration.game_final_score_player[1] = configuration.game_score_player[1]
					configuration.game_final_score_player[2] = configuration.game_score_player[2]

				    composer.removeScene('src.gameplay.game')
				    composer.gotoScene( "src.menu.results_scene", "fade", 400)

				
				elseif configuration.game_current_turn == 1 then
					print( "Prox turno" )
					-- utilizado pelo pubnub					
					next_turn()
						-- avanca um round					
				elseif configuration.game_current_turn == 2 then
					print( "prox round" )
					-- utilizado pelo pubnub				
					next_round()
				end
			end)

	end
end



-- prepare the gameplay to the next round
function next_turn()

	if configuration.game_current_turn == 1 then 

		configuration.game_current_turn = 2
		gamelib.changeCurrentPlayer()
	end

	Runtime:addEventListener( "enterFrame", assets_image.moveCamera )

	timer.performWithDelay(configuration.time_delay_toshow_slingshot, function ( event )	

		-- collision detection mode on
		configuration.game_is_shooted = 0
		configuration.game_is_hit = 0

		spawnProjectile(); -- Spawn the first projectile.

		Runtime:removeEventListener( "enterFrame", assets_image.moveCamera )

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
		assets_image.hidePointsScoreboards()

		-- cria o label de novo round
		assets_image.reload_round_tiles( )

		-- cria novas latas
		assets_image.reload_can_tiles( )

		Runtime:addEventListener( "enterFrame", assets_image.moveCamera )

		timer.performWithDelay(configuration.time_delay_toshow_slingshot, function ( event )	

			spawnProjectile(); -- Spawn the first projectile.

			Runtime:removeEventListener( "enterFrame", assets_image.moveCamera )

			end)		

end

function donottouch_warn( event )

	local animation

	if configuration.game_current_player ~= configuration.game_i_am_player_number then
		
		animation = donottouch_sprite_lib.newDonottouchSprite(event.x,event.y)
		
		timer.performWithDelay( 400, function( e )
			donottouch_sprite_lib.removeDonottouchSprite(animation)
		end)
		
	end
end

function start_game()
	-- fisica ligado
	physics.start();	

	-- sempre inicia pelo primeiro turno, independente do jogador
	configuration.game_current_turn = 1
	configuration.game_current_round = 1
    configuration.game_score_player[1] = 0  
    configuration.game_score_player[2] = 0  
    configuration.game_final_score_player[1] = 0    
    configuration.game_final_score_player[2] = 0   

  	 -- carrega objetos do cenario
	assets_image.createGameplayScenario()

	Runtime:addEventListener( "enterFrame", assets_image.moveCamera)

	-- passando o cenario para uma variavel global - utilizado pelo pubnub
	configuration.assets_image_object = assets_image


	timer.performWithDelay(configuration.time_delay_toshow_slingshot, function ( event )	

		configuration.state_object:addEventListener("change", configuration.state_object); -- Create listnener for state changes in the game

		-- Tell the projectile it's good to go!
		projectile_tiles_lib.ready = true;

		spawnProjectile(); -- Spawn the first projectile.

		Runtime:removeEventListener( "enterFrame", assets_image.moveCamera )

		Runtime:addEventListener("touch", donottouch_warn)		
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