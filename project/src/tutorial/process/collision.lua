------------------------------------------------------------------------------------------------------------------------------
-- collision.lua
-- Dewcription: gameplay file
-- @author Samuel Martins <samuellunamartins@gmail.com>
-- @version 1.00
-- @date 07/10/2014
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

module(..., package.seeall)

-------------------------------------------
-- LIBs
-------------------------------------------
require( "src.infra.includeall" )

-- my libs
local assets_audio			= require( "src.tutorial.assets_audio" )
local configuration 		= require( "src.tutorial.tutorial_settings" )
local score_process_lib 	= require( "src.tutorial.process.score" )

-- verifica se houve colisao entre dois objetos
function hitTestObjects(obj1, obj2)
    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin

    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax

    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin

    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax

    return (left or right) and (up or down)
end


function animationProcess(assets_image, number, stone)

	--player 1 amarelo faz colisao da pedra com uma unica lata
	if configuration.game_stage == 2 then
		-- adiciona uma fisica proporcional a essa nova dimensao
		local can = assets_image.can_stage2_tiles_obj

		physics.addBody( can,  { density=0.02, friction=0.10, bounce=3.0} )						
		can:applyForce( -10, -10, can.x, can.y);	
		
		assets_image.can_stage2_tiles_obj = can	

		-- Play the hit can
		assets_audio.playHitCan()	
		
		-- stone
		stone.isVisible = false
		stone.isSensor = false
		stone:toBack( )

		-- paredes		
		assets_image.wall_tiles_obj[1]:toFront()	
		assets_image.wall_tiles_obj[2]:toFront()	

		-- chao
		assets_image.ground_tiles_obj[1]:toFront()	

		-- estilingue
		assets_image.slingshot_tiles_obj[1]:toFront()

		configuration.game_is_hit = 1		
	end

	if configuration.game_stage == 3 then
		-- adiciona uma fisica proporcional a essa nova dimensao
		local can1 = assets_image.can_stage3_tiles_obj[1]
		local can2 = assets_image.can_stage3_tiles_obj[2]

		physics.addBody( can1,  { density=0.02, friction=0.10, bounce=3.0} )						
		can1:applyForce( -10, -10, can1.x, can1.y);	
		
		physics.addBody( can2,  { density=0.02, friction=0.10, bounce=3.0} )						
		can2:applyForce( 10, -10, can2.x, can2.y);

		assets_image.can_stage3_tiles_obj[1] = can1	
		assets_image.can_stage3_tiles_obj[2] = can2

		-- Play the hit can
		assets_audio.playHitCan()	
		
		-- stone
		stone.isVisible = false
		stone.isSensor = false
		stone:toBack( )

		-- paredes		
		assets_image.wall_tiles_obj[1]:toFront()	
		assets_image.wall_tiles_obj[2]:toFront()	

		-- chao
		assets_image.ground_tiles_obj[1]:toFront()	

		-- estilingue
		assets_image.slingshot_tiles_obj[1]:toFront()

		configuration.game_is_hit = 1		
	end

	if configuration.game_stage == 4 then
		-- adiciona uma fisica proporcional a essa nova dimensao
		local can1 = assets_image.can_stage4_tiles_obj[1]
		local can2 = assets_image.can_stage4_tiles_obj[2]

		physics.addBody( can1,  { density=0.02, friction=0.10, bounce=3.0} )						
		can1:applyForce( -10, -10, can1.x, can1.y);	
		physics.addBody( can2,  { density=0.02, friction=0.10, bounce=3.0} )						
		can2:applyForce( 10, -10, can2.x, can2.y);			

		assets_image.can_stage4_tiles_obj[1] = can1	
		assets_image.can_stage4_tiles_obj[2] = can2

		-- Play the hit can
		assets_audio.playHitCan()	
		
		-- stone
		stone.isVisible = false
		stone.isSensor = false
		stone:toBack( )

		-- paredes		
		assets_image.wall_tiles_obj[1]:toFront()	
		assets_image.wall_tiles_obj[2]:toFront()	

		-- chao
		assets_image.ground_tiles_obj[1]:toFront()	

		-- estilingue
		assets_image.slingshot_tiles_obj[1]:toFront()

		configuration.game_is_hit = 1		
	end	

	if configuration.game_stage == 5 then
		-- adiciona uma fisica proporcional a essa nova dimensao
		local can1 = assets_image.can_stage5_tiles_obj[1]
		local can2 = assets_image.can_stage5_tiles_obj[2]

		physics.addBody( can1,  { density=0.02, friction=0.10, bounce=3.0} )						
		can1:applyForce( 10, -10, can1.x, can1.y);	
		physics.addBody( can2,  { density=0.02, friction=0.10, bounce=3.0} )						
		can2:applyForce( 10, -10, can2.x, can2.y);			

		assets_image.can_stage5_tiles_obj[1] = can1	
		assets_image.can_stage5_tiles_obj[2] = can2

		-- Play the hit can
		assets_audio.playHitCan()	
		
		-- stone
		stone.isVisible = false
		stone.isSensor = false
		stone:toBack( )

		-- paredes		
		assets_image.wall_tiles_obj[1]:toFront()	
		assets_image.wall_tiles_obj[2]:toFront()	

		-- chao
		assets_image.ground_tiles_obj[1]:toFront()	

		-- estilingue
		assets_image.slingshot_tiles_obj[1]:toFront()

		configuration.game_is_hit = 1		
	end		


	if configuration.game_stage == 6 then
		-- adiciona uma fisica proporcional a essa nova dimensao
		local can1 = assets_image.can_stage6_tiles_obj[1]
		local can2 = assets_image.can_stage6_tiles_obj[2]

		physics.addBody( can1,  { density=0.02, friction=0.10, bounce=3.0} )						
		can1:applyForce( 10, -10, can1.x, can1.y);	
		physics.addBody( can2,  { density=0.02, friction=0.10, bounce=3.0} )						
		can2:applyForce( 10, -10, can2.x, can2.y);			

		assets_image.can_stage6_tiles_obj[1] = can1	
		assets_image.can_stage6_tiles_obj[2] = can2

		-- Play the hit can
		assets_audio.playHitCan()	
		
		-- stone
		stone.isVisible = false
		stone.isSensor = false
		stone:toBack( )

		-- paredes		
		assets_image.wall_tiles_obj[1]:toFront()	
		assets_image.wall_tiles_obj[2]:toFront()	

		-- chao
		assets_image.ground_tiles_obj[1]:toFront()	

		-- estilingue
		assets_image.slingshot_tiles_obj[1]:toFront()

		configuration.game_is_hit = 1		
	end		
	-- -- scoreboard
	-- local Mm = 4 ; local Nn = 5

	-- for kk = 1, 4 do	
	-- 	for jj = 1, Mm do
	-- 		for ii = 1, Nn do
	-- 			assets_image.scoreboard_tiles_obj[kk][Mm * (ii-1) + jj]:toFront( )	
	-- 		end
	-- 	end
	-- end

	-- -- score
	-- for i=1,4 do
	-- 	assets_image.score_player_tiles_obj[i]:toFront( )	
	-- end



	stone:toBack( )		
