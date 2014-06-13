-------------------------------------------
-- LIBs
-------------------------------------------

require( "includeall" )

-------------------------------------------
-- Objects
-------------------------------------------

local scene = storyboard.newScene()

-----------------------------------------
-- Prototype Functions
-----------------------------------------

local criaTudo, removeTudo

-----------------------------------------
-- Functions
-----------------------------------------

removeTudo = function()
  
  abstractmenugui.removeMenuTitleImage()
  abstractmenugui.removeMenuBlueSlingshotButton()
  abstractmenugui.removeMenuGreenSlingshotButton()
  abstractmenugui.removeMenuBodyTextFileBoxLabel() 
  abstractmenugui.removeMenuBackButton()
  abstractmenugui.removeMuteSoundButton()         
end

criaTudo = function()

  local s = display.getCurrentStage()

  local x = s.contentWidth/2

  abstractmenugui.createMenuTitleImage(x,40)  
  abstractmenugui.createMenuGreenSlingshotButton(x+140,260)
  abstractmenugui.createMenuBlueSlingshotButton(x-140,260)
  abstractmenugui.createMenuBackButton( -150,440,"menu")
  abstractmenugui.createMuteSoundButton(x + 300,440)

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
  removeTudo()
end

function scene:destroyScene( event )
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