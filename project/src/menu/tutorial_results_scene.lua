------------------------------------------------------------------------------------------------------------------------------
-- results.lua
-- Dewcription: results screen file
-- @author Samuel Martins <samuellunamartins@gmail.com>
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

-- libs
require( "src.infra.includeall" )
local assets_audio            = require( "src.gameplay.assets_audio" )
local configuration           = require( "src.menu.menu_settings" )
local tutorial_configuration  = require( "src.tutorial.tutorial_settings" )
local checked_sprite_lib      = require( "src.tutorial.assets.checked_sprite" )
----------------------------------------------------------------------------------------------

local scene = composer.newScene()

-- Prototype Objects
local background1, background2

-- prototype Methods
local loadBackgroundAnimation

-- GROUPS
resultsGroup = display.newGroup( )

--------------------------------------------------------------------------------------------------------------
-- Methods



function loadBackgroundAnimation()

  local background1 = display.newImage( "resources/images/backgrounds/menu.png", display.contentCenterX , display.contentCenterY , true )

  local background2 = display.newImage( "resources/images/backgrounds/popup.png", display.contentCenterX , display.contentCenterY , true )


  local checked_sprite = checked_sprite_lib.newCheckedSprite(
    tutorial_configuration.checked_sprite_position_x,
    tutorial_configuration.checked_sprite_position_y)

  timer.performWithDelay( 3500, function( e )
      checked_sprite_lib.removeCheckedSprite(checked_sprite)
      background1:removeSelf( )
      background2:removeSelf( )

      composer.removeScene('src.menu.tutorial_results_scene') 
      composer.gotoScene( "src.menu.menu_scene", "slideLeft", 400 )      
    end)
end

function scene:create( event )
	local sceneGroup = self.view
  loadBackgroundAnimation()

	audio.stop(1)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

  loadBackgroundAnimation()
	
	if phase == "will" then

    elseif ( phase == "did" ) then

    end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	removeAll()	
	
	if event.phase == "will" then
	elseif phase == "did" then
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view

	removeAll()	
end

-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene