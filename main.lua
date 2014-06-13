-------------------------------------------
-- LIBs
-------------------------------------------
require( "includeall" )

math.randomseed( os.time() )

-------------------------------------------
-- NEXT SCENE
-------------------------------------------
if default_login_mode == "on" then
	storyboard.gotoScene( "welcome" )
else
	storyboard.gotoScene( "menu" )
end
