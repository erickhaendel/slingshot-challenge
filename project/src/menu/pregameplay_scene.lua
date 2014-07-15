------------------------------------------------------------------------------------------------------------------------------
-- pregameplay.lua
-- Dewcription: welcome screen
-- @author Samuel <samuellunamartins@gmail.com>
-- @modified 
-- @version 1.00
-- @date 07/15/2014
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
local network_pregameplay = require( "src.network.pregameplaysync" )

local scene = composer.newScene()

-- Prototype Objects
local menuButton
local status_label

-- prototype Methods
local menuButtonPress, playButtonPress, loadMenuButton
local loadStatusLabel

-- GROUPS
pregameplayGroup = display.newGroup( )

local response_invite_to_play, response_user_status = 0, 0


function loadStatusLabel()
  status_label = display.newText( 
    "", 
    configuration.pregameplay_status_label_x, 
    configuration.pregameplay_status_label_y, 
    configuration.pregameplay_status_font_name, 
    configuration.pregameplay_status_font_size )

  status_label:setFillColor( 1, 1, 1, 255 )
  --pregameplayGroup:insert(status_label)
end

function loadMenuButton()

  menuButton = widget.newButton
  {
    defaultFile = configuration.menu_button_image,
    overFile = configuration.menu_button_image,
    emboss = true,
    onPress = menuButtonPress,
  }

  menuButton.x = configuration.pregameplay_menu_button_x
  menuButton.y = configuration.pregameplay_menu_button_y
  pregameplayGroup:insert(menuButton)
end

function menuButtonPress( event )
    
    removeAll()

    composer.removeScene('src.menu.pregameplay_scene')  
    composer.gotoScene( "src.menu.menu_scene", "slideLeft", 400 )
end

function connecting_process()

  -- notifica o servidor que o player esta disponivel   
  timer.performWithDelay( 2000, function( ) 
      status_label.text = "Connecting to a server..."    
    if response_user_status ~= "available" then    
      response_user_status = network_pregameplay.sendUserStatus("avaiable")
    end
  end )

    -- procura por um player disponivel para jogar
  timer.performWithDelay( 4000, function()
    status_label.text = "Find a available player..."
    player2_id = network_pregameplay.findAvailablePlayer()
  end )

  timer.performWithDelay( 6000, function()
    if player2_id ~= nil then
    status_label.text = "Player found. Inviting him to play..."         
      response_invite_to_play = network_pregameplay.inviteToPlayey(player2_id)

      if response_invite_to_play == "confirmed" then
        status_label.text = "Player accepted. Loading..."            
        response_user_status = network_pregameplay.sendUserStatus("busy")

        -- lets play
        removeAll()

        composer.removeScene('src.menu.pregameplay_scene')  
        composer.gotoScene( "src.gameplay.game", "slideLeft", 400 )
      end
    else

    end      
  end)
end

function createAll()
  
  if not statusLabel then loadStatusLabel(); end

  if not menuButton then loadMenuButton();  end 

    -- LEMBRAR DO JANTAR DOS FILOSOFOS
  timer.performWithDelay( 1, connecting_process( response_invite_to_play, response_user_status), 0)    


end

function removeAll()

    if(status_label) then pregameplayGroup:remove( status_label ); status_label:removeSelf(); status_label = nil; end

    if(menuButton) then pregameplayGroup:remove( menuButton ); menuButton:removeSelf(); menuButton = nil; end

    if(playButton) then pregameplayGroup:remove( playButton ); playButton:removeSelf(); playButton = nil; end    
end

function scene:create( event )
    local sceneGroup = self.view

    createAll()
    audio.stop(1)
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    createAll()
    
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