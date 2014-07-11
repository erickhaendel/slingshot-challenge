------------------------------------------------------------------------------------------------------------------------------
-- login.lua
-- Dewcription: login screen
-- @author Samuel Martins <samuellunamartins@gmail.com>
-- @modified 
-- @version 1.00
-- @date 07/10/2014
-- @website http://www.psyfun.com.br
-- @license MIT license
--
-- The MIT License (MIT)
--
-- Copyright (c) 2014 psyfun
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--
------------------------------------------------------------------------------------------------------------------------------

-- my libs
require( "src.infra.includeall" )
local configuration = require( "src.management.configuration" )

local scene = composer.newScene()

local tHeight		-- forward reference

-------------------------------------------
-- General event handler for fields
-------------------------------------------

local function fieldHandler( textField )

	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			print( textField().text )
			
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

-- Handler that gets notified when the alert closes
local function onComplete( event )
    if "clicked" == event.action then
        local i = event.index
        if 1 == i then
                -- Do nothing; dialog will simply dismiss
        end
    end
end

-- OBJECTs PROTOTYPE
local loginBackground
local loginEmailField, loginPasswordField
local loginCancelButton, loginSendButton

-- METHODS PROTOTYPE
local loadEmailField, loadBackgound
local loadPasswordField,loadCancelButton,loadLoginSendButton,removeAll
local loginListener, loginButtonPress, sendButtonPress, createAll

-- GROUPS
local loginFields = display.newGroup()
local loginButtons = display.newGroup()

-- METHODS
loadBackground = function()

  loginBackground = display.newImage( 
    configuration.login_background_image, 
    display.contentCenterX, 
    display.contentCenterY, 
    true )
  loginBackground:toBack( )

end

loadEmailField = function()
  loginEmailField = native.newTextField( 
    configuration.login_email_field_x, 
    configuration.login_email_field_y, 
    configuration.login_email_size_field, 
    tHeight )

  loginEmailField.font = native.newFont( native.systemFontBold, inputFontSize )
  loginEmailField:addEventListener( "userInput", fieldHandler( function() return loginEmailField end ) ) 
  loginFields:insert(loginEmailField)
end

loadPasswordField = function()
  loginPasswordField = native.newTextField( 
    configuration.login_password_field_x, 
    configuration.login_password_field_y, 
    configuration.login_password_size_field, 
    tHeight )
  loginPasswordField.font = native.newFont( native.systemFontBold, inputFontSize )
  loginPasswordField.isSecure = true
  loginPasswordField:addEventListener( "userInput", fieldHandler( function() return loginPasswordField end ) ) 
  loginFields:insert(loginPasswordField)
end

loadCancelButton = function()

  loginCancelButton = widget.newButton
  {
    defaultFile = configuration.cancel_button_image,
    overFile = configuration.cancel_button_image,
    emboss = true,
    onPress = cancelButtonPress,
  }

  loginCancelButton.x = configuration.login_cancel_button_x
  loginCancelButton.y = configuration.login_cancel_button_y
  loginButtons:insert(loginCancelButton)
end

loadLoginSendButton = function()

  loginSendButton = widget.newButton{ 
  defaultFile = configuration.login_button_image,
  overFile = configuration.login_button_image,
  emboss = true,
  onPress = sendButtonPress,}

  loginSendButton.x = configuration.login_send_button_x
  loginSendButton.y = configuration.login_send_button_y
  loginButtons:insert(loginSendButton)
end

function removeAll()

  if(loginBackground) then loginBackground = nil; end

  if(loginEmailField) then loginEmailField:removeSelf(); loginFields:remove( loginEmailField ); loginEmailField = nil; end
  
  if(loginPasswordField) then loginPasswordField:removeSelf(); loginFields:remove( loginPasswordField ); loginPasswordField = nil; end

  if(loginCancelButton) then loginButtons:remove( loginCancelButton ); loginCancelButton = nil; end  
  
  if(loginSendButton) then loginButtons:remove( loginSendButton ); loginSendButton = nil; end       
end

function Listener(event)
--     if(getLogin() == 1) then
--        local alert = native.showAlert( "Login", "conectado.", { "OK" }, onComplete )                 
        removeAll()        

        composer.gotoScene( "src.management.welcome", "slideLeft", 400 )

--     end  

--   if(getLogin() == 0) then
  --      local alert = native.showAlert( "Login", "Erro ao se conectar.XO", { "OK" }, onComplete )           
--   end
end

sendButtonPress = function( event )

  local id = my_player_id
  local email = loginEmailField.text
  local senha = loginPasswordField.text
  local dados = {"login",id,email,senha}
--  email = "teste"
--  senha = "123"
--  local dados = {"login",id,email,senha}

  removeAll()    
  
  composer.gotoScene( "src.management.menu", "slideLeft", 400 )
  
  -- Validacao inicial do formulario
  --if (email == "" or email == nil or senha == "" or senha == nil ) then
  
  -- local alert = native.showAlert( "Login", "Erro. Email e/ou senha inválida"..email..senha, { "OK" }, onComplete )

  -- Envia as informacoes ao servidor pubnub
  --else  
    --setEmail(email)

    --send_pubnub(dados) 

--    loginListener(event)    

 --   timer.performWithDelay( 10000,loginListener,1) 
  
--  end

end

cancelButtonPress = function( event )
  
  removeAll()  	
  
  composer.gotoScene( "src.management.welcome", "slideLeft", 400 )

end



createAll = function()
  
  if not loginBackground then  loadBackground();  end  

  if not loginEmailField then loadEmailField();  end
    
  if not loginPasswordField then loadPasswordField();  end 

  if not loginCancelButton then loadCancelButton();  end 

  if not loginSendButton then loadLoginSendButton();  end   

end

-------------------------------------------
-- *** Create native input textfields ***
-------------------------------------------

-- Note: currently this feature works in device builds or Xcode simulator builds only (also works on Corona Mac Simulator)
local isAndroid = "Android" == system.getInfo("platformName")
local inputFontSize = 18
local inputFontHeight = 30
tHeight = 30

if isAndroid then
	-- Android text fields have more chrome. It's either make them bigger, or make the font smaller.
	-- We'll do both
	inputFontSize = 14
	inputFontHeight = 42
	tHeight = 40
end

-------------------------------------------
-- Create a Background touch event
-------------------------------------------


-- Tapping screen dismisses the keyboard
--
-- Needed for the password and Phone textFields since there is
-- no return key to clear focus.

local listener = function( event )
	-- Hide keyboard
	print("tap pressed")
	native.setKeyboardFocus( nil )
	
	return true
end

----------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view

    
    createAll()

end

-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    createAll()

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then

    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    removeAll()

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    removeAll()
    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene