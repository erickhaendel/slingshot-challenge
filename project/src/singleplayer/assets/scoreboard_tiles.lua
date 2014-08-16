------------------------------------------------------------------------------------------------------------------------------
-- scoreboard_tiles.lua
-- Description: 
-- @author Samuel Martins <samuellunamartins@gmail.com>
-- @modified 
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

module(..., package.seeall)

local configuration = require( "src.singleplayer.singleplayer_settings" )

----------------------------------------------------------
-- SCOREBOARD TILES											--
----------------------------------------------------------


-- cria todos os objetos de score dos scoreboards
function new_scoreboard()

	-- arrays dos scores das grades
	local score_cans = {}
	
	score_cans[1] = {}
	score_cans[2] = {}
	score_cans[3] = {}
	score_cans[4] = {}

	-- nome de arquivos das imagens de scores - latas
	filename = {}
	filename[1] = configuration.can_image_dir..configuration.player1_score_can;
	filename[2] = configuration.can_image_dir..configuration.player2_score_can; 
	filename[3] = configuration.can_image_dir..configuration.player2_score_can; 
	filename[4] = configuration.can_image_dir..configuration.player1_score_can;

	-- define a inclinacao da matriz de latas
	local offset_inclination_right = 50 -- se mudar a imagem de grass vai ter que ajustar esses valores
	local offset_inclination_left = -27	-- se mudar a imagem de grass vai ter que ajustar esses valores

	-- define a distancia entre as latas
	local offset_between_cans_x = 60
	local offset_between_cans_y = 40
	local offset_proportional_vertical_distance1 = {} -- player 1
	local offset_proportional_vertical_distance2 = {} -- player2

	for i=1,4 do	
		offset_proportional_vertical_distance1[i] = 1
		offset_proportional_vertical_distance2[i] = 1		
	end

	local offset_can_scale = 1

	-- matriz de 20 - 4 linhas da grade por 5 colunas
	local M = 4 ; local N = 5

	for k = 1, 4 do	
		for j = 1, M do
			for i = 1, N do

				-- fix the correct offset of the can on the scoreboard
				local offset_inclination
				local offset_p_v_d
				if k % 2 == 0 then -- player 2
					offset_inclination = offset_inclination_left; 
					offset_p_v_d = offset_proportional_vertical_distance2[k]
				else -- player 1
					offset_inclination = offset_inclination_right; 
					offset_p_v_d = offset_proportional_vertical_distance1[k]
				end

				-- load the can image
				score_cans[k][M * (i-1) + j] = display.newImage( 
					filename[k], 
					configuration.score_cans_x[k] + (i*offset_between_cans_x*offset_p_v_d) + j*offset_inclination, 
					configuration.score_cans_y[k] - (j*offset_between_cans_y*offset_p_v_d) )

				score_cans[k][M * (i-1) + j].isVisible = false
			end

			offset_proportional_vertical_distance1[k] = offset_proportional_vertical_distance1[k] - 0.082
			offset_proportional_vertical_distance2[k] = offset_proportional_vertical_distance2[k] - 0.088
		end
	
	end

	return score_cans
end

function removeScoreboard(score_cans)

	local M = 4 ; local N = 5

	for k = 1, 4 do	
		for j = 1, M do
			for i = 1, N do
				score_cans[k][M * (i-1) + j]:removeSelf( ); score_cans[k][M * (i-1) + j] = nil
			end
		end
	end
end
