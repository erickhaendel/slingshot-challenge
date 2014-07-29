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
local assets_audio			= require( "src.gameplay.assets_audio" )
local configuration 		= require( "src.gameplay.configuration" )
local score_process_lib 	= require( "src.gameplay.process.score" )

-- verifica se houve colisao entre dois objetos
function hitTestObjects(obj1, obj2)
    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin

    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax

    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin

    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax

    return (left or right) and (up or down)
end


function animationProcess(assets_image, number, stone)

	-- adiciona uma fisica proporcional a essa nova dimensao
	local cans = assets_image.can_tiles_obj[number]

	for i=1,4 do
		physics.addBody( cans[i],  { density=0.02, friction=0.10, bounce=3.0} )						
	end

	cans[1]:applyForce( -1, -4.0, cans[1].x, cans[1].y);	
	cans[2]:applyForce( 1, -4.0, cans[2].x, cans[2].y);	
	cans[3]:applyForce( 1, -4.0, cans[3].x, cans[3].y);	
	cans[4]:applyForce( -1, -4.0, cans[4].x, cans[4].y);	

	assets_image.can_tiles_obj[number] = cans

	-- Play the hit can
	assets_audio.playHitCan()

	-- stone
	stone.isVisible = false
	stone.isSensor = false
	stone:toBack( )


	if number == 1 or number == 2 then
		-- paredes		
		assets_image.wall_tiles_obj[1]:toFront()	
		assets_image.wall_tiles_obj[2]:toFront()	

		-- chao
		assets_image.ground_tiles_obj[1]:toFront()	

		-- estilingue
		assets_image.slingshot_tiles_obj[1]:toFront()
	else
		-- paredes		
		assets_image.wall_tiles_obj[3]:toFront()	
		assets_image.wall_tiles_obj[4]:toFront()

		-- chao
		assets_image.ground_tiles_obj[2]:toFront()

		-- estilingue
		assets_image.slingshot_tiles_obj[2]:toFront()		
	end

	-- scoreboard
	local Mm = 4 ; local Nn = 5

	for kk = 1, 4 do	
		for jj = 1, Mm do
			for ii = 1, Nn do
				assets_image.scoreboard_tiles_obj[kk][Mm * (ii-1) + jj]:toFront( )	
			end
		end
	end

	-- score
	for i=1,4 do
		assets_image.score_player_tiles_obj[i]:toFront( )	
	end

	configuration.game_is_hit = 1

	stone:toBack( )		
end

-- detecta colisao da pedra com com as latas e atualiza a gui
function collision_process(stone, assets_image)

	local side = nil

	if configuration.game_is_shooted == 1 and configuration.game_is_hit == 0 then

		local M = 2; local N = 2;	

		for i = 1, N do
			for j = 1, M do
				-- k is the position of the wall 1,2,3,4
				for k=1,4 do

					local test = hitTestObjects( stone, assets_image.can_tiles_obj[k][M * (i-1) + j])

					if test then

						animationProcess(assets_image, k, stone)

						if k == 1 or k==4 then
							side = 1	
							configuration.game_hit_choose[configuration.game_current_player][configuration.game_current_round] = side -- own can
						else
							side = 2	
							configuration.game_hit_choose[configuration.game_current_player][configuration.game_current_round] = side -- own can
						end

						score_process_lib.score_process(assets_image)					
					
						return
					end -- end of if test statement

				end -- end of for k <- walls
			end -- end of for j <- cans
		end -- end of for i <- cans
	end -- end of if
end -- end of function