end

-- detecta colisao da pedra com com as latas e atualiza a gui
function collision_process(stone, assets_image)

	local side = nil

	-- print( "configuration.game_stage: "..configuration.game_stage )
	-- print( "configuration.game_is_shooted: "..configuration.game_is_shooted )
	-- print( "configuration.game_is_hit: "..configuration.game_is_hit )	

	if configuration.game_is_shooted == 1 and configuration.game_is_hit == 0 then

		if configuration.game_stage == 2 then

			local test = hitTestObjects( stone, assets_image.can_stage2_tiles_obj)

			if test then

				animationProcess(assets_image, k, stone)	
				
				score_process_lib.score_process(assets_image)	
			end	
		elseif configuration.game_stage == 3 then

			local test1 = hitTestObjects( stone, assets_image.can_stage3_tiles_obj[1])
			local test2 = hitTestObjects( stone, assets_image.can_stage3_tiles_obj[2])

			if test1 or test2 then
				animationProcess(assets_image, k, stone)	
				score_process_lib.score_process(assets_image)	
			end	
		elseif configuration.game_stage == 4 then

			local test1 = hitTestObjects( stone, assets_image.can_stage4_tiles_obj[1])
			local test2 = hitTestObjects( stone, assets_image.can_stage4_tiles_obj[2])

			if test1 or test2 then
				animationProcess(assets_image, k, stone)	
				score_process_lib.score_process(assets_image)	
			end	
		elseif configuration.game_stage == 5 then

			local test1 = hitTestObjects( stone, assets_image.can_stage5_tiles_obj[1])
			local test2 = hitTestObjects( stone, assets_image.can_stage5_tiles_obj[2])

			if test1 or test2 then
				animationProcess(assets_image, k, stone)	
				score_process_lib.score_process(assets_image)	
			end	
		elseif configuration.game_stage == 6 then

				local test1 = hitTestObjects( stone, assets_image.can_stage6_tiles_obj[1])
				local test2 = hitTestObjects( stone, assets_image.can_stage6_tiles_obj[2])

			if test1 or test2 then
				animationProcess(assets_image, k, stone)	
				score_process_lib.score_process(assets_image)	
			end	
		end	
	end
end -- end of function