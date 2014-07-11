------------------------------------------------------------------------------------------------------------------------------
-- welcome.lua
-- Dewcription: welcome screen
-- @author Erick <erickhaendel@gmail.com>
-- @modified 
-- @version 1.00
-- @date 06/29/2014
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

local cadastrarNameField, cadastrarEmailField, cadastrarPasswordField, cadastrarConfirmPasswordField
local cadastrarEmailLabel, cadastrarNameLabel, cadastrarPasswordLabel, cadastrarConfirmPasswordLabel
local cadastrarDefaultButton, cadastrarVoltarButton

local cadastrarFields = display.newGroup()
local cadastrarLabels = display.newGroup()
local cadastrarButtons = display.newGroup()

-------------------------------------------
-- *** Add field labels ***
-------------------------------------------

local function carregaCadastrarNameLabel()
  cadastrarNameLabel = display.newText( "Nome:", 60, 100, native.systemFontBold, 18 )
  cadastrarNameLabel:setTextColor( 0, 0, 0, 255 )
  cadastrarLabels:insert(cadastrarNameLabel)
end

local function carregaCadastrarNameField()
  cadastrarNameField = native.newTextField( 60, 120, 240, tHeight )
  cadastrarNameField.font = native.newFont( native.systemFontBold, inputFontSize )
  cadastrarNameField:addEventListener( "userInput", fieldHandler( function() return cadastrarNameField end ) ) 
  cadastrarFields:insert(cadastrarNameField)
end

local function carregaCadastrarEmailLabel()
  cadastrarEmailLabel = display.newText( "Email:", 60, 160, native.systemFontBold, 18 )
  cadastrarEmailLabel:setTextColor( 0, 0, 0, 255 )
  cadastrarLabels:insert(cadastrarEmailLabel)
end

local carregaCadastrarEmailField = function()
  cadastrarEmailField = native.newTextField( 60, 180, 240, tHeight )
  cadastrarEmailField.font = native.newFont( native.systemFontBold, inputFontSize )
  cadastrarEmailField:addEventListener( "userInput", fieldHandler( function() return cadastrarEmailField end ) ) 
  cadastrarFields:insert(cadastrarEmailField)
end

local carregaCadastrarPasswordLabel = function()
  cadastrarPasswordLabel = display.newText( "Senha:", 60, 220, native.systemFontBold, 18 )
  cadastrarPasswordLabel:setTextColor( 0, 0, 0, 255 )
  cadastrarLabels:insert(cadastrarPasswordLabel)
end

local carregaCadastrarPasswordField = function()
  cadastrarPasswordField = native.newTextField( 60, 240, 240, tHeight )
  cadastrarPasswordField.font = native.newFont( native.systemFontBold, inputFontSize )
  cadastrarPasswordField.isSecure = true
  cadastrarPasswordField:addEventListener( "userInput", fieldHandler( function() return cadastrarPasswordField end ) ) 
  cadastrarFields:insert(cadastrarPasswordField)
end

local carregaCadastrarConfirmPasswordLabel = function()
  cadastrarConfirmPasswordLabel = display.newText( "Confirme Senha:", 60, 280, native.systemFontBold, 18 )
  cadastrarConfirmPasswordLabel:setTextColor( 0, 0, 0, 255 )
  cadastrarLabels:insert(cadastrarConfirmPasswordLabel)
end

local carregaCadastrarConfirmPasswordField = function()
  cadastrarConfirmPasswordField = native.newTextField( 60, 300, 240, tHeight )
  cadastrarConfirmPasswordField.font = native.newFont( native.systemFontBold, inputFontSize )
  cadastrarConfirmPasswordField.isSecure = true
  cadastrarConfirmPasswordField:addEventListener( "userInput", fieldHandler( function() return cadastrarConfirmPasswordField end ) ) 
  cadastrarFields:insert(cadastrarConfirmPasswordField)
end

