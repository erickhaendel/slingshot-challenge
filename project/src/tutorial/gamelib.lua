------------------------------------------------------------------------------------------------------------------------------
-- gamelib.lua
-- Dewcription: library for the tutorial file
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

module(..., package.seeall)

local configuration 			= require( "src.tutorial.tutorial_settings" )

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