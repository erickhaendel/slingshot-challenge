------------------------------------------------------------------------------------------------------------------------------
-- game.lua
-- Dewcription: tutorial gameplay file
-- @author Samuel Martins <samuellunamartins@gmail.com>
-- @version 1.00
-- @date 07/30/2014
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
local assets_image 				= require( "src.tutorial.assets" )
local assets_audio				= require( "src.tutorial.assets_audio" )
local projectile_tiles_lib		= require( "src.tutorial.assets.projectile_tiles" )
local band_line_tiles_lib 		= require( "src.tutorial.assets.band_line_tiles" )

-- utils
local gamelib 					= require( "src.tutorial.gamelib" )
local configuration 			= require( "src.tutorial.tutorial_settings" )

-- Process
local collision_process_lib 	= require( "src.tutorial.process.collision" )
local projectile_process_lib 	= require( "src.tutorial.process.projectile" )

-- sprite
local donottouch_sprite_lib 	= require( "src.tutorial.assets.donottouch_sprite" )
local checked_sprite_lib 		= require( "src.tutorial.assets.checked_sprite" )
local man_sprite_lib 			= require( "src.tutorial.assets.man_sprite" )
local arrow_sprite_lib 			= require( "src.tutorial.assets.arrow_sprite" )

-------------------------------------------
-- GROUPS
-------------------------------------------
configuration.state_object = display.newGroup();

local slingshot_container = display.newGroup();

-------------------------------------------
-- SPRITES
-------------------------------------------
local man_yellow_sprite, man_green_sprite, arrow_sprite, current_arrow

----------------------------------------------
-- PROTOTYPE METHODS
----------------------------------------------
local projectileTouchListener, remove_projectile_animation, new_projectile_animation, next_round, next_turn, donottouch_warn
local stage_1, stage_2, stage_3, stage_4, stage_5, stage_6
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
					slingshot_container:insert(myLineBack);
					slingshot_container:insert(stone);
					slingshot_container:insert(myLine);

					-- Boundary for the projectile when grabbed	
					-- evita que estique o elastico infinitamente	
					stone = projectile_process_lib.launching_process(stone, e)

				-- If the projectile touch event ends (player lets go)...
				elseif(e.phase == "ended" or e.phase == "cancelled") then

					configuration.game_is_shooted =  1

					-- Remove projectile touch so player can't grab it back and re-use after firing.
					projectiles_container:removeEventListener("touch", projectileTouchListener);

					-- Remove the elastic band
					band_line_tiles_lib.removeBandLine( )

					stone = projectile_process_lib.launched_process(stone, e,  assets_image, configuration.state_object)

					if configuration.game_stage == 1 then

						if configuration.game_is_shooted >= 1 then
							-- aparece o checked verde
							local checked_sprite = checked_sprite_lib.newCheckedSprite(configuration.checked_sprite_position_x,configuration.checked_sprite_position_y)

							timer.performWithDelay( 1500, function( e )
									checked_sprite_lib.removeCheckedSprite(checked_sprite)
								end)

							-- fim do estagio 1
							configuration.game_is_shooted = 0
							configuration.game_is_hit = 0
							configuration.game_stage = 2
						end
					end

					if configuration.game_stage == 2 then

						if configuration.game_is_hit == 1 then
							-- aparece o checked verde
							local checked_sprite = checked_sprite_lib.newCheckedSprite(configuration.checked_sprite_position_x,configuration.checked_sprite_position_y)

							timer.performWithDelay( 1500, function( e )
									checked_sprite_lib.removeCheckedSprite(checked_sprite)
								end)

							-- fim do estagio 2
							configuration.game_is_shooted = 0
							configuration.game_is_hit = 0
							configuration.game_stage = 3
						end
					end

					if configuration.game_stage == 3 then

					    if configuration.game_is_hit == 1 then
							-- aparece o checked verde
							local checked_sprite = checked_sprite_lib.newCheckedSprite(configuration.checked_sprite_position_x,configuration.checked_sprite_position_y)

							timer.performWithDelay( 1500, function( e )
									checked_sprite_lib.removeCheckedSprite(checked_sprite)
								end)

							-- fim do estagio 3
							configuration.game_is_shooted = 0
							configuration.game_is_hit = 0
							configuration.game_stage = 4
						end
					end

					if configuration.game_stage == 4 then

					    if configuration.game_is_hit == 1 then
							-- aparece o checked verde
							local checked_sprite = checked_sprite_lib.newCheckedSprite(configuration.checked_sprite_position_x,configuration.checked_sprite_position_y)

							timer.performWithDelay( 1500, function( e )
									checked_sprite_lib.removeCheckedSprite(checked_sprite)
								end)

							-- fim do estagio 3
							configuration.game_is_shooted = 0
							configuration.game_is_hit = 0
							configuration.game_stage = 5
						end
					end	


					if configuration.game_stage == 5 then

					    if configuration.game_is_hit == 1 then
							-- aparece o checked verde
							local checked_sprite = checked_sprite_lib.newCheckedSprite(configuration.checked_sprite_position_x,configuration.checked_sprite_position_y)

							timer.performWithDelay( 1500, function( e )
									checked_sprite_lib.removeCheckedSprite(checked_sprite)
								end)

							-- fim do estagio 3
							configuration.game_is_shooted = 0
							configuration.game_is_hit = 0
							configuration.game_stage = 6
						end
					end

					if configuration.game_stage == 6 then

					    if configuration.game_is_hit == 1 then
							-- aparece o checked verde
							local checked_sprite = checked_sprite_lib.newCheckedSprite(configuration.checked_sprite_position_x,configuration.checked_sprite_position_y)

							timer.performWithDelay( 1500, function( e )
									checked_sprite_lib.removeCheckedSprite(checked_sprite)
								end)

							-- fim do estagio 3
							configuration.game_is_shooted = 0
							configuration.game_is_hit = 0
							configuration.game_stage = 7
						end
					end					
				end
			end		
		end
	end
end

-- GAME STATE CHANGE FUNCTION
function configuration.state_object:change(e)

	if(e.state == "fire") then
		
		if configuration.game_stage == 1 then stage_1()				
		elseif configuration.game_stage == 2 then stage_2()				
		elseif configuration.game_stage == 3 then stage_3()				
		elseif configuration.game_stage == 4 then stage_4()				
		elseif configuration.game_stage == 5 then stage_5()				
		elseif configuration.game_stage == 6 then stage_6()
		-- terminou o jogo
		elseif configuration.game_stage > 6 then					

	    	assets_image.removeGameplayScenario()

	    	-- Destroi eventos criados
			configuration.state_object:removeEventListener("change", configuration.state_object);

			Runtime:removeEventListener("touch", donottouch_warn)		
			
			Runtime:removeEventListener( "enterFrame", assets_image.moveCamera )
			projectiles_container:removeEventListener("touch", projectileTouchListener);

		    composer.removeScene('src.tutorial.game')
		    composer.gotoScene( "src.menu.results_scene", "fade", 400)
		end

	end
end

-- Show how to use the slingshot 
function stage_1()

	configuration.game_current_player = 1
	timer.performWithDelay(configuration.time_delay_toshow_slingshot, function ( event )	

		spawnProjectile(); -- Spawn the first projectile.

		end)	
end

-- Show how to shoot a target and increase score with yellow player
function stage_2( )

	configuration.game_current_player = 1

	if configuration.game_is_shooted == 0 then

		timer.performWithDelay(2000, function ( )
				assets_image.createStage2()
		end)

		-- seta indicando que é para acertar a lata			
		timer.performWithDelay(5000, function ()
		current_arrow = arrow_sprite_lib.newArrowSprite_270(display.contentCenterX + 60, display.contentCenterY - 120)	
		end)

		-- transporta o man sprite para perto do estilingue
		timer.performWithDelay( 750, function()
			man_yellow_sprite = man_sprite_lib.newManYellowRightSprite(
				configuration.man_yellow_right_sprite_position_x, 
				configuration.man_yellow_right_sprite_position_y)

			transition.to(man_yellow_sprite, {time=1600, x = configuration.stone_position_x- 120, transition = easingx.easeOut});
		
			timer.performWithDelay( 3200, function()
				transition.to(man_yellow_sprite, {time=1200, x = configuration.stone_position_x - 400, transition = easingx.easeOut});
			end)
		end)

	end

	timer.performWithDelay(configuration.time_delay_toshow_slingshot, function ( event )	

		spawnProjectile(); -- Spawn the first projectile.

		end)	


	timer.performWithDelay( 200, function( )
		if current_arrow then			
			current_arrow:removeSelf( ); current_arrow = nil;
		end			
	end )
end

-- Show how to shoot a target with neutral and not neutral can
function stage_3( )


	configuration.game_current_player = 1

	if configuration.game_is_shooted == 0 then

		assets_image.createStage3()

		-- seta indicando que é para acertar a lata			
		current_arrow = arrow_sprite_lib.newArrowSprite_225(display.contentCenterX + 40, display.contentCenterY - 320)	
	end

	timer.performWithDelay(configuration.time_delay_toshow_slingshot, function ( event )	

		spawnProjectile(); -- Spawn the first projectile.

		end)	


	timer.performWithDelay( 2000, function( )
		if current_arrow then			
			current_arrow:removeSelf( ); current_arrow = nil;
		end			
	end )
end

-- o player amarelo acerta duas latas verdes e os pontos vao para o player 2
function stage_4()


	configuration.game_current_player = 1

	if configuration.game_is_shooted == 0 then

		assets_image.createStage4()

		-- seta indicando que é para acertar a lata			
		current_arrow = arrow_sprite_lib.newArrowSprite_90(display.contentCenterX - 60, display.contentCenterY - 120)			
	end

	timer.performWithDelay(configuration.time_delay_toshow_slingshot, function ( event )	

		spawnProjectile(); -- Spawn the first projectile.

		end)	


		timer.performWithDelay( 2000, function( )
			if current_arrow then			
				current_arrow:removeSelf( ); current_arrow = nil;
			end			
		end )

end

-- o player verde entra e joga no seu turno.
function stage_5()

	configuration.game_current_player = 2

	if configuration.game_is_shooted == 0 then

		timer.performWithDelay(4000, function () 
			assets_image.createStage5()
		end)

		-- seta indicando que é para acertar a lata			
		-- timer.performWithDelay(6000, function ()
		-- current_arrow = arrow_sprite_lib.newArrowSprite_90(display.contentCenterX - 60, display.contentCenterY - 120)			
		-- end)

		-- transporta o man sprite para perto do estilingue
		timer.performWithDelay( 750, function()

			-- o homem amarelo sai de cena
			man_sprite_lib.removeManSprite( man_yellow_sprite )					
			man_yellow_sprite = man_sprite_lib.newManYellowLeftSprite(
				configuration.stone_position_x - 400, 
				configuration.man_yellow_left_sprite_position_y)
		
			transition.to(man_yellow_sprite, {time=3500, x = -300, transition = easingx.easeOut});
		
			-- homem verde entra em cena
			man_green_sprite = man_sprite_lib.newManGreenLeftSprite(
				configuration.man_green_left_sprite_position_x, 
				configuration.man_green_left_sprite_position_y)

			transition.to(man_green_sprite, {time=1600, x = configuration.stone_position_x + 120, transition = easingx.easeOut});
		
			timer.performWithDelay( 3200, function()
				transition.to(man_green_sprite, {time=1200, x = configuration.stone_position_x + 400, transition = easingx.easeOut});
			end)
		end)

	end

	timer.performWithDelay(configuration.time_delay_toshow_slingshot, function ( event )	

		spawnProjectile(); -- Spawn the first projectile.

		end)	


		timer.performWithDelay( 8000, function( )
			if current_arrow then			
				current_arrow:removeSelf( ); current_arrow = nil;
			end	

			-- lanca automaticamente
			configuration.game_is_shooted =  1

			-- Remove projectile touch so player can't grab it back and re-use after firing.
			projectiles_container:removeEventListener("touch", projectileTouchListener);

			-- Remove the elastic band
			band_line_tiles_lib.removeBandLine( )

			configuration.projectile_object.x = 250
			configuration.projectile_object.y = configuration.stone_position_y + 530	

			local pseudo_stone = configuration.projectile_object

			configuration.projectile_object = projectile_process_lib.launched_process(
				configuration.projectile_object, 
				pseudo_stone,  
				assets_image, 
				configuration.state_object)

			timer.performWithDelay( 3000, function( )
				    if configuration.game_is_hit == 1 then
						-- aparece o checked verde
						local checked_sprite = checked_sprite_lib.newCheckedSprite(configuration.checked_sprite_position_x,configuration.checked_sprite_position_y)

						timer.performWithDelay( 1500, function( e )
								checked_sprite_lib.removeCheckedSprite(checked_sprite)
							end)

						-- fim do estagio 3
						configuration.game_is_shooted = 0
						configuration.game_is_hit = 0
						configuration.game_stage = 6
					end	
				end)		

		end )

