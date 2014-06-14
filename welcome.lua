-------------------------------------------
-- LIBs
-------------------------------------------

require( "includeall" )

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

  abstractmenugui.removeMenuBackgroundImage() 
  abstractmenugui.removeMenuLogoffButton()
  abstractmenugui.removeMenuLoginButton()
  abstractmenugui.removeMenuSignupButton()
  abstractmenugui.removeMuteSoundButton()  
end

criaTudo = function()

	abstractmenugui.createMenuBackgroundImage(
		display.contentCenterX, 
		display.contentCenterY,
		templateWelcomeBackgroundFile)

	abstractmenugui.createMenuSignupButton(
		display.contentCenterX*0.70, 
		display.contentCenterY*1.55,
		templateSignupButtonDefaultFile,
		templateSignupButtonOverFile,
		"")

	abstractmenugui.createMuteSoundButton(
		display.contentCenterX*1.75, 
		display.contentCenterY*1.65,
		"")
	
	if player_validated  == 1 then

		removeTudo()
		storyboard.gotoScene( "menu" )

	else

	  abstractmenugui.createMenuLoginButton(
		display.contentCenterX*1.30, 
		display.contentCenterY*1.55,
		templateLoginButtonDefaultFile,
		templateLoginButtonOverFile,
		"")
	end


end

-------------------------------------------
-- Create a Background touch event
-------------------------------------------
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
  	criaTudo()  
end

function scene:show( event )
	local phase = event.phase
  	criaTudo() 
end

function scene:hide( event )
	local phase = event.phase
  removeTudo()  
end

function scene:destroy( event )
  local group = self.view  
  removeTudo()
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene