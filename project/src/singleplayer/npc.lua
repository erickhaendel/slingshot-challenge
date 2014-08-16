------------------------------------------------------------------------------------------------------------------------------
-- game.lua
-- Dewcription: singleplayer file
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

module(..., package.seeall)

-------------------------------------------
-- LIBs
-------------------------------------------
require( "src.infra.includeall" )

local configuration 			= require( "src.singleplayer.singleplayer_settings" )
local projectile_process_lib 	= require( "src.singleplayer.process.projectile" )

-- funcao que faz o npc realizar uma jogada de acordo com a estratégia passada
function npc( type )

	-- localizacao das latas à esquerda
	local left_side_x = 800
	local left_side_y = configuration.stone_position_y + 300

	-- localizacao das latas à direita
	local right_side_x = 1600
	local right_side_y = configuration.stone_position_y + 300

	if type == "tit-for-tat" then

		-- inicie acertando as latas do outro player - comportamento altruista no inicio
		if configuration.game_current_turn == 1 and configuration.game_current_round == 1 then
			configuration.projectile_object.x = left_side_x
			configuration.projectile_object.y = left_side_y
		else
			-- obtem a jogada do outro player e replica

		end

	elseif type == "random" then

		local side = math.random(1,2)

		if side == 1 then
			configuration.projectile_object.x = left_side_x
			configuration.projectile_object.y = left_side_y
		else
			configuration.projectile_object.x = right_side_x
			configuration.projectile_object.y = right_side_y
		end

	elseif type == "selfish" then
		configuration.projectile_object.x = left_side_x
		configuration.projectile_object.y = left_side_y
	elseif type == "Altruist" then
		configuration.projectile_object.x = right_side_x
		configuration.projectile_object.y = right_side_y
	end

	local pseudo_stone = configuration.projectile_object

	configuration.projectile_object = projectile_process_lib.launched_process(
		configuration.projectile_object, 
		pseudo_stone, 
		configuration.state_object)	
end


