------------------------------------------------------------------------------------------------------------------------------
-- house_tiles.lua
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

local configuration 			= require( "src.singleplayer.singleplayer_settings" )

----------------------------------------------------------
-- MAN SPRITE										--
----------------------------------------------------------
-- Example assumes 'imageSheet' is already created from graphics.newImageSheet()

function newManYellowRightSprite(x,y,way)

	mySheet = graphics.newImageSheet( configuration.man_yellow_right_sprite_image, configuration.man_yellow_right_imagesheet_options )

	animation = display.newSprite( mySheet, configuration.man_yellow_right_sprite_options )
	animation.x = x
	animation.y = y
	animation:toFront( )
	animation: setSequence(way)
  	animation:play()
  	animation:toFront( )

  	return animation
end

function newManGreenRightSprite(x,y,way)

	mySheet = graphics.newImageSheet( configuration.man_green_right_sprite_image, configuration.man_green_right_imagesheet_options )

	animation = display.newSprite( mySheet, configuration.man_green_right_sprite_options )
	animation.x = x
	animation.y = y
	animation:toFront( )
	animation: setSequence(way)
  	animation:play()
  	animation:toFront( )

  	return animation  	
end

function newManYellowLeftSprite(x,y,way)

	mySheet = graphics.newImageSheet( configuration.man_yellow_left_sprite_image, configuration.man_yellow_left_imagesheet_options )

	animation = display.newSprite( mySheet, configuration.man_yellow_left_sprite_options )
	animation.x = x
	animation.y = y
	animation:toFront( )
	animation: setSequence(way)
  	animation:play()
  	animation:toFront( )

  	return animation  	
end

function newManGreenLeftSprite(x,y,way)

	mySheet = graphics.newImageSheet( configuration.man_green_left_sprite_image, configuration.man_green_left_imagesheet_options )

	animation = display.newSprite( mySheet, configuration.man_green_left_sprite_options )
	animation.x = x
	animation.y = y
	animation:toFront( )
	animation:setSequence(way)
  	animation:play()
  	animation:toFront( )

  	return animation  	
end

function removeManSprite( animation )
	animation:removeSelf( ); animation = nil
end

