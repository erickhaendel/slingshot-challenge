-------------------------------------------
-- LIBs
-------------------------------------------

require( "includeall" )

-----------------------------------------
-- Prototype Functions
-----------------------------------------

local criaTudo, removeTudo, removeObject

local loginButton, signupButton, backgroundImage

local createBackgroundImage, createLoginButton, createSignupButton
local loginButtonPress, signupButtonPress

local imagesGroup = display.newGroup()
local buttonsGroup = display.newGroup()

-----------------------------------------
-- RELEASE MODE
-----------------------------------------

removeObject = function(object, group)
  if group then group:remove( object ); end
  if object then object:removeSelf( ); object = nil; end 
end

removeTudo = function()
	removeObject(backgroundImage, imagesGroup)  -- destroi imagem de fundo
	removeObject(loginButton, buttonsGroup)  -- destroi botao login
	removeObject(signupButton, buttonsGroup)  -- destroi botao signup	
end

createBackgroundImage = function(x,y, templateLogoFile)
  return display.newImage( templateLogoFile, x, y, true )  
end

signupButtonPress = function( event )
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    composer.gotoScene( "signup" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

createSignupButton = function(x,y)
  local button = widget.newButton 
  {
    defaultFile = templateSignupButtonDefaultFile,
    overFile = templateSignupButtonOverFile,
    label = "", 
    labelColor = { default = { 0, 0, 0 }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = signupButtonPress, 
   }

  button.x = x
  button.y = y

  return button
end

loginButtonPress = function( event )
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    composer.gotoScene( "login" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

createLoginButton = function(x,y)
  local button = widget.newButton 
  {
    defaultFile = templateLoginButtonDefaultFile,
    overFile = templateLoginButtonOverFile,
    label = "", 
    labelColor = { default = { 0, 0, 0 }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = loginButtonPress, 
   }

  button.x = x
  button.y = y

  return button
end

criaTudo = function()

	if player_validated  == 1 then
		removeTudo()
		composer.gotoScene( "menu" )
	else

		-- IMAGE BACKGROUND
		backgroundImage = createBackgroundImage(display.contentCenterX, display.contentCenterY,templateWelcomeBackgroundFile)
		imagesGroup:insert( backgroundImage )	

		-- BOTAO SIGNUP
		signupButton = createSignupButton(display.contentCenterX*0.70, display.contentCenterY*1.55)
		buttonsGroup:insert( signupButton )

		-- BOTAO LOGIN
		loginButton = createSignupButton(display.contentCenterX*1.30, display.contentCenterY*1.55)
		buttonsGroup:insert( loginButton )
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