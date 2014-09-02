------------------------------------------------------------------------------------------------------------------------------
-- totalScore.lua
-- Description: 
-- @author Erick Haendel <erickhaendel@gmail.com>
-- @modified 
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

local configuration 			= require( "src.singleplayer.singleplayer_settings" )

----------------------------------------------------------
-- UPPER SCORES TILES											--
----------------------------------------------------------

totalScoresGroup = nil

local labelScorePlayer1 = nil
local labelScorePlayer2 = nil


-----------------------------------------------------
-- UPPER SCORES CREATION										--
----------------------------------------------------------

function newTotalScore()

	totalScoresGroup = display.newGroup();

	labelScorePlayer1 = display.newText( "Total 0 ", 100 , 200 , native.systemFont , 46 )
	labelScorePlayer1:setFillColor( 0 , 0 , 0 )
	totalScoresGroup:insert( labelScorePlayer1 )

	labelScorePlayer2 = display.newText( "Total 0 ", display.contentWidth - 100 , 200 , native.systemFont , 46 )
	labelScorePlayer2:setFillColor( 0 , 0 , 0 )
	totalScoresGroup:insert( labelScorePlayer2 )

	return totalScoresGroup
end

function updateTotalScore()
	labelScorePlayer1.text = "Total "..configuration.game_final_score_player[1]
	labelScorePlayer2.text = "Total "..configuration.game_final_score_player[2] 
end

function remove()
	labelScorePlayer1:removeSelf( ); labelScorePlayer1 = nil
	labelScorePlayer2:removeSelf( ); labelScorePlayer2 = nil
end

