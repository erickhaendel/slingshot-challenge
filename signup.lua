-- signup
-------------------------------------------
-- LIBs
-------------------------------------------

require( "includeall" )

-----------------------------------------
-- Prototype Objects and Methods
-----------------------------------------

local criaTudo, removeTudo

local carregaCadastrarNameLabel, carregaCadastrarNameField
local carregaCadastrarEmailLabel, carregaCadastrarEmailField
local carregaCadastrarPasswordLabel, carregaCadastrarPasswordField
local carregaCadastrarSexLabel, carregaCadastrarSexField
local carregaCadastrarAgeLabel, carregaCadastrarAgeField
local carregaCadastrarConfirmButton

local cadastrarNameLabel, cadastrarNameField
local cadastrarEmailLabel, cadastrarEmailField
local cadastrarPasswordLabel, cadastrarPasswordField
local cadastrarSexLabel, cadastrarSexField
local cadastrarAgeLabel, cadastrarAgeField
local cadastrarConfirmButton 

local cadastrarFields = display.newGroup()
local cadastrarLabels = display.newGroup()
local cadastrarButtons = display.newGroup()

-----------------------------------------
-- VAR
-----------------------------------------
local sum_form_offset_x = 0 -- to move all the objects from the form
local sum_form_offset_y = 0 -- to move all the objects from the form

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
-- ANDROID MODE
-----------------------------------------

-- It is necessary to show the input objects correct
local isAndroid = "Android" == system.getInfo( "platformName" )
local inputFontSize = 18
local tHeight = 30

if ( isAndroid ) then
    inputFontSize = inputFontSize - 4
    tHeight = tHeight + 10
end

-----------------------------------------
-- RELEASE MODE
-----------------------------------------

removeTudo = function()

  abstractmenugui.removeMenuBackgroundImage() 

  abstractmenugui.removeMuteSoundButton()  

  if cadastrarNameLabel then display.remove( cadastrarNameLabel ); cadastrarLabels:remove( cadastrarNameLabel ); cadastrarNameLabel = nil; end
      
  if cadastrarNameField then cadastrarNameField:removeSelf(); cadastrarFields:remove( cadastrarNameField ); cadastrarNameField = nil; end
  
  if cadastrarEmailLabel then display.remove( cadastrarEmailLabel ); cadastrarLabels:remove( cadastrarEmailLabel ); cadastrarEmailLabel = nil; end

  if cadastrarEmailField then cadastrarEmailField:removeSelf(); cadastrarFields:remove( cadastrarEmailField ); cadastrarEmailField = nil; end  
  
  if cadastrarPasswordLabel then display.remove( cadastrarPasswordLabel ); cadastrarLabels:remove( cadastrarPasswordLabel ); cadastrarPasswordLabel = nil; end
 
  if cadastrarPasswordField then cadastrarPasswordField:removeSelf(); cadastrarFields:remove( cadastrarPasswordField ); cadastrarPasswordField = nil; end
  
  if cadastrarSexLabel then display.remove( cadastrarSexLabel ); cadastrarLabels:remove( cadastrarSexLabel ); cadastrarSexLabel = nil; end
 
  if cadastrarSexField then cadastrarSexField:removeSelf(); cadastrarFields:remove( cadastrarSexField ); cadastrarSexField = nil; end
    
  if cadastrarAgeLabel then display.remove( cadastrarAgeLabel ); cadastrarLabels:remove( cadastrarAgeLabel ); cadastrarAgeLabel = nil; end
 
  if cadastrarAgeField then cadastrarAgeField:removeSelf(); cadastrarFields:remove( cadastrarAgeField ); cadastrarAgeField = nil; end

  if cadastrarConfirmButton then cadastrarButtons:remove( cadastrarConfirmButton ); cadastrarConfirmButton = nil; end  

  -- abstractmenugui.removeBackButton()   
  
end

criaTudo = function()

  abstractmenugui.createMenuBackgroundImage( -- x,y,image
    display.contentCenterX, 
    display.contentCenterY,
    templateSignupBackgroundFile)

	abstractmenugui.createMuteSoundButton( -- x,y,text
		display.contentCenterX*1.75, 
		display.contentCenterY*1.65,
		"")

  abstractmenugui.createMenuBackButton( -- x,y, image, image_when_pressed, text, destination
    display.contentCenterX*0.65, 
    display.contentCenterY*1.50,
    templateBackButtonDefaultFile,
    templateBackButtonOverFile, 
    "",   
    "welcome")

    if not cadastrarNameLabel then carregaCadastrarNameLabel();  end  
      
    --if not cadastrarNameField then carregaCadastrarNameField();  end
    
    if not cadastrarEmailLabel then carregaCadastrarEmailLabel();  end  
      
    --if not cadastrarEmailField then carregaCadastrarEmailField();  end
      
    if not cadastrarPasswordLabel then carregaCadastrarPasswordLabel();  end  
    
    --if not cadastrarPasswordField then carregaCadastrarPasswordField();  end 

    if not cadastrarSexLabel then carregaCadastrarSexLabel();  end  
    
    --if not cadastrarSexField then carregaCadastrarSexField();  end 
    
    if not cadastrarAgeLabel then carregaCadastrarAgeLabel();  end  
    
    --if not cadastrarAgeField then carregaCadastrarAgeField();  end 

    --if not cadastrarConfirmButton then carregaCadastrarConfirmButton();  end 

