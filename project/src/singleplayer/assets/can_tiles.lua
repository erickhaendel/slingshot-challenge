------------------------------------------------------------------------------------------------------------------------------
-- can_tiles.lua
-- Description: a set of can tiles
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

local configuration 		= require( "src.singleplayer.singleplayer_settings" )
local can_process_lib 		= require( "src.singleplayer.process.can" )

----------------------------------------------------------
-- CAN TILES									--
----------------------------------------------------------

-- cria conjuntos de latas para o player 1 e 2
function newCanTile()
				
	local cans = {}
	cans[1] = {}; cans[2] = {}
	cans[3] = {}; cans[4] = {}

	-- nome de arquivo das imagens das latas
	filename = {}
	filename[1] = configuration.can_image_dir..configuration.player1_can; 
	filename[2] = configuration.can_image_dir..configuration.player2_can; 
	filename[3] = filename[2]	-- repete no cenario 2
	filename[4] = filename[1]	-- reprete no cenario 2
	filename[5] = configuration.can_image_dir..configuration.neutral_can; 

	-- configuração das latas - com cores e neutras
	local can_organization = can_process_lib.prepare_can_organization(  )

	local M = 2 ; local N = 2 -- blocos de 4 latas, 2 a 2

	for i = 1, N do
		for j = 1, M do
			for k=1,4 do -- p1 cenario, p2 cenario 1, p2 cenario 2, p1 cenario 2

				-- se o array de configuracao de latas (can disposal) disser que é lata com cor
				if can_organization[k][configuration.game_current_round][M * (i-1) + j] == 1 then
					
					-- desenha a lata
					cans[k][M * (i-1) + j] = display.newImage( 
						filename[k], 
						configuration.cans_x[k] + (i*configuration.can_width), 
						configuration.cans_y[k] - (j*configuration.can_height) )
				
				-- senao é lata neutra
				elseif can_organization[k][configuration.game_current_round][M * (i-1) + j] == 0 then

					cans[k][M * (i-1) + j] = display.newImage( 
						filename[5], 
						configuration.cans_x[k] + (i*configuration.can_width), 
						configuration.cans_y[k] - (j*configuration.can_height) )					
				end
			end
		end
	end

	return cans
end

-- remove todas as latas
function removeCanTiles(cans)

	local M = 2 ; local N = 2

	for k=1,4 do
		for i = 1, N do
			for j = 1, M do
 				cans[k][M * (i-1) + j]:removeSelf( ); cans[k][M * (i-1) + j] = nil;
			end
		end
	end
end