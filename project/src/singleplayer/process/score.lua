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
local assets_audio			= require( "src.singleplayer.assets_audio" )
local configuration 		= require( "src.singleplayer.singleplayer_settings" )
local can_process_lib 		= require( "src.singleplayer.process.can" )
local auxiliar;

function score_animation( intend_to_hit, assets_image )

	local temp = 0
	-- for i=1,2 do
	-- 	for j=1,4 do
	for j=1,4 do
		for i=1,2 do
			-- timer.performWithDelay(1+i*110, function(e)
			
			if configuration.game_all_intent[configuration.game_current_round][configuration.game_current_player] == 1 then
				assets_image.myCircleYellow_upperScore_tiles_obj[j][i].isVisible = true						
			elseif configuration.game_all_intent[configuration.game_current_round][configuration.game_current_player] == 2 then
				assets_image.myCircleGreen_upperScore_tiles_obj[j][i].isVisible = true	
			end
				assets_audio.playIncreasingScore()
			-- end)

			temp = temp + 1	

			if temp >= configuration.game_all_round[configuration.game_current_round][configuration.game_all_intent[configuration.game_current_round][configuration.game_current_player]] then
				
				return;
			end			
		end
	end
end

-- processa o score dos players e atualiza o scoreboard
function score_process(assets_image)

	local player = configuration.game_current_player -- alias

--	print( "Player "..player )
	
	local intend_to_hit = configuration.game_hit_choose[configuration.game_current_player][configuration.game_current_round] -- alias

	local can_organization = can_process_lib.prepare_can_organization(  )

	local points_p1 = 0
	local points_p2 = 0

	-- contagem de pontos
	for i=1,configuration.pack_of_cans do

		-- player 1 , current round => colorful can == 1 ? true
		if can_organization[1][configuration.game_current_round][i] == 1 then
			points_p1 = points_p1 + 1
		end

		-- player 2, current round => colorful can == 1 ? true
		if can_organization[2][configuration.game_current_round][i] == 1 then
			points_p2 = points_p2 + 1
		end		
	end

	auxiliar = configuration.game_all_round[configuration.game_current_round]

	-- cenario 01, jogador 1 acerta suas proprias latas
	if player == 1 and intend_to_hit == 1  then
		configuration.game_score_player[can_process_lib.p1scene1] =  points_p1
		configuration.game_final_score_player[can_process_lib.p1scene1] = configuration.game_final_score_player[can_process_lib.p1scene1] + configuration.game_score_player[can_process_lib.p1scene1]
		--organizando os dados para serem salvos no BD
		if can_process_lib.invertido == 0 then
			configuration.game_all_intent[configuration.game_current_round][player] =  1
			configuration.game_all_round[configuration.game_current_round] = {(auxiliar[1] + configuration.game_score_player[1]), (auxiliar[2])}
		elseif	can_process_lib.invertido == 1 then
			configuration.game_all_intent[configuration.game_current_round][player] =  2
			configuration.game_all_round[configuration.game_current_round] = {(auxiliar[1]), (auxiliar[2] + configuration.game_score_player[2])}
		end
	-- cenario 01, jogador 1 acerta as latas do jogador 2
	elseif player == 1 and intend_to_hit == 2 then
		configuration.game_score_player[can_process_lib.p2scene1] = points_p2
		configuration.game_final_score_player[can_process_lib.p2scene1] = configuration.game_final_score_player[can_process_lib.p2scene1] + configuration.game_score_player[can_process_lib.p2scene1]
		--organizando os dados para serem salvos no BD
		if can_process_lib.invertido == 0 then
			configuration.game_all_intent[configuration.game_current_round][player] =  2
			configuration.game_all_round[configuration.game_current_round] = {(auxiliar[1]), (auxiliar[2] + configuration.game_score_player[2])}
		elseif	can_process_lib.invertido == 1 then
			configuration.game_all_intent[configuration.game_current_round][player] =  1
			configuration.game_all_round[configuration.game_current_round] = {(auxiliar[1] + configuration.game_score_player[1]), (auxiliar[2])}
		end

	-- cenario 02, jogador 2 acerta as latas do jogador 1
	elseif player == 2 and intend_to_hit == 1 then
		configuration.game_score_player[can_process_lib.p2scene1] = points_p1
		configuration.game_final_score_player[can_process_lib.p2scene1] = configuration.game_final_score_player[can_process_lib.p2scene1] + configuration.game_score_player[can_process_lib.p2scene1]
		if can_process_lib.invertido == 0 then
			configuration.game_all_intent[configuration.game_current_round][player] =  2
			configuration.game_all_round[configuration.game_current_round] = {(auxiliar[1]), (auxiliar[2] + configuration.game_score_player[2])}
		elseif	can_process_lib.invertido == 1 then
			configuration.game_all_intent[configuration.game_current_round][player] =  1
			configuration.game_all_round[configuration.game_current_round] = {(auxiliar[1] + configuration.game_score_player[1]), (auxiliar[2])}
		end

	-- cenario 02, jogador 2 acerta suas proprias latas
	elseif player == 2 and intend_to_hit == 2 then
		configuration.game_score_player[can_process_lib.p1scene1] = points_p2
		configuration.game_final_score_player[can_process_lib.p1scene1] = configuration.game_final_score_player[can_process_lib.p1scene1] + configuration.game_score_player[can_process_lib.p1scene1]
		if can_process_lib.invertido == 0 then
			configuration.game_all_intent[configuration.game_current_round][player] =  1
			configuration.game_all_round[configuration.game_current_round] = {(auxiliar[1] + configuration.game_score_player[1]), (auxiliar[2] + configuration.game_score_player[2])}
		elseif	can_process_lib.invertido == 1 then
			configuration.game_all_intent[configuration.game_current_round][player] =  2
			configuration.game_all_round[configuration.game_current_round] = {(auxiliar[1]), (auxiliar[2] + configuration.game_score_player[2])}
		end
	end
	print("INFORMAÇÕES RODADA")
	print( ">>>"..(configuration.game_score_player[1])..">"..configuration.game_score_player[2])
	print( ">round> jogador "..(configuration.game_all_round[configuration.game_current_round][1]).."> NPC"..configuration.game_all_round[configuration.game_current_round][2])
	print( ">itenção> jogador "..(configuration.game_all_intent[configuration.game_current_round][1])..">NPC"..configuration.game_all_intent[configuration.game_current_round][2])
	print("round atual"..configuration.game_current_round)
	print( "npc escolhido  "..configuration.npc_strategy )
	print( "total de rodadas "..configuration.game_total_rounds )

	configuration.game_round_score_player[intend_to_hit] = configuration.game_round_score_player[intend_to_hit] + configuration.game_score_player[intend_to_hit]
	-- exibe os pontos na grade
	score_animation( intend_to_hit, assets_image )	
end
