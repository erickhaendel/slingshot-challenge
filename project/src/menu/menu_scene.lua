------------------------------------------------------------------------------------------------------------------------------
-- menu.lua
-- Dewcription: menu screen
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
local singleplayer_settings = require( "src.singleplayer.singleplayer_settings" )

local scene = composer.newScene()

menuGroup = display.newGroup( )

-- objetos com valor nil
local  background, btnSettings, btnPlay, btnTutorial, btnCredits, btnAbout, btnSinglePlayer1, btnSinglePlayer2, btnSinglePlayer3, btnSinglePlayer4

-- Declaracao dos Metodos com valor nil
local playPress, tutorialPress, creditsPress, aboutPress, settingsPress, singleplayer1Press, singleplayer2Press, singleplayer3Press, singleplayer4Press
local loadBtnSettings, loadBtnPlay, loadBtnTutorial, loadBtnCredits, loadBtnAbout,loadBtnSinglePlayer1, loadBtnSinglePlayer2, loadBtnSinglePlayer3, loadBtnSinglePlayer4
local removeAll, createAll

--------------------------------------------------------------------------------------------------------------
-- Load object Methods
function loadBackground()
    background = display.newImage( configuration.menu_background_image, 
        display.contentCenterX, 
        display.contentCenterY, 
        true )
    menuGroup:insert( background )    
end

function loadBtnSettings()
    btnSettings = display.newImage( configuration.settings_button_image, 
        configuration.settings_button_x, 
        configuration.settings_button_y, 
        true  )
    menuGroup:insert( btnSettings )
    btnSettings:addEventListener( "touch" , settingsPress )
end

function loadBtnPlay()
    btnPlay     = display.newImage( configuration.multiplayer_button_image, 
        configuration.play_button_x, 
        configuration.play_button_y, 
        true  )
    menuGroup:insert( btnPlay ) 
    btnPlay:addEventListener( "touch" , playPress )
end

function loadBtnTutorial()
    btnTutorial = display.newImage( configuration.tutorial_button_image,  
        configuration.tutorial_button_x, 
        configuration.tutorial_button_y, 
        true  )
    menuGroup:insert( btnTutorial )     
    btnTutorial:addEventListener( "touch" , tutorialPress )
end

function loadBtnCredits()
    btnCredits  = display.newImage( configuration.credits_button_image, 
        configuration.credits_button_x, 
        configuration.credits_button_y, 
        true  )
    menuGroup:insert( btnCredits )  
    btnCredits:addEventListener( "touch" , creditsPress )   
end

function loadBtnAbout()
    btnAbout    = display.newImage( configuration.about_button_image, 
        configuration.about_button_x, 
        configuration.about_button_y, 
        true  )
    menuGroup:insert( btnAbout )
    btnAbout:addEventListener( "touch" , aboutPress )     
end

function loadBtnSinglePlayer1()
    btnSinglePlayer1 = display.newImage( configuration.full_random_button_image, 
        configuration.singleplayer1_button_x, 
        configuration.singleplayer1_button_y, 
    true)


    menuGroup:insert( btnSinglePlayer1 ) 
    btnSinglePlayer1:addEventListener( "touch" , singleplayer1Press )
end

function loadBtnSinglePlayer2()
   btnSinglePlayer2 = display.newImage( configuration.tit_for_tat_button_image, 
        configuration.singleplayer2_button_x, 
        configuration.singleplayer2_button_y, 
    true)
    menuGroup:insert( btnSinglePlayer2 ) 
    btnSinglePlayer2:addEventListener( "touch" , singleplayer2Press )   
end

function loadBtnSinglePlayer3()
   btnSinglePlayer3 = display.newImage( configuration.generous_tit_for_tat_button_image, 
        configuration.singleplayer3_button_x, 
        configuration.singleplayer3_button_y, 
    true)
    menuGroup:insert( btnSinglePlayer3 ) 
    btnSinglePlayer3:addEventListener( "touch" , singleplayer3Press )   
end

function loadBtnSinglePlayer4()
   btnSinglePlayer4 = display.newImage( configuration.random_tit_for_tat_button_image, 
        configuration.singleplayer4_button_x, 
        configuration.singleplayer4_button_y, 
    true)
    menuGroup:insert( btnSinglePlayer4 ) 
    btnSinglePlayer4:addEventListener( "touch" , singleplayer4Press )   
end
--------------------------------------------------------------------------------------------------------------
-- EVENT METHODS
function playPress( event )
    removeAll()
    composer.removeScene('src.menu.menu_scene')
    composer.gotoScene( "src.menu.pregameplay_scene", "fade", 400)
end

function tutorialPress( event )
    removeAll()
    composer.removeScene('src.menu.menu_scene')
    composer.gotoScene( "src.tutorial.tutorial_gameplay", "fade", 400)
end

function creditsPress( event )
    removeAll()
    composer.removeScene('src.menu.menu_scene')
    composer.gotoScene( "src.menu.credits_scene", "fade", 400)
