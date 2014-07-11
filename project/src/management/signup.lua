------------------------------------------------------------------------------------------------------------------------------
-- signup.lua
-- Description: signup screen
-- @author Samuel Martins <samuellunamartins@gmail.com>
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

local tHeight   -- forward reference

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
local signupBackground
local signupEmailField, signupPasswordField, signupAgeField, signupGenderField, signupUsernameField
local signupCancelButton, signupSendButton

-- METHODS PROTOTYPE
local loadEmailField, loadBackgound, loadUsernameField, loadGenderField, loadAgeField, loadEmailField, loadPasswordField
local loadCancelButton,loadLoginSendButton,removeAll
local signupListener, signupButtonPress, sendButtonPress, createAll

-- GROUPS
local signupFields = display.newGroup()
local signupButtons = display.newGroup()

-- METHODS
loadBackground = function()

  signupBackground = display.newImage( 
    configuration.signup_background_image, 
    display.contentCenterX, 
    display.contentCenterY, 
    true )
  signupBackground:toBack( )

end

loadEmailField = function()
  signupEmailField = native.newTextField( 
    configuration.signup_email_field_x, 
    configuration.signup_email_field_y, 
    configuration.signup_email_size_field, 
    tHeight )

  signupEmailField.font = native.newFont( native.systemFontBold, inputFontSize )
  signupEmailField:addEventListener( "userInput", fieldHandler( function() return signupEmailField end ) ) 
  signupFields:insert(signupEmailField)
end

loadPasswordField = function()
  signupPasswordField = native.newTextField( 
    configuration.signup_password_field_x, 
    configuration.signup_password_field_y, 
    configuration.signup_password_size_field, 
    tHeight )
  signupPasswordField.font = native.newFont( native.systemFontBold, inputFontSize )
  signupPasswordField.isSecure = true
  signupPasswordField:addEventListener( "userInput", fieldHandler( function() return signupPasswordField end ) ) 
  signupFields:insert(signupPasswordField)
end

loadUsernameField = function()
  signupUsernameField = native.newTextField( 
    configuration.signup_username_field_x, 
    configuration.signup_username_field_y, 
    configuration.signup_username_size_field, 
    tHeight )
  signupUsernameField.font = native.newFont( native.systemFontBold, inputFontSize )
  signupUsernameField:addEventListener( "userInput", fieldHandler( function() return signupUsernameField end ) ) 
  signupFields:insert(signupUsernameField)
end

loadGenderField = function()
  signupGenderField = native.newTextField( 
    configuration.signup_gender_field_x, 
    configuration.signup_gender_field_y, 
    configuration.signup_gender_size_field, 
    tHeight )
  signupGenderField.font = native.newFont( native.systemFontBold, inputFontSize )
  signupGenderField:addEventListener( "userInput", fieldHandler( function() return signupGenderField end ) ) 
  signupFields:insert(signupGenderField)
end

loadAgeField = function()
  signupAgeField = native.newTextField( 
    configuration.signup_age_field_x, 
    configuration.signup_age_field_y, 
    configuration.signup_age_size_field, 
    tHeight )
  signupAgeField.font = native.newFont( native.systemFontBold, inputFontSize )
  signupAgeField:addEventListener( "userInput", fieldHandler( function() return signupAgeField end ) ) 
  signupFields:insert(signupAgeField)
end

loadCancelButton = function()

  signupCancelButton = widget.newButton
  {
    defaultFile = configuration.cancel_button_image,
    overFile = configuration.cancel_button_image,
    emboss = true,
    onPress = cancelButtonPress,
  }

  signupCancelButton.x = configuration.signup_cancel_button_x
  signupCancelButton.y = configuration.signup_cancel_button_y
  signupButtons:insert(signupCancelButton)
end

loadLoginSendButton = function()

  signupSendButton = widget.newButton{ 
  defaultFile = configuration.signup_button_image,
  overFile = configuration.signup_button_image,
  emboss = true,
  onPress = sendButtonPress,}

  signupSendButton.x = configuration.signup_send_button_x
  signupSendButton.y = configuration.signup_send_button_y
  signupButtons:insert(signupSendButton)
end

function removeAll()

  if(signupBackground) then signupBackground = nil; end

  if(signupEmailField) then signupEmailField:removeSelf(); signupFields:remove( signupEmailField ); signupEmailField = nil; end
  
  if(signupPasswordField) then signupPasswordField:removeSelf(); signupFields:remove( signupPasswordField ); signupPasswordField = nil; end

  if(signupUsernameField) then signupUsernameField:removeSelf(); signupFields:remove( signupUsernameField ); signupUsernameField = nil; end
  
  if(signupGenderField) then signupGenderField:removeSelf(); signupFields:remove( signupGenderField ); signupGenderField = nil; end

  if(signupAgeField) then signupAgeField:removeSelf(); signupFields:remove( signupAgeField ); signupAgeField = nil; end
  
  if(signupCancelButton) then signupButtons:remove( signupCancelButton ); signupCancelButton = nil; end  
  
  if(signupSendButton) then signupButtons:remove( signupSendButton ); signupSendButton = nil; end       
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
  local email = signupEmailField.text
  local senha = signupPasswordField.text
  local dados = {"signup",id,email,senha}
--  email = "teste"
--  senha = "123"
--  local dados = {"signup",id,email,senha}

  removeAll()    
  
  composer.gotoScene( "src.management.menu", "slideLeft", 400 )
  
  -- Validacao inicial do formulario
  --if (email == "" or email == nil or senha == "" or senha == nil ) then
  
  -- local alert = native.showAlert( "Login", "Erro. Email e/ou senha inválida"..email..senha, { "OK" }, onComplete )

  -- Envia as informacoes ao servidor pubnub
  --else  
    --setEmail(email)

    --send_pubnub(dados) 

--    signupListener(event)    

 --   timer.performWithDelay( 10000,signupListener,1) 
  
--  end

end

cancelButtonPress = function( event )
  
  removeAll()   
  
  composer.gotoScene( "src.management.welcome", "slideLeft", 400 )

end



createAll = function()
  
  if not signupBackground then  loadBackground();  end  

  if not signupEmailField then loadEmailField();  end
    
  if not signupPasswordField then loadPasswordField();  end 

  if not signupUsernameField then loadUsernameField();  end
    
  if not signupGenderField then loadGenderField();  end 

  if not signupAgeField then loadAgeField();  end

  if not signupCancelButton then loadCancelButton();  end 

  if not signupSendButton then loadLoginSendButton();  end   

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