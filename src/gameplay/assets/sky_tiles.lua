------------------------------------------------------------------------------------------------------------------------------
-- sky_tiles.lua
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

local configuration = require( "src.gameplay.configuration" )

----------------------------------------------------------
-- TARGET TILES											--
----------------------------------------------------------

-----------------------------------------------------
-- SKY ANIMATION										--
----------------------------------------------------------
-- Camera follows bolder automatically
local skyGroup

local function moveSky()
	if (skyGroup.x > -960) then
		skyGroup.x = skyGroup.x -0.2
	else
		skyGroup.x = 0
	end
end

-- load the sky animation
function startSky()

	local skys = {}

	skyGroup = display.newGroup();

	for i=1,4 do
		skys[i] = display.newImage( configuration.sky_image_filename, true )
		skyGroup:insert( skys[i] )
		skys[i].x = configuration.sky_x[i]
		skys[i].y = configuration.sky_y[i]
	end

	Runtime:addEventListener( "enterFrame", moveSky )	

	return skys
end

function removeSky( sky )

	for i=1,4 do
		skyGroup:remove( sky[i] )		
		sky[i]:removeSelf( ); sky[i] = nil
	end

	Runtime:removeEventListener( "enterFrame", moveSky )		
end
