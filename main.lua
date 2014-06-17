-------------------------------------------
-- LIBs
-------------------------------------------
require( "includeall" )

math.randomseed( os.time() )

display.setStatusBar( display.HiddenStatusBar )


-----------------------------------------
-- DEBUG MODE
-----------------------------------------
-- Determine if running on Corona Simulator
--
isSimulator = "simulator" == system.getInfo("environment")
if system.getInfo( "platformName" ) == "Mac OS X" then isSimulator = false; end

-- Native Text Fields not supported on Simulator
--
if isSimulator then
    player_name = "Debug Player"  
end 

-------------------------------------------
-- NEXT SCENE
-------------------------------------------
if default_login_mode == "on" then
	composer.gotoScene( "welcome" )
else
	composer.gotoScene( "welcome" )	
end
