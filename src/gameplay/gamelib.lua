------------------------------------------------------------------------------------------------------------------------------
-- gamelib.lua
-- Dewcription: library for the gameplay file
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

local configuration = require( "src.gameplay.configuration" )

-- verifica se houve colisao entre dois objetos
function hitTestObjects(obj1, obj2)
    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
    return (left or right) and (up or down)
end

-- verifica o limite do eslatico do estilingue e devolve os valores corretos
function getBoundaryProjectile( e, t )
	-- Boundary for the projectile when grabbed			
	local bounds = e.target.stageBounds;
	bounds.xMin = 250
	bounds.yMin = display.contentHeight - 5;
	bounds.xMax = display.contentWidth -250;
	bounds.yMax = display.contentHeight - 250;
	
	-- limita a corda do estilingue para não puxar infinitamente
	if(e.y > bounds.yMax) then t.y = e.y; end	 -- limita na parte 		
	if(e.x < bounds.xMax) then t.x = e.x; end	 -- limita a direita
	if(e.y > bounds.yMin) then t.y = bounds.yMin; end -- limita na parte
	if(e.x < bounds.xMin) then t.x = bounds.xMin; end -- limita a esquerda

	return t.x, t.y
end

function changeCurrentPlayer()
		-- change the current player
	if configuration.game_current_player == 1 then 
		configuration.game_current_player = 2; 
	else 
		configuration.game_current_player = 1; 
	end
end

-- debug console
function debug_gameplay()
	print( "Current player: "..configuration.game_current_player )
	print( "Current turn: "..configuration.game_current_turn )	
	print( "Current round: "..configuration.game_current_round )
	print( "Player 1 Score: "..configuration.game_final_score_player[1])
	print( "Player 2 Score: "..configuration.game_final_score_player[2])		
	print( "Total de rounds a ser disputados: "..configuration.game_total_rounds )
end

-- trajectory of project tile
function remove_projectile_trajectory()
	-- remove a trajetoria anterior
	for i=1,#trajetory do
		if trajetory[i] then
			trajetory[i]:removeSelf( )
		end
	end

	circle_id = 1
	configuration.projecttile_scale = 1.1
end