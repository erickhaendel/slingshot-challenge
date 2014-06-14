-------------------------------------------
-- LIBs
-------------------------------------------
require( "includeall" )

math.randomseed( os.time() )

-------------------------------------------
-- NEXT SCENE
-------------------------------------------
if default_login_mode == "on" then
	composer.gotoScene( "welcome" )
else
	composer.gotoScene( "menu" )	
end
