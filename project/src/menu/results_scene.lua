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
local score                   = require( "src.singleplayer.singleplayer_settings" )
local gameplay_configuration  = require( "src.gameplay.configuration" )

----------------------------------------------------------------------------------------------

local scene = composer.newScene()

-- Prototype Objects
local mySheet, animation, menuButton
local player1TitleLabel, player2TitleLabel, player1ScoreLabel, player2ScoreLabel

-- prototype Methods
local unloadBackgoundAnimation, loadBackgroundAnimation, btnBackEvent, loadMenuButton
local loadPlayer1TitleLabel, loadPlayer2TitleLabel, loadPlayer1ScoreLabel, loadPlayer2ScoreLabel

-- GROUPS
resultsGroup = display.newGroup( )

--------------------------------------------------------------------------------------------------------------
-- Methods

function loadPlayer1TitleLabel()
  player1TitleLabel = display.newText( 
  	"Player 1", 
  	configuration.results_player1_title_label_x, 
  	configuration.results_player1_title_label_y, 
  	configuration.results_font_name, 
  	configuration.results_player1_title_font_size )

  player1TitleLabel:setTextColor( 1, 1, 1, 255 )
  resultsGroup:insert(player1TitleLabel)
end

function loadPlayer1ScoreLabel()
  player1ScoreLabel = display.newText( 
  	"Score: "..score.game_final_score_player[1], 
  	configuration.results_player1_score_label_x, 
  	configuration.results_player1_score_label_y, 
  	configuration.results_font_name, 
  	configuration.results_player1_score_font_size )

  player1ScoreLabel:setTextColor( 1, 1, 1, 255 )
  resultsGroup:insert(player1ScoreLabel)
end

function loadPlayer2TitleLabel()
  player2TitleLabel = display.newText( 
  	"Player 2", 
  	configuration.results_player2_title_label_x, 
  	configuration.results_player2_title_label_y, 
  	configuration.results_font_name, 
  	configuration.results_player2_title_font_size )

  player2TitleLabel:setTextColor( 1, 1, 1, 255 )
  resultsGroup:insert(player2TitleLabel)
end

function loadPlayer2ScoreLabel()
  player2ScoreLabel = display.newText( 
  	"Score: "..score.game_final_score_player[2], 
  	configuration.results_player2_score_label_x, 
  	configuration.results_player2_score_label_y, 
  	configuration.results_font_name, 
  	configuration.results_player2_score_font_size )

  player2ScoreLabel:setTextColor( 1, 1, 1, 255 )
  resultsGroup:insert(player2ScoreLabel)
end

function loadBackgroundAnimation()

	mySheet = graphics.newImageSheet( configuration.results_sprite_image, configuration.results_imagesheet_options )

	animation = display.newSprite( mySheet, configuration.results_sprite_options )
	animation.x = configuration.results_sprite_x
	animation.y = configuration.results_sprite_y
	resultsGroup:insert(animation)

  timer.performWithDelay( 1000, function()
    animation:play()
  end )

end

function loadMenuButton()

  menuButton = widget.newButton
  {
    defaultFile = configuration.menu_button_image,
    overFile = configuration.menu_button_image,
    emboss = true,
    onPress = menuButtonPress,
  }

  menuButton.x = configuration.results_menu_button_x
  menuButton.y = configuration.results_menu_button_y
  resultsGroup:insert(menuButton)
end

function menuButtonPress( event )
	
	removeAll()

	composer.removeScene('src.menu.results_scene')	
	composer.gotoScene( "src.menu.menu_scene", "slideLeft", 400 )
end

function showScoreAnimation()

local score_player1, score_player2 = 0,0

  for i=1,(gameplay_configuration.game_final_score_player[1]) do
    timer.performWithDelay( 1+i*110, function( )
      score_player1 = score_player1 + 1
      player1ScoreLabel.text = "Score: "..score_player1  
      
      -- Play increasing score
      assets_audio.playIncreasingScore()  
    end)
  end

  for i=1,gameplay_configuration.game_final_score_player[2] do
    timer.performWithDelay( gameplay_configuration.game_final_score_player[1] + 1+score_player2*110, function( )
      score_player2 = score_player2 + 1
      player2ScoreLabel.text = "Score: "..score_player2    
      
      -- Play increasing score
      assets_audio.playIncreasingScore()  
    end)      
  end

end

function createAll()
  
  if not animation then  loadBackgroundAnimation();  end  

  if not player1TitleLabel then loadPlayer1TitleLabel(); end

  if not player1ScoreLabel then loadPlayer1ScoreLabel(); end

  if not player2TitleLabel then loadPlayer2TitleLabel(); end

  if not player2ScoreLabel then loadPlayer2ScoreLabel(); end

  if not menuButton then loadMenuButton();  end 

  showScoreAnimation()

end

function removeAll()

	if(animation) then resultsGroup:remove( animation ); animation:removeSelf(); animation = nil;mySheet = nil;  end

	if(player1TitleLabel) then resultsGroup:remove( player1TitleLabel ); player1TitleLabel:removeSelf(); player1TitleLabel = nil; end

    if(player1ScoreLabel) then resultsGroup:remove( player1ScoreLabel ); player1ScoreLabel:removeSelf(); player1ScoreLabel = nil; end

	if(player2TitleLabel) then resultsGroup:remove( player2TitleLabel ); player2TitleLabel:removeSelf(); player2TitleLabel = nil; end

	if(player2ScoreLabel) then resultsGroup:remove( player2ScoreLabel ); player2ScoreLabel:removeSelf(); player2ScoreLabel = nil; end

	if(menuButton) then resultsGroup:remove( menuButton ); menuButton:removeSelf(); menuButton = nil; end
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