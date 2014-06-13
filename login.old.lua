-------------------------------------------
-- LIBs
-------------------------------------------

require( "includeall" )

-----------------------------------------
-- Facebook Connection listener
-----------------------------------------

local function facebookListener( event )

    if event.phase ~= "login" then
      -- Exit if login error
        if ( appId ) then
            facebook.login( appId, facebookListener )
        end      
        return
    else       
        storyboard.gotoScene( "menu" )      
    end

    if ( "request" == event.type ) then
      playerName =  event.response
    end    
end

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
    storyboard.gotoScene( "menu" )  
end	

-----------------------------------------
-- RELEASE MODE
-----------------------------------------

local scene = storyboard.newScene()

if ( appId ) then
	facebook.login( appId, facebookListener )
end

return scene