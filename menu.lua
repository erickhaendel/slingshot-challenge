-------------------------------------------
-- LIBs
-------------------------------------------

require( "includeall" )

local scene = storyboard.newScene()

local greetingsLabel

local labels = display.newGroup()

local menuJogarButton, menuOpcoesButton

local menuButtons = display.newGroup()

-----------------------------------------
-- Prototype Functions
-----------------------------------------

local criaTudo, removeTudo, facebookListener, resetGameStatus

-----------------------------------------
-- DEBUG MODE
-----------------------------------------
-- Determine if running on Corona Simulator
--
local isSimulator = "simulator" == system.getInfo("environment")
if system.getInfo( "platformName" ) == "Mac OS X" then isSimulator = false; end

-- Native Text Fields not supported on Simulator
--
if isSimulator then
    player_name = "Debug Player"  
end 

-----------------------------------------
-- RELEASE MODE
-----------------------------------------

removeTudo = function()

--  abstractmenugui.removeMenuTitleImage()
--  abstractmenugui.removeMenuSettingButton()
--  abstractmenugui.removeMenuAboutButton()   

  abstractmenugui.removeMenuPlayButton()
  abstractmenugui.removeMenuLogoffButton()
  abstractmenugui.removeMenuLoginButton()

end

criaTudo = function()

  resetGameStatus()

  local s = display.getCurrentStage()

  local x = s.contentWidth/2

 -- abstractmenugui.createMenuTitleImage(x,40)  
 -- abstractmenugui.createMenuSettingButton(x,340)  
 -- abstractmenugui.createMenuAboutButton(x,440)

  abstractmenugui.createMenuPlayButton(
    display.contentCenterX*0.40, 
    display.contentCenterY*1.80,
    templatePlayButtonDefaultFile,
    templatePlayButtonOverFile,
    "")

    abstractmenugui.createMenuAboutButton(
    display.contentCenterX*0.80, 
    display.contentCenterY*1.80,
    templateAboutButtonDefaultFile,
    templateAboutButtonOverFile,
    "")




end

resetGameStatus = function()
  player1_slingshot_color = 0 -- 0 yellow, 1 green
  player2_slingshot_color = 0
  player1_score = 0
  player1_shoot = 0
  player2_score = 0
  player2_shoot = 0
  turn = 1
  round = 0
  game_state = "not_started"
  game_mode = "tutorial"
end

-------------------------------------------
-- Create a Background touch event
-------------------------------------------

function scene:createScene( event )
  local group = self.view
  -- Load the background image
  local bg = display.newImage( templateBackgroundFile, display.contentCenterX, display.contentCenterY, true )
  group:insert( bg )  
  criaTudo()  
end

function scene:enterScene( event )
  criaTudo() 
end

function scene:exitScene( event ) 
  local group = self.view
  removeTudo()  
end

function scene:destroyScene( event )
  local group = self.view  
  removeTudo()
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene