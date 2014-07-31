------------------------------------------------------------------------------------------------------------------------------
-- arrows_sprite.lua
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
-- arrow SPRITE										--
----------------------------------------------------------
-- Example assumes 'imageSheet' is already created from graphics.newImageSheet()

function newArrowSprite_0(x,y)

	mySheet = graphics.newImageSheet( configuration.arrow_0_sprite_image, configuration.arrow_0_imagesheet_options )

	animation = display.newSprite( mySheet, configuration.arrow_0_sprite_options )
	animation.x = x
	animation.y = y
	animation:toFront( )

  	animation:play()
  	animation:toFront( )

  	return animation
end

function newArrowSprite_45(x,y)

	mySheet = graphics.newImageSheet( configuration.arrow_45_sprite_image, configuration.arrow_45_imagesheet_options )

	animation = display.newSprite( mySheet, configuration.arrow_45_sprite_options )
	animation.x = x
	animation.y = y
	animation:toFront( )

  	animation:play()
  	animation:toFront( )

  	return animation  	
end

function newArrowSprite_90(x,y)

	mySheet = graphics.newImageSheet( configuration.arrow_90_sprite_image, configuration.arrow_90_imagesheet_options )

	animation = display.newSprite( mySheet, configuration.arrow_90_sprite_options )
	animation.x = x
	animation.y = y
	animation:toFront( )

  	animation:play()
  	animation:toFront( )

  	return animation  	
end

function newArrowSprite_135(x,y)

	mySheet = graphics.newImageSheet( configuration.arrow_135_sprite_image, configuration.arrow_135_imagesheet_options )

	animation = display.newSprite( mySheet, configuration.arrow_135_sprite_options )
	animation.x = x
	animation.y = y
	animation:toFront( )

  	animation:play()
  	animation:toFront( )

  	return animation  	
end

function newArrowSprite_180(x,y)

	mySheet = graphics.newImageSheet( configuration.arrow_180_sprite_image, configuration.arrow_180_imagesheet_options )

	animation = display.newSprite( mySheet, configuration.arrow_180_sprite_options )
	animation.x = x
	animation.y = y
	animation:toFront( )

  	animation:play()
  	animation:toFront( )

  	return animation  	
end

function newArrowSprite_225(x,y)

	mySheet = graphics.newImageSheet( configuration.arrow_225_sprite_image, configuration.arrow_225_imagesheet_options )

	animation = display.newSprite( mySheet, configuration.arrow_225_sprite_options )
	animation.x = x
	animation.y = y
	animation:toFront( )

  	animation:play()
  	animation:toFront( )

  	return animation  	
end

function newArrowSprite_270(x,y)

	mySheet = graphics.newImageSheet( configuration.arrow_270_sprite_image, configuration.arrow_270_imagesheet_options )

	animation = display.newSprite( mySheet, configuration.arrow_270_sprite_options )
	animation.x = x
	animation.y = y
	animation:toFront( )

  	animation:play()
  	animation:toFront( )

  	return animation  	
end

function newArrowSprite_315(x,y)

	mySheet = graphics.newImageSheet( configuration.arrow_315_sprite_image, configuration.arrow_315_imagesheet_options )

	animation = display.newSprite( mySheet, configuration.arrow_315_sprite_options )
	animation.x = x
	animation.y = y
	animation:toFront( )

  	animation:play()
  	animation:toFront( )

  	return animation  	
end