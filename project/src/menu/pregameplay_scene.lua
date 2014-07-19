------------------------------------------------------------------------------------------------------------------------------
-- pregameplay_scene.lua
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

local configuration         = require( "src.menu.menu_settings" )
local gameplay_settings     = require( "src.gameplay.configuration" )
local network_pregameplay   = require( "src.network.pregameplaysync" )
local player1_obj           = require( "src.player.player1" )
local player2_obj           = require( "src.player.player2" )

local scene = composer.newScene()

-- Prototype Objects
local menuButton, inviteButton, background, status_label, shadow_label

-- prototype Methods
local menuButtonPress, inviteButtonPress, loadMenuButton, loadInviteButton, loadBackground
local loadStatusLabel

-- GROUPS
pregameplayGroup = display.newGroup( )

local response_invite_to_play, response_user_status = 0, 0

---------------------------
-- GUI METHODS       --
---------------------------
function loadBackground()
  background = display.newImage( configuration.menu_background_image, display.contentCenterX , display.contentCenterY , true )
  pregameplayGroup:insert( background ) 
end

function loadStatusLabel()

  local options = 
  {
    --parent = textGroup,
    text =  "",
    x = configuration.pregameplay_status_label_x-2, 
    y = configuration.pregameplay_status_label_y+2,
    width = 775,    --required for multi-line and alignment
    font = configuration.pregameplay_status_font_name, 
    fontSize = configuration.pregameplay_status_font_size,
    align = "center"  --new alignment parameter
  }

  shadow_label = display.newText(options)  

  options = 
  {
    --parent = textGroup,
    text =  "",
    x = configuration.pregameplay_status_label_x, 
    y = configuration.pregameplay_status_label_y,
    width = 775,    --required for multi-line and alignment
    font = configuration.pregameplay_status_font_name, 
    fontSize = configuration.pregameplay_status_font_size,
    align = "center"  --new alignment parameter
  }

  status_label = display.newText(options)

  status_label:setFillColor( 1, 1, 1, 255 )
  shadow_label:setFillColor( 0, 0, 0, 255 )

  pregameplayGroup:insert(shadow_label)
  pregameplayGroup:insert(status_label)
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
  --menuButton.isVisible = false
end

function menuButtonPress( event )
    
    removeAll()

    composer.removeScene('src.menu.pregameplay_scene')  
    composer.gotoScene( "src.menu.menu_scene", "slideLeft", 400 )
end

function loadInviteButton()

  inviteButton = widget.newButton
  {
    defaultFile = configuration.invite_button_image,
    overFile = configuration.invite_button_image,
    emboss = true,
    onPress = inviteButtonPress,
  }

  inviteButton.x = configuration.pregameplay_menu_button_x + 500
  inviteButton.y = configuration.pregameplay_menu_button_y
  pregameplayGroup:insert(inviteButton)
end

function inviteButtonPress( event )
    inviting_process()
end

---------------------------
-- NETWORK METHODS       --
---------------------------
local invite = 0

function beguest_process()

  network_pregameplay.beGuestToPlay() 

  function monitor(event)

    if gameplay_settings.game_i_am_player_number ~= nil and invite == 0 then
      print( "aceitou" )
      timer.cancel( event.source )
      composer.removeScene('src.menu.pregameplay_scene')  
      composer.gotoScene( "src.gameplay.game", "slideLeft", 400 )   
    end 
    
  end

  local t1 = timer.performWithDelay( 100, monitor, 0 )

end

function inviting_process()

  gameplay_settings.game_i_am_player_number = 1

  print( "configuration.game_i_am_player_number  "..gameplay_settings.game_i_am_player_number )
  invite = 1



  timer.performWithDelay( 2000, function( )

    network_pregameplay.letsPlay() 

    removeAll()

    composer.removeScene('src.menu.pregameplay_scene')  
    composer.gotoScene( "src.gameplay.game", "slideLeft", 400 )  
  end )
  
end

function createAll()

  if not background then  loadBackground();  end   
  
  if not status_label then loadStatusLabel(); end

  if not menuButton then loadMenuButton();  end 

  if not inviteButton then loadInviteButton();  end 

  shadow_label.text =  "Waiting for someone to\ninvite you to play ...\n\nor you can invite\nsomeone..."
  status_label.text =  "Waiting for someone to\ninvite you to play ...\n\nor you can invite\nsomeone..."

  timer.performWithDelay( 100, beguest_process )

end

function removeAll()

    if(background) then pregameplayGroup:remove( background ); background:removeSelf(); background = nil; end

    if(shadow_label) then pregameplayGroup:remove( shadow_label ); shadow_label:removeSelf(); shadow_label = nil; end

    if(status_label) then pregameplayGroup:remove( status_label ); status_label:removeSelf(); status_label = nil; end

    if(menuButton) then pregameplayGroup:remove( menuButton ); menuButton:removeSelf(); menuButton = nil; end

    if(inviteButton) then pregameplayGroup:remove( inviteButton ); inviteButton:removeSelf(); inviteButton = nil; end       
  
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