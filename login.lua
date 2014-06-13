-- login
-------------------------------------------
-- LIBs
-------------------------------------------

require( "includeall" )

local scene = storyboard.newScene()

-----------------------------------------
-- Prototype Functions
-----------------------------------------

local criaTudo, removeTudo

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

  abstractmenugui.removeMuteSoundButton()  
end

criaTudo = function()

	abstractmenugui.createMuteSoundButton(
		display.contentCenterX*1.75, 
		display.contentCenterY*1.65,
		"")
	
end

-------------------------------------------
-- Create a Background touch event
-------------------------------------------

function scene:createScene( event )
  local group = self.view
  -- Load the background image
  local bg = display.newImage( templateLoginBackgroundFile, display.contentCenterX, display.contentCenterY, true )
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