end

-------------------------------------------
-- *** Add field labels ***
-------------------------------------------

carregaCadastrarNameLabel = function()
  cadastrarNameLabel = display.newText( "Username:",  display.contentCenterX*0.70 + sum_form_offset_x, display.contentCenterY*0.50 + sum_form_offset_y, native.systemFontBold, 30 )
  cadastrarNameLabel:setFillColor( 0, 0, 0, 255 )
  cadastrarLabels:insert(cadastrarNameLabel)
end

carregaCadastrarNameField = function()
  cadastrarNameField = native.newTextField( display.contentCenterX*1.10 + sum_form_offset_x, display.contentCenterY*0.50 + sum_form_offset_y, 240, tHeight )
  cadastrarNameField.font = native.newFont( native.systemFontBold, inputFontSize )
  --cadastrarNameField:addEventListener( "userInput", fieldHandler( function() return cadastrarNameField; end ) ) 
  cadastrarFields:insert(cadastrarNameField)
end

carregaCadastrarEmailLabel = function()
  cadastrarEmailLabel = display.newText( "Email:", display.contentCenterX*0.70 + sum_form_offset_x, display.contentCenterY*0.65 + sum_form_offset_y, native.systemFontBold, 30 )
  cadastrarEmailLabel:setFillColor( 0, 0, 0, 255 )
  cadastrarLabels:insert(cadastrarEmailLabel)
end

carregaCadastrarEmailField = function()
  cadastrarEmailField = native.newTextField( display.contentCenterX*1.10 + sum_form_offset_x, display.contentCenterY*0.65 + sum_form_offset_y, 240, tHeight )
  cadastrarEmailField.font = native.newFont( native.systemFontBold, inputFontSize )
  -- cadastrarEmailField:addEventListener( "userInput", fieldHandler( function() return cadastrarEmailField; end ) ) 
  cadastrarFields:insert(cadastrarEmailField)
end

carregaCadastrarPasswordLabel = function()
  cadastrarPasswordLabel = display.newText( "Password:", display.contentCenterX*0.70 + sum_form_offset_x, display.contentCenterY*0.80 + sum_form_offset_y, native.systemFontBold, 30 )
  cadastrarPasswordLabel:setFillColor( 0, 0, 0, 255 )
  cadastrarLabels:insert(cadastrarPasswordLabel)
end

carregaCadastrarPasswordField = function()
  cadastrarPasswordField = native.newTextField( display.contentCenterX*1.10 + sum_form_offset_x, display.contentCenterY*0.80 + sum_form_offset_y, 240, tHeight )
  cadastrarPasswordField.font = native.newFont( native.systemFontBold, inputFontSize )
  cadastrarPasswordField.isSecure = true
  -- cadastrarPasswordField:addEventListener( "userInput", fieldHandler( function() return cadastrarPasswordField; end ) ) 
  cadastrarFields:insert(cadastrarPasswordField)
end

carregaCadastrarSexLabel = function()
  cadastrarSexLabel = display.newText( "Sex:", display.contentCenterX*0.70 + sum_form_offset_x, display.contentCenterY*0.95 + sum_form_offset_y, native.systemFontBold, 30 )
  cadastrarSexLabel:setFillColor( 0, 0, 0, 255 )
  cadastrarLabels:insert(cadastrarSexLabel)
end

carregaCadastrarSexField = function()
  cadastrarSexField = native.newTextField( display.contentCenterX*1.10 + sum_form_offset_x, display.contentCenterY*0.95 + sum_form_offset_y, 240, tHeight )
  cadastrarSexField.font = native.newFont( native.systemFontBold, inputFontSize )
  cadastrarSexField.isSecure = true
  -- cadastrarSexField:addEventListener( "userInput", fieldHandler( function() return cadastrarSexField; end ) ) 
  cadastrarFields:insert(cadastrarSexField)
end

carregaCadastrarAgeLabel = function()
  cadastrarAgeLabel = display.newText( "Age:", display.contentCenterX*0.70 + sum_form_offset_x, display.contentCenterY*1.10 + sum_form_offset_y, native.systemFontBold, 30 )
  cadastrarAgeLabel:setFillColor( 0, 0, 0, 255 )
  cadastrarLabels:insert(cadastrarAgeLabel)
end

carregaCadastrarAgeField = function()
  cadastrarAgeField = native.newTextField( display.contentCenterX*1.10 + sum_form_offset_x, display.contentCenterY*1.10 + sum_form_offset_y, 240, tHeight )
  cadastrarAgeField.font = native.newFont( native.systemFontBold, inputFontSize )
  cadastrarAgeField.isSecure = true
  -- cadastrarAgeField:addEventListener( "userInput", fieldHandler( function() return cadastrarAgeField; end ) ) 
  cadastrarFields:insert(cadastrarAgeField)
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