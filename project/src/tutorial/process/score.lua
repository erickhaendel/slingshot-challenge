------------------------------------------------------------------------------------------------------------------------------
-- score.lua
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

module(..., package.seeall) -- este arquivo é uma biblioteca

-------------------------------------------
-- LIBs
-------------------------------------------
require( "src.infra.includeall" )

-- my libs
local assets_audio			= require( "src.gameplay.assets_audio" )

local configuration 		= require( "src.tutorial.tutorial_settings" )

local can_process_lib 		= require( "src.gameplay.process.can" )

local arrow_sprite_lib 		= require( "src.tutorial.assets.arrow_sprite" )

score_animation, score_process = nil, nil


function score_animation( assets_image )

	if configuration.game_stage == 2 then
		-- Play increasing score
		assets_audio.playIncreasingScore()		

		assets_image.myCircleYellow_upperScore_tiles_obj[1][1].isVisible = true	

		-- seta indicando que é para acertar a lata			
		current_arrow = arrow_sprite_lib.newArrowSprite_0(display.contentCenterX - 500, display.contentCenterY)	

		timer.performWithDelay( 3000, function( )
			if current_arrow then			
				current_arrow:removeSelf( ); current_arrow = nil;
			end			
		end )


	elseif configuration.game_stage == 3 then
		-- Play increasing score
		assets_audio.playIncreasingScore()		
		assets_image.myCircleYellow_upperScore_tiles_obj[1][2].isVisible = true	

		-- seta indicando que é para acertar a lata			
		current_arrow = arrow_sprite_lib.newArrowSprite_0(display.contentCenterX - 500, display.contentCenterY)	

		timer.performWithDelay( 3000, function( )
			if current_arrow then			
				current_arrow:removeSelf( ); current_arrow = nil;
			end			
		end )		

	elseif configuration.game_stage == 4 then
		-- Play increasing score
		assets_audio.playIncreasingScore()		
		assets_image.myCircleGreen_upperScore_tiles_obj[1][1].isVisible = true	
		assets_image.myCircleGreen_upperScore_tiles_obj[1][2].isVisible = true	
				
		-- seta indicando que é para acertar a lata			
		current_arrow = arrow_sprite_lib.newArrowSprite_0(display.contentCenterX + 350, display.contentCenterY)	

		timer.performWithDelay( 3000, function( )
			if current_arrow then			
				current_arrow:removeSelf( ); current_arrow = nil;
			end			
		end )	

	elseif configuration.game_stage == 5 then
		-- Play increasing score
		assets_audio.playIncreasingScore()		
		assets_image.myCircleGreen_upperScore_tiles_obj[1][3].isVisible = true	
				
		-- seta indicando que é para acertar a lata			
		current_arrow = arrow_sprite_lib.newArrowSprite_0(display.contentCenterX + 350, display.contentCenterY)	

		timer.performWithDelay( 3000, function( )
			if current_arrow then			
				current_arrow:removeSelf( ); current_arrow = nil;
			end			
		end )		
	elseif configuration.game_stage == 6 then
		-- Play increasing score
		assets_audio.playIncreasingScore()		
		assets_image.myCircleYellow_upperScore_tiles_obj[1][3].isVisible = true	
		assets_image.myCircleYellow_upperScore_tiles_obj[1][4].isVisible = true			
				
		-- seta indicando que é para acertar a lata			
		current_arrow = arrow_sprite_lib.newArrowSprite_0(display.contentCenterX + 350, display.contentCenterY)	

		timer.performWithDelay( 3000, function( )
			if current_arrow then			
				current_arrow:removeSelf( ); current_arrow = nil;
			end			
		end )		
	elseif configuration.game_stage == 7 then
		-- Play increasing score
		assets_audio.playIncreasingScore()		
		assets_image.myCircleYello_upperScore_tiles_obj[1][4].isVisible = true	
				
		-- seta indicando que é para acertar a lata			
		current_arrow = arrow_sprite_lib.newArrowSprite_0(display.contentCenterX + 350, display.contentCenterY)	

		timer.performWithDelay( 3000, function( )
			if current_arrow then			
				current_arrow:removeSelf( ); current_arrow = nil;
			end			
		end )		
	end	

	-- local count = 0
	-- for k=1,3 do
	-- 	for l=1,7 do
	-- 		if count ~= configuration.game_final_score_player then
	-- 			myCircleYellow[i][j].isVisible = true	
	-- 			count = count + 1
	-- 		end
	-- 	end
	-- end
end

-- processa o score dos players e atualiza o scoreboard
function score_process(assets_image)

	if configuration.game_stage == 2 then
		configuration.game_final_score_player[1] = 1	
	elseif configuration.game_stage == 3 then
		configuration.game_final_score_player[1] = 2
	elseif configuration.game_stage == 4 then
		configuration.game_final_score_player[2] = 2
	elseif configuration.game_stage == 5 then
		configuration.game_final_score_player[2] = 3	
	elseif configuration.game_stage == 6 then
		configuration.game_final_score_player[1] = 4	
	elseif configuration.game_stage == 7 then

	end	
	-- exibe os pontos na grade
	score_animation( assets_image )		
end
