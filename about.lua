-------------------------------------------
-- LIBs
-------------------------------------------

require( "includeall" )

local scene = storyboard.newScene()

-----------------------------------------
-- Prototype Functions
-----------------------------------------

local criaTudo, removeTudo

removeTudo = function()
  abstractmenugui.removeMenuTitleImage()   
  abstractmenugui.removeMenuBodyTextFileBoxLabel() 
  abstractmenugui.removeMenuBackButton()
  abstractmenugui.removeMuteSoundButton()  
end

criaTudo = function() 

  local s = display.getCurrentStage()

  local x = s.contentWidth/2

  abstractmenugui.createMenuTitleImage(x,40)  
  abstractmenugui.createMenuBodyTextFileBoxLabel(x,230,"about.txt") 
  abstractmenugui.createMenuBackButton( -150,440,"menu")
  abstractmenugui.createMuteSoundButton(x + 200,440)
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