local function cadastrarRemoveTudo()

  if cadastrarNameLabel then display.remove( cadastrarNameLabel ); cadastrarLabels:remove( cadastrarNameLabel ); cadastrarNameLabel = nil; end
      
  if cadastrarNameField then cadastrarNameField:removeSelf(); cadastrarFields:remove( cadastrarNameField ); cadastrarNameField = nil; end
  
  if cadastrarEmailLabel then display.remove( cadastrarEmailLabel ); cadastrarLabels:remove( cadastrarEmailLabel ); cadastrarEmailLabel = nil; end

  if cadastrarEmailField then cadastrarEmailField:removeSelf(); cadastrarFields:remove( cadastrarEmailField ); cadastrarEmailField = nil; end  
  
  if cadastrarPasswordLabel then display.remove( cadastrarPasswordLabel ); cadastrarLabels:remove( cadastrarPasswordLabel ); cadastrarPasswordLabel = nil; end
 
  if cadastrarPasswordField then cadastrarPasswordField:removeSelf(); cadastrarFields:remove( cadastrarPasswordField ); cadastrarPasswordField = nil; end
  
  if cadastrarConfirmPasswordLabel then display.remove( cadastrarConfirmPasswordLabel ); cadastrarLabels:remove( cadastrarConfirmPasswordLabel ); cadastrarConfirmPasswordLabel = nil; end
 
  if cadastrarConfirmPasswordField then cadastrarConfirmPasswordField:removeSelf(); cadastrarFields:remove( cadastrarConfirmPasswordField ); cadastrarConfirmPasswordField = nil; end
    
  if cadastrarDefaultButton then cadastrarButtons:remove( cadastrarDefaultButton ); cadastrarDefaultButton = nil; end  
  
  if cadastrarVoltarButton then cadastrarButtons:remove( cadastrarVoltarButton ); cadastrarVoltarButton = nil; end   
end   

local function cadastrarListener(event)
     if(getCadastro() == 1) then
        local alert = native.showAlert( "Cadastro", "Cadastrado.", { "OK" }, onComplete )                 
      
      setCadastro(1)
      
      cadastrarRemoveTudo()
      
      storyboard.gotoScene( "login" )  
            
     end  

   if(getCadastro() == 0) then
   
    setCadsatro(0)

    local alert = native.showAlert( "Cadastro", "Erro ao realizar cadastro", { "OK" }, onComplete ) 
    
  end
end


local cadastrarButtonPress = function( event )

  local nome = cadastrarNameField.text
  local email = cadastrarEmailField.text
  local senha = cadastrarPasswordField.text
  local confirmacao_senha = cadastrarPasswordField.text
  local dados = {"cadastrar",nome,email,senha}
  
  if nome == "" or nome == nil or email == "" or email == nil or senha == "" or senha == nil or confirmacao_senha == "" or confirmacao_senha == nil then

    local cadastro_erro = native.showAlert( "Cadastro", "Erro. Preencha todos os campos corretamente", { "OK" }, onComplete ) 

  elseif( senha == confirmacao_senha ) then

      send_pubnub(dados)  
      
      timer.performWithDelay( 10000,cadastrarListener,1)       
  end
end

local cadastrarVoltarButtonPress = function( event )

  storyboard.gotoScene( "login" ) 
end

local function carregaCadastrarDefaultButton()
  cadastrarDefaultButton = widget.newButton
  {
    defaultFile = "buttonBlue.png",
    overFile = "buttonBlueOver.png",
    label = "Cadastrar",
    labelColor = 
    { 
      default = { 255, 255, 255 }, 
    },
    fontSize = 26,
    emboss = true,
    onPress = cadastrarButtonPress,
  }
  local s = display.getCurrentStage()
  cadastrarDefaultButton.x = s.contentWidth/2; cadastrarDefaultButton.y = 370
  cadastrarButtons:insert(cadastrarDefaultButton)
end

local function carregaCadastrarVoltarButton()
  cadastrarVoltarButton = widget.newButton
  {
    defaultFile = "buttonBlue.png",
    overFile = "buttonBlueOver.png",
    label = "Voltar",
    labelColor = 
    { 
      default = { 255, 255, 255 }, 
    },
    fontSize = 26,
    emboss = true,
    onPress = cadastrarVoltarButtonPress,
  }

  local s = display.getCurrentStage()
  
  cadastrarVoltarButton.x = s.contentWidth/2; cadastrarVoltarButton.y = 430
  cadastrarButtons:insert(cadastrarVoltarButton)
end  

local function criaTudo()

  setCadastro(0)
  
  if not cadastrarNameLabel then carregaCadastrarNameLabel();  end  
    
  if not cadastrarNameField then carregaCadastrarNameField();  end
  
  if not cadastrarEmailLabel then carregaCadastrarEmailLabel();  end  
    
  if not cadastrarEmailField then carregaCadastrarEmailField();  end
    
  if not cadastrarPasswordLabel then carregaCadastrarPasswordLabel();  end  
  
  if not cadastrarPasswordField then carregaCadastrarPasswordField();  end 

  if not cadastrarConfirmPasswordLabel then carregaCadastrarConfirmPasswordLabel();  end  
  
  if not cadastrarConfirmPasswordField then carregaCadastrarConfirmPasswordField();  end 
  
  if not cadastrarDefaultButton then carregaCadastrarDefaultButton();  end 

  if not cadastrarVoltarButton then carregaCadastrarVoltarButton();  end   

end

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

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
  -- Load the background image
  local bg = display.newImage( "title.png" )
  group:insert( bg )

  criaTudo()
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	criaTudo()
		
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	 cadastrarRemoveTudo()
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
  cadastrarRemoveTudo()
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene