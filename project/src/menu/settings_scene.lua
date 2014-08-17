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
local singleplayer_settings = require( "src.singleplayer.singleplayer_settings" )
local gameplay_settings = require( "src.gameplay.configuration" )

local scene = composer.newScene()
-- -------------------------------------------------------------------------------

local function removeObject(object, group)
	if group then group:remove( object ); end
  	if object then object = nil; end 
end

local sceneGroup , background, btnBack, roundsLabel, roundsNumberLabel, moreRoundsButton, lessRoundsButton

-- Metodos
local removeAll, onBtnBackPress, onSwitchPress, loadLessRoundsButton, loadMoreRoundsButton, loadRoundsNumberLabel
local moreRoundsButtonPress, lessRoundsButtonPress

loadRoundsLabel = function()
  roundsLabel = display.newText( 
    "Number of Rounds", 
    configuration.rounds_label_x, 
    configuration.rounds_label_y, 
    configuration.rounds_label_font_name, 
    configuration.rounds_label_font_size )

  roundsLabel:setTextColor( 1, 1, 1, 255 )
  sceneGroup:insert(roundsLabel)
end

loadRoundsNumberLabel = function()
  roundsNumberLabel = display.newText( 
    singleplayer_settings.game_total_rounds, 
    configuration.rounds_number_label_x, 
    configuration.rounds_number_label_y, 
    configuration.rounds_number_label_font_name, 
    configuration.rounds_number_label_font_size )

  roundsNumberLabel:setTextColor( 1, 1, 1, 255 )
  sceneGroup:insert(roundsNumberLabel)
end

loadMoreRoundsButton = function()

  moreRoundsButton = widget.newButton{ 
  defaultFile = configuration.more_button_image,
  overFile = configuration.more_button_image,
  emboss = true,
  onPress = moreRoundsButtonPress,}

  moreRoundsButton.x = configuration.more_rounds_button_x
  moreRoundsButton.y = configuration.more_rounds_button_y
  sceneGroup:insert(moreRoundsButton)
end

loadLessRoundsButton = function()

  lessRoundsButton = widget.newButton{ 
  defaultFile = configuration.less_button_image,
  overFile = configuration.less_button_image,
  emboss = true,
  onPress = lessRoundsButtonPress,}

  lessRoundsButton.x = configuration.less_rounds_button_x
  lessRoundsButton.y = configuration.less_rounds_button_y
  sceneGroup:insert(lessRoundsButton)
end

lessRoundsButtonPress = function( event )
    if  singleplayer_settings.game_total_rounds > 0 then
        singleplayer_settings.game_total_rounds = singleplayer_settings.game_total_rounds - 1
        gameplay_settings.game_total_rounds = singleplayer_settings.game_total_rounds
        roundsNumberLabel.text = singleplayer_settings.game_total_rounds
    end
end

moreRoundsButtonPress = function( event )
    if  singleplayer_settings.game_total_rounds < 20 then
        singleplayer_settings.game_total_rounds = singleplayer_settings.game_total_rounds + 1
        gameplay_settings.game_total_rounds = singleplayer_settings.game_total_rounds
        roundsNumberLabel.text = singleplayer_settings.game_total_rounds
    end
end

-- "scene:create()"
function scene:create( event )
    sceneGroup = self.view

    -- Create elements
    -- Background & box  welcome
    background = display.newImage( configuration.settings_background_image, display.contentCenterX , display.contentCenterY , true )
    
    -- Buttons
    btnBack     = display.newImage( 
        configuration.back_button_image,  
        configuration.back_settings_button_x, 
        configuration.back_settings_button_y, 
        true  )

        --Insert elements to scene
    sceneGroup:insert( background ) -- insert background to group
    sceneGroup:insert( btnBack )

    -- -- Create the widget
    -- local onOffSwitch = widget.newSwitch
    -- {
    --     left = 250,
    --     top = 200,
    --     style = "onOff",
    --     id = "onOffSwitch",
    --     onPress = onSwitchPress
    -- }

    loadRoundsLabel()
    loadRoundsNumberLabel()
    loadMoreRoundsButton()
    loadLessRoundsButton()
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
    elseif ( phase == "did" ) then
    end
end

function removeAll( sceneGroup )
    removeObject( background , sceneGroup)  -- destroi imagem de fundo
    removeObject( btnBack , sceneGroup)  -- destroi botao back
    -- removeObject( onOffSwitch , sceneGroup)  -- destroi botao
    -- removeObject( onOffSwitch , sceneGroup)  -- destroi botao
end

-- "scene:destroy()"
function scene:destroy( event )
    local sceneGroup = self.view
    removeAll( sceneGroup )
end
 
-- Events for Button back
function onBtnBackPress( event )
    composer.removeScene('src.menu.settings_scene')
    composer.gotoScene( "src.menu.menu_scene", "fade", 400)
end


-- Handle press events for the checkbox
local function onSwitchPress( event )
    local switch = event.target
end

-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene