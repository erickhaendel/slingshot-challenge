------------------------------------------------------------------------------------------------------------------------------
-- hand_tiles.lua
-- Description: 
-- @author Samuel Martins <samuellunamartins@gmail.com>
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

local configuration = require( "src.tutorial.tutorial_settings" )


newHandTile, removeHandTiles = nil, nil

----------------------------------------------------------
-- HAND TILES											--
----------------------------------------------------------

function newHandTile()
	local hand = display.newImage( configuration.hand_image_filename, configuration.hand_position_x, configuration.hand_position_y )

	timer.performWithDelay( 100, function()

		timer.performWithDelay( 1000, function( )	
			-- Transition the hand into position each time it's spawned	
			transition.to(hand, {time=1000, x = configuration.stone_position_x+50, y = configuration.stone_position_y + 50, transition = easingx.easeOut});
		end )

		timer.performWithDelay( 2000, function( )
			-- Transition the hand into position each time it's spawned	
			transition.to(hand, {time=2000, x = configuration.stone_position_x+50, y = configuration.stone_position_y + 250, transition = easingx.easeOut});
		end )

		timer.performWithDelay( 4000, function( )
			-- Transition the hand into position each time it's spawned	
			transition.to(hand, {time=2000, x = configuration.stone_position_x+50, y = configuration.stone_position_y + 50, transition = easingx.easeOutBounce});
		end )	
	end,1 )
	
	return hand
end

function removeHandTiles(hand)
	if hand then
		hand:removeSelf( ); hand = nil
	end
end