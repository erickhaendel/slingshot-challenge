------------------------------------------------------------------------------------------------------------------------------
-- sky_tiles.lua
-- Description: 
-- @author Guilherme Cabral <grecabral@gmail.com>
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

local configuration 			= require( "src.tutorial.tutorial_settings" )

----------------------------------------------------------
-- UPPER SCORES TILES											--
----------------------------------------------------------

upperScoreBoardGroup = nil

-----------------------------------------------------
-- UPPER SCORES CREATION										--
----------------------------------------------------------

function newUpperBoardTile()

	upperScoreBoardGroup = display.newGroup();

	local upperScoreBoard = {}
	
	upperScoreBoard[1] = display.newRoundedRect(display.contentCenterX - 410, 85, 230, 120,8)
	upperScoreBoard[1].strokeWidth = 25
	upperScoreBoard[1]:setFillColor(0.8, 0.8, 0.8)
	upperScoreBoard[1]:setStrokeColor(1, 1, 0)
	upperScoreBoard[1]:toFront()
	upperScoreBoardGroup:insert( upperScoreBoard[1] )

	upperScoreBoard[2] = display.newRoundedRect(display.contentCenterX + 410, 85, 230, 120,8)
	upperScoreBoard[2].strokeWidth = 25
	upperScoreBoard[2]:setFillColor(0.8, 0.8, 0.8)
	upperScoreBoard[2]:setStrokeColor(0, 1, 0)
	upperScoreBoard[2]:toFront()
	upperScoreBoardGroup:insert( upperScoreBoard[2] )

	myCircleYellow = {}
	myCircleGreen = {}	
	for i=1,3 do
		myCircleYellow[i] = {}	
		myCircleGreen[i] = {}	
		for j=1,7 do
			-- x, y, raio
			myCircleYellow[i][j] = display.newCircle( display.contentCenterX - 530 + j*30, 25 + i*30, 10 )
			myCircleYellow[i][j]:setFillColor(1, 1, 0)
			myCircleYellow[i][j].strokeWidth = 5			
			myCircleYellow[i][j]:setStrokeColor(0.1, 0.1, 0.1)			
			upperScoreBoardGroup:insert( myCircleYellow[i][j] )
			myCircleYellow[i][j].isVisible = false	

			-- x, y, raio
			myCircleGreen[i][j] = display.newCircle( display.contentCenterX +290 + j*30, 25 + i*30, 10 )
			myCircleGreen[i][j]:setFillColor(0, 1, 0)
			myCircleGreen[i][j].strokeWidth = 5			
			myCircleGreen[i][j]:setStrokeColor(0.1, 0.1, 0.1)			
			upperScoreBoardGroup:insert( myCircleGreen[i][j] )
			myCircleGreen[i][j].isVisible = false						
		end
	end

	return upperScoreBoard, myCircleYellow, myCircleGreen
end

function removeUpperBoardTile(upperScoreBoard, myCircleYellow, myCircleGreen)

	for i=1,2 do
		upperScoreBoard[i]:removeSelf( ); upperScoreBoard[i] = nil		
	end

	for k=1,3 do
		for l=1,7 do
			myCircleYellow[i][j]:removeSelf( ); myCircleYellow[i][j] = nil	
			myCircleGreen[i][j]:removeSelf( ); myCircleGreen[i][j] = nil				
		end
	end

end