end

function aboutPress( event )
    removeAll()
    composer.removeScene('src.menu.menu_scene')
    composer.gotoScene( "src.menu.about_scene", "fade", 400)
end

function settingsPress( event )
    removeAll()
    composer.removeScene('src.menu.menu_scene')
    composer.gotoScene( "src.menu.settings_scene", "fade", 400)
end

function singleplayer1Press( event )
    singleplayer_settings.npc_strategy = "random"
    removeAll()
    composer.removeScene('src.menu.menu_scene')
    composer.gotoScene( "src.singleplayer.singleplayer" , "fade", 400)
end

function singleplayer2Press( event )
    singleplayer_settings.npc_strategy = "tit-for-tat"    
    removeAll()
    composer.removeScene('src.menu.menu_scene')
    composer.gotoScene( "src.singleplayer.singleplayer" , "fade", 400)
end

function singleplayer3Press( event )
    singleplayer_settings.npc_strategy = "tit-for-tat-generous"    
    removeAll()
    composer.removeScene('src.menu.menu_scene')
    composer.gotoScene( "src.singleplayer.singleplayer" , "fade", 400)
end

function singleplayer4Press( event )
    singleplayer_settings.npc_strategy = "tit-for-tat-aleatory"    
    removeAll()
    composer.removeScene('src.menu.menu_scene')
    composer.gotoScene( "src.singleplayer.singleplayer" , "fade", 400)
end

function createAll()

  if not background then loadBackground(); end

  if not btnSettings then loadBtnSettings(); end

  if not btnPlay then loadBtnPlay(); end

  if not btnTutorial then loadBtnTutorial(); end

  -- if not btnCredits then loadBtnCredits(); end

  -- if not btnAbout then loadBtnAbout();  end 

  if not btnSinglePlayer1 then loadBtnSinglePlayer1(); end

  if not btnSinglePlayer2 then loadBtnSinglePlayer2(); end

  if not btnSinglePlayer3 then loadBtnSinglePlayer3(); end

  if not btnSinglePlayer4 then loadBtnSinglePlayer4(); end

end

function removeAll()


    if(background) then 
        menuGroup:remove( background ); 
        background:removeSelf(); 
        background = nil; 
    end    

    if(btnSettings) then 
        btnSettings:removeEventListener( "touch" , settingsPress ); 
        menuGroup:remove( btnSettings ); 
        btnSettings:removeSelf(); 
        btnSettings = nil;  
    end

    if(btnPlay) then 
        btnPlay:removeEventListener( "touch" , playPress ); 
        menuGroup:remove( btnPlay ); 
        btnPlay:removeSelf(); 
        btnPlay = nil; 
    end

    if(btnTutorial) then 
        btnTutorial:removeEventListener( "touch" , tutorialPress ); 
        menuGroup:remove( btnTutorial ); 
        btnTutorial:removeSelf(); 
        btnTutorial = nil; 
    end

    if(btnCredits) then 
        btnCredits:removeEventListener( "touch" , creditsPress ); 
        menuGroup:remove( btnCredits ); 
        btnCredits:removeSelf(); 
        btnCredits = nil; 
    end

    if(btnAbout) then 
        btnAbout:removeEventListener( "touch" , aboutPress );
        menuGroup:remove( btnAbout ); 
        btnAbout:removeSelf(); 
        btnAbout = nil; 
    end

    if(btnSinglePlayer1) then 
        btnSinglePlayer1:removeEventListener( "touch" , singleplayer1Press ); 
        menuGroup:remove( btnSinglePlayer1 ); 
        btnSinglePlayer1:removeSelf(); 
        btnSinglePlayer1 = nil; 
    end

    if(btnSinglePlayer2) then 
        btnSinglePlayer2:removeEventListener( "touch" , singleplayer2Press ); 
        menuGroup:remove( btnSinglePlayer2 ); 
        btnSinglePlayer2:removeSelf(); 
        btnSinglePlayer2 = nil; 
    end  

    if(btnSinglePlayer3) then 
        btnSinglePlayer3:removeEventListener( "touch" , singleplayer3Press ); 
        menuGroup:remove( btnSinglePlayer3 ); 
        btnSinglePlayer3:removeSelf(); 
        btnSinglePlayer3 = nil; 
    end

    if(btnSinglePlayer4) then 
        btnSinglePlayer4:removeEventListener( "touch" , singleplayer4Press ); 
        menuGroup:remove( btnSinglePlayer4 ); 
        btnSinglePlayer4:removeSelf(); 
        btnSinglePlayer4 = nil; 
    end   
end

-- "scene:create()"
function scene:create( event )
    createAll()
end

-- "scene:show()"
function scene:show( event )
    createAll()
end

-- "scene:hide()"
function scene:hide( event )
    removeAll()
end

-- "scene:destroy()"
function scene:destroy( event )
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