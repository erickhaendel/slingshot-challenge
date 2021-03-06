------------------------------------------------------------------------------------------------------------------------------
-- welcome.lua
-- Dewcription: welcome screen
-- @author Erick <erickhaendel@gmail.com>
-- @version 1.00
-- @created_date 06/29/2014
-- @modified_date 07/10/2014
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

-- corona libs
local composer = require( "composer" )

-- my libs
local configuration = require( "src.menu.menu_settings" )


local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local btnLogin -- type newImage
local btnSignup  -- type newImage

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    -- audio
    local menu_song = audio.loadStream( configuration.background_sound_theme )
    gameMusicChannel = audio.play( menu_song, configuration.background_config_sound_theme )
    audio.setVolume( configuration.background_sound_theme_volume_level )    

    -- Create elements
   	-- Background & box  welcome
    local boxWelcome = display.newImageRect( 
        configuration.welcome_background_image,  
        display.contentWidth  ,  
        display.contentHeight  )

     boxWelcome.x , boxWelcome.y =  display.contentCenterX , display.contentCenterY 
    
    -- Buttons
    btnX = display.contentCenterX / 2 
    btnY = ( display.contentCenterY  + display.contentCenterY / 2 ) 
    
    btnLogin = display.newImage( configuration.login_button_image, btnX , btnY , true  )
    btnSignup = display.newImage( configuration.signup_button_image, btnX + display.contentCenterX , btnY , true  )



    --Insert elements to scene
    sceneGroup:insert( boxWelcome ) -- inserindo o box welcome
    sceneGroup:insert( btnLogin ) -- inserindo o button visitor
    sceneGroup:insert( btnSignup ) -- inserindo o button signup

end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then

    	-- Eventos
        btnLogin:addEventListener( "touch" , btnLoginEvent )
        btnSignup:addEventListener( "touch" ,  btnSignupEvent )

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


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- Events for Button Visitor
function btnLoginEvent( event )
	composer.gotoScene( "src.menu.login_scene", "slideLeft", 400 )
end

-- Events for Button Signup
function btnSignupEvent( event )
	composer.gotoScene( "src.menu.signup_scene", "fade", 400 )
end





-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene