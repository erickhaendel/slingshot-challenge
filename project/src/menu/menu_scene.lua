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

--local util =  require( "src.infra.util" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local  btnSettings , btnPlay, btnCredits, btnAbout
-- Metodos
local onBtnAboutEvent, onBtnCreditsEvent, onBtnPlayEvent, onBtnPlayEvent

local function removeObject(object, group)
	if group then group:remove( object ); end
  	if object then object = nil; end 
end

-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view

    -- Create elements
    -- Background & box  welcome
    local background = display.newImage( "resources/images/backgrounds/menu.png", display.contentCenterX , display.contentCenterY , true )
    -- Buttons
    btnX = display.contentCenterX / 2  
    btnY = ( display.contentCenterY  ) 
    btnPlay     = display.newImage( "resources/images/buttons/play.png", display.contentCenterX , display.contentCenterY - 100, true  )

    btnAbout    = display.newImage( "resources/images/buttons/about.png", btnX - 100, btnY + 30, true  )
    btnCredits  = display.newImage( "resources/images/buttons/credits.png", btnX + 20, btnY + 140, true  )
    btnSettings = display.newImage( "resources/images/buttons/settings.png", btnX + 170, btnY + 280, true  )

    --Insert elements to scene
    sceneGroup:insert( background ) -- insert background to group
    sceneGroup:insert( btnPlay ) 
    sceneGroup:insert( btnAbout ) 
    sceneGroup:insert( btnCredits ) 
    sceneGroup:insert( btnSettings )

end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then

        -- Eventos
        btnPlay:addEventListener( "touch" , onBtnPlayEvent )
        btnSettings:addEventListener( "touch" , onBtnSettingsEvent )
        btnCredits:addEventListener( "touch" , onBtnCreditsEvent )
        btnAbout:addEventListener( "touch" , onBtnAboutEvent )

    end
end


-- "scene:hide()"
function scene:hide( event )
    removeAll()
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


-- "scene:destroy()"
function scene:destroy( event )
    local sceneGroup = self.view
    removeAll()
end


function removeAll( sceneGroup )
    removeObject( background , sceneGroup)  -- destroi imagem de fundo
    removeObject( btnPlay , sceneGroup)  -- destroi botao back
    removeObject( btnCredits , sceneGroup)  -- destroi botao
    removeObject( btnAbout , sceneGroup)  -- destroi botao
    removeObject( btnSettings , sceneGroup)  -- destroi botao
    removeObject( onOffSwitch , sceneGroup)  -- destroi botao
end

-- Events for Button Play
function onBtnPlayEvent( event )
    removeAll()
    composer.removeScene('src.menu.menu_scene')
    --composer.gotoScene( "src.gameplay.game", "fade", 400)
    composer.gotoScene( "src.menu.pregameplay_scene", "fade", 400)
end

-- Events for Button Credits
function onBtnCreditsEvent( event )
    removeAll()
    composer.removeScene('src.menu.menu_scene')
    composer.gotoScene( "src.menu.credits_scene", "fade", 400)
end

-- Events for Button About
function onBtnAboutEvent( event )
    removeAll()
    composer.removeScene('src.menu.menu_scene')
    composer.gotoScene( "src.menu.about_scene", "fade", 400)
end

-- Events for Button Settings
function onBtnSettingsEvent( event )
    removeAll()
    if( event.phase == "began") then
        composer.removeScene('src.menu.menu_scene')
        composer.gotoScene( "src.menu.settings_scene", "fade", 400)
    end
end

-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

local function checkMemory()
   collectgarbage( "collect" )
   local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
   print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
-- timer.performWithDelay( 1000, checkMemory, 0 )

return scene