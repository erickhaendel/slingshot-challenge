------------------------------------------------------------------------------------------------------------------------------
-- stages.lua
-- Dewcription: This class is responsible to randomly generate all can disposition rounds between neutral and colorful one
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

local configuration = require( "src.gameplay.configuration" )

function prepare_cans_disposition(  )

	can_disposition = {}

	can_disposition[1] = {} -- create the table player1
	can_disposition[2] = {} -- create the table player2

	-- initiate the pack for each round
	for i=1,configuration.game_total_rounds do

		can_disposition[1][i] = {} -- create the table for each round
		can_disposition[2][i] = {} -- create the table for each round	

		-- value 1 for a colorful can, 0 for a neutral can
		for j=1,configuration.pack_of_cans do
			can_disposition[1][i][j] = 1 -- initiate all with 1 for the player 1
	 		can_disposition[2][i][j] = 1 -- initiate all with 1 for the player 2
		end
	end

	-- 1ST CASE - IF configuration.pack_of_cans == 2
	-- TODO

	-- 2SD CASE - IF configuration.pack_of_cans == 3
	-- TODO

	-- 3TH CASE - IF configuration.pack_of_cans == 4

	-- for each round, a new set of cans to the player 1 and 2
	for i=1,configuration.game_total_rounds do

		-- quantidade de latas neutras no pacote do player 1 para o round atual.
		local num_neutral_cans_p1 = math.random( math.ceil(configuration.pack_of_cans/2), configuration.pack_of_cans - 1 )

		--local num_neutral_cans_p2 = 
		print( "Number of neutral cans for the round" .. i .. ": " .. num_neutral_cans_p1 )

		-- posicao das latas neutras no pacote
		local total = configuration.pack_of_cans
		local pos = {}
		for k=1,total do
			pos[k] = k
		end

		-- insert the neutral cans in the table
		for k=1,num_neutral_cans_p1 do

			local aux = math.random( 1, total ) -- guess a position

			can_disposition[1][i][pos[aux]] = 0 -- insert a neutral can  

			local pos2 = {} -- aux table

			for m=1, aux - 1 do
				pos2[m] = pos[m]
			end

			for m=(aux+1), total do
				pos2[m - 1] = pos[m]
			end

			pos = pos2
			
			total = total - 1
		end
	end

	-- debug
	local write = io.write
	--for i=1,configuration.game_total_rounds do
		--print( "round "..i )
		for j=1,configuration.pack_of_cans do
			write( can_disposition[1][1][j] .. " ")
		end
		print( "" )
	--end

end
