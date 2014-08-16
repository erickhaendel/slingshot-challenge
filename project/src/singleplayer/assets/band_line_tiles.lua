------------------------------------------------------------------------------------------------------------------------------
-- band_line_tiles.lua
-- Description: band line from slingshot
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
-- BAND LINE TILES											--
----------------------------------------------------------

-- insere o elastico no cenario
function newBandLine( t )

	-- Init the elastic band.
	local myLine = nil;
	local myLineBack = nil;	

	-- If the projectile is in the top left position
	if(t.x < display.contentCenterX and t.y < _H - 165)then
		myLineBack = display.newLine(t.x - 30, t.y, configuration.myLineBack_x2, configuration.myLineBack_y2);
		myLine = display.newLine(t.x - 30, t.y, configuration.myLine_x2, configuration.myLine_y2);
	-- If the projectile is in the top right position
	elseif(t.x > display.contentCenterX and t.y < _H - 165)then
		myLineBack = display.newLine(t.x + 10, t.y - 25,  configuration.myLineBack_x2, configuration.myLineBack_y2);
		myLine = display.newLine(t.x + 10, t.y - 25,  configuration.myLine_x2, configuration.myLine_y2);
	-- If the projectile is in the bottom left position
	elseif(t.x < display.contentCenterX and t.y > _H - 165)then
		myLineBack = display.newLine(t.x - 25, t.y + 20,  configuration.myLineBack_x2, configuration.myLineBack_y2);
		myLine = display.newLine(t.x - 25, t.y + 20,  configuration.myLine_x2, configuration.myLine_y2);
	-- If the projectile is in the bottom right position
	elseif(t.x > display.contentCenterX and t.y > _H - 165)then
		myLineBack = display.newLine(t.x - 15, t.y + 30,  configuration.myLineBack_x2, configuration.myLineBack_y2);
		myLine = display.newLine(t.x - 15, t.y + 30,  configuration.myLine_x2, configuration.myLine_y2);
	else
	-- Default position (just in case).
		myLineBack = display.newLine(t.x - 25, t.y, configuration.myLineBack_x2, configuration.myLineBack_y2);
		myLine = display.newLine(t.x - 25, t.y,   configuration.myLine_x2, configuration.myLine_y2);
	end

	-- Set the elastic band's visual attributes
	myLineBack:setStrokeColor(255,255,255);
	myLineBack.strokeWidth = 9;

	myLine:setStrokeColor(255,255,255);
	myLine.strokeWidth = 11;

	return myLineBack, myLine
end

-- remove o elastico do cenario
function removeBandLine( )
	if(myLine and myLine.parent) then	
		myLine.parent:remove(myLine); -- erase previous line
		myLineBack.parent:remove(myLineBack); -- erase previous line
		myLine = nil;
		myLineBack = nil;
	end
end
