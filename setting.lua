-------------------------------------------
-- LIBs
-------------------------------------------

require( "includeall" )

local scene = storyboard.newScene()

local titleLabel

local labels = display.newGroup()

-----------------------------------------
-- Prototype Functions
-----------------------------------------

local criaTudo, removeTudo

removeTudo = function()
  abstractmenugui.removeMenuTitleImage()
  abstractmenugui.removeMenuHowToPlayButton()
  abstractmenugui.removeMenuPrivacyPolicyButton()
  abstractmenugui.removeMenuLogoffButton()
  abstractmenugui.removeMenuLoginButton()
  abstractmenugui.removeMenuIncreaseVolumeButton()
  abstractmenugui.removeMenuVolumeLabel()
  abstractmenugui.removeMenuDecreaseVolumeButton()
  abstractmenugui.removeMenuBackButton()
  abstractmenugui.removeMuteSoundButton()
end

criaTudo = function()

  local s = display.getCurrentStage()

  local x = s.contentWidth/2

  abstractmenugui.createMenuTitleImage(x,40) 
  abstractmenugui.createMenuHowToPlayButton(x,240)
  abstractmenugui.createMenuPrivacyPolicyButton(x,310)

  if facebook_login_mode == "on" then
    abstractmenugui.createMenuLogoffButton(x,440)
  else
    abstractmenugui.createMenuLoginButton(x,440)
  end   

  abstractmenugui.createMenuDecreaseVolumeButton(x - 100,375)
  abstractmenugui.createMenuVolumeLabel(x,375)
  abstractmenugui.createMenuIncreaseVolumeButton(x + 100,375)
  abstractmenugui.createMenuBackButton( -150,440,"menu")
  abstractmenugui.createMuteSoundButton(x+200,440)
end

function scene:createScene( event ) 
  local group = self.view
  -- Load the background image
  local bg = display.newImage( templateBackgroundFile, 160, 160, true )
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