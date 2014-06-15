-------------------------------------------
-- LIBs
-------------------------------------------

require( "includeall" )

-----------------------------------------
-- Prototype Functions
-----------------------------------------

local criaTudo, removeTudo, removeObject

local loginButton = nil
local signupButton = nil
local backgroundImage = nil

local welcomeImages = display.newGroup()
local welcomeButtons = display.newGroup()


-----------------------------------------
-- RELEASE MODE
-----------------------------------------

removeObject = function(object, group)
  if group then group:remove( object ); end
  if object then object:removeSelf( ); object = nil; end 
end

removeTudo = function()
	if welcomeImages then welcomeImages:remove( backgroundImage ); end
	if backgroundImage then backgroundImage:removeSelf( ); backgroundImage = nil; end 

	--removeObject(backgroundImage, welcomeImages)  -- destroi imagem de fundo
	removeObject(loginButton, welcomeButtons)  -- destroi botao login
	removeObject(signupButton, welcomeButtons)  -- destroi botao signup	

  	abstractmenugui.removeMuteSoundButton()  -- destroi o botao de mutar som
end

criaTudo = function()

	if player_validated  == 1 then
		removeTudo()
		composer.gotoScene( "menu" )
	else

		--------------------------------------------------------------------------------------------------------------------------------
		--  description -> method (type, x, y, imageDefaultFile, imageOverFile, text, textColor, fieldsize, fontName, fontSize, eventFunction)
		--------------------------------------------------------------------------------------------------------------------------------
		-- IMAGE BACKGROUND
		backgroundImage = abstractmenugui.createMenuAbstractObject(
			"image",display.contentCenterX, display.contentCenterY,
			templateWelcomeBackgroundFile,nil,nil,nil,nil,nil,nil,nil)
		welcomeImages:insert( backgroundImage )		
		
		-- BOTAO SIGNUP
		signupButton = abstractmenugui.createMenuAbstractObject(
			"button",display.contentCenterX*0.70, display.contentCenterY*1.55,
			templateSignupButtonDefaultFile,templateSignupButtonOverFile,nil,nil,nil,nil,nil,abstractmenugui.menuAbstractTransitionEvent("signup"))
		welcomeButtons:insert( signupButton )

		-- BOTAO LOGIN
		loginButton = abstractmenugui.createMenuAbstractObject(
			"button",display.contentCenterX*1.30, display.contentCenterY*1.55,
			templateLoginButtonDefaultFile,templateLoginButtonOverFile,nil,nil,nil,nil,nil,abstractmenugui.menuAbstractTransitionEvent("login"))
		welcomeButtons:insert( loginButton )

		-- BOTAO MUTAR SOM
		abstractmenugui.createMuteSoundButton(display.contentCenterX*1.75, display.contentCenterY*1.65,"")
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