end


-- o player verde entra e joga no seu turno.
function stage_6()

	print( "estagio 6 chamado" )

	configuration.game_current_player = 2

	if configuration.game_is_shooted == 0 then

		assets_image.createStage6()

		-- -- seta indicando que é para acertar a lata			
		-- current_arrow = arrow_sprite_lib.newArrowSprite_90(display.contentCenterX - 60, display.contentCenterY - 120)			

		-- transporta o man sprite para perto do estilingue
		timer.performWithDelay( 750, function()

			-- o homem amarelo sai de cena
			man_sprite_lib.removeManSprite( man_yellow_sprite )					
			man_yellow_sprite = man_sprite_lib.newManYellowLeftSprite(
				configuration.stone_position_x - 400, 
				configuration.man_yellow_left_sprite_position_y)
		
			transition.to(man_yellow_sprite, {time=3500, x = -300, transition = easingx.easeOut});
		
			-- homem verde entra em cena
			man_green_sprite = man_sprite_lib.newManGreenLeftSprite(
				configuration.man_green_left_sprite_position_x, 
				configuration.man_green_left_sprite_position_y)

			transition.to(man_green_sprite, {time=1600, x = configuration.stone_position_x + 120, transition = easingx.easeOut});
		
			timer.performWithDelay( 3200, function()
				transition.to(man_green_sprite, {time=1200, x = configuration.stone_position_x + 400, transition = easingx.easeOut});
			end)
		end)

	end

	timer.performWithDelay(configuration.time_delay_toshow_slingshot, function ( event )	

		spawnProjectile(); -- Spawn the first projectile.

		end)	


		timer.performWithDelay( 8000, function( )
			if current_arrow then			
				current_arrow:removeSelf( ); current_arrow = nil;
			end	

			-- lanca automaticamente
			configuration.game_is_shooted =  1

			-- Remove projectile touch so player can't grab it back and re-use after firing.
			projectiles_container:removeEventListener("touch", projectileTouchListener);

			-- Remove the elastic band
			band_line_tiles_lib.removeBandLine( )

			configuration.projectile_object.x = -1000
			configuration.projectile_object.y = configuration.stone_position_y + 530	

			local pseudo_stone = configuration.projectile_object

			configuration.projectile_object = projectile_process_lib.launched_process(
				configuration.projectile_object, 
				pseudo_stone,  
				assets_image, 
				configuration.state_object)

			timer.performWithDelay( 3000, function( )
				    if configuration.game_is_hit == 1 then
						-- aparece o checked verde
						local checked_sprite = checked_sprite_lib.newCheckedSprite(configuration.checked_sprite_position_x,configuration.checked_sprite_position_y)

						timer.performWithDelay( 1500, function( e )
								checked_sprite_lib.removeCheckedSprite(checked_sprite)
							end)

						-- fim do estagio 3
						configuration.game_is_shooted = 0
						configuration.game_is_hit = 0
						configuration.game_stage = 7
					end	
				end)		

		end )

end

function stage_7()

	-- current_arrow:removeSelf( )
	-- current_arrow = nil

	if man_green_sprite then
		man_green_sprite:removeSelf( ); man_green_sprite = nil;
	end


	if man_yellow_sprite then
		man_yellow_sprite:removeSelf( ); man_green_sprite = nil;
	end

	assets_image.removeStage()

	-- Destroi eventos criados
	configuration.state_object:removeEventListener("change", configuration.state_object);

	Runtime:removeEventListener("touch", donottouch_warn)		
	
	Runtime:removeEventListener( "enterFrame", assets_image.moveCamera )
	projectiles_container:removeEventListener("touch", projectileTouchListener);

    composer.removeScene('src.tutorial.game')
    composer.gotoScene( "src.menu.results_scene", "fade", 400)
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

    configuration.game_score_player[1] = 0  
    configuration.game_score_player[2] = 0  
    configuration.game_final_score_player[1] = 0    
    configuration.game_final_score_player[2] = 0   
    configuration.game_stage = 1

   	assets_image.createStage1() 	

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