------------------------------------------------------------------------------------------------------------------------------
-- slingshot_tiles.lua
-- Description: 
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
-- SLINGSHOT TILES										--
----------------------------------------------------------

function newSlingshotTile()
	local slingshot = {}
	slingshot[1] = display.newImage(configuration.slingshot_image_filename,true);
	slingshot[1].x = configuration.slingshot_position_x[1]; 
	slingshot[1].y = configuration.slingshot_position_y[1]

	slingshot[2] = display.newImage(configuration.slingshot_image_filename,true);
	slingshot[2].x = configuration.slingshot_position_x[2]; 
	slingshot[2].y = configuration.slingshot_position_y[2]	

	return slingshot
end

function removeSlingshotTile( slingshot )
	if slingshot then slingshot:removeSelf( ); slingshot = nil; end
end