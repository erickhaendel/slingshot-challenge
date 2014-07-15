------------------------------------------------------------------------------------------------------------------------------
-- welcome.lua
-- Dewcription: welcome screen
-- @author Erick <erickhaendel@gmail.com>
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

-- my libs
require( "src.infra.includeall" )
local configuration = require( "src.menu.menu_settings" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local function removeObject(object, group)
	if group then group:remove( object ); end
  	if object then object = nil; end 
end

local sceneGroup , background
local btnBack

-- Metodos
local removeAll, onBtnBackPress

-- "scene:create()"
function scene:create( event )
    
    local sceneGroup = self.view

    -- Create elements
    -- Background & box  welcome
    background = display.newImage( "resources/images/backgrounds/credits.png", display.contentCenterX , display.contentCenterY , true )
    -- Buttons
    btnBack     = display.newImage( "resources/images/buttons/back.png",  200, ( display.contentHeight - 100) , true  )

    --Insert elements to scene
    sceneGroup:insert( background ) -- insert background to group
    sceneGroup:insert( btnBack )


end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Eventos
        btnBack:addEventListener( "touch" , onBtnBackPress )
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


function removeAll( sceneGroup )
    removeObject( background , sceneGroup)  -- destroi imagem de fundo
    removeObject( btnBack , sceneGroup)  -- destroi botao back
end

-- "scene:destroy()"
function scene:destroy( event )
    local sceneGroup = self.view
    removeAll()
end


-- Events for Button back
function onBtnBackPress( event )
    composer.removeScene('src.menu.credits_scene')
    composer.gotoScene( "src.menu.menu_scene", "fade", 400)
end

-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene