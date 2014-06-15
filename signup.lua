-- signup
-------------------------------------------
-- LIBs
-------------------------------------------

require( "includeall" )

-----------------------------------------
-- Prototype Objects and Methods
-----------------------------------------

local criaTudo, removeTudo

local labels = {}
local fields = {}
local backButton, confirmButton, backgroundImage

local signupImages = display.newGroup()
local signupButtons = display.newGroup()
local signupLabels = display.newGroup()
local signupFields = display.newGroup()

-----------------------------------------
-- VAR
-----------------------------------------
local sum_form_offset_x = 0 -- to move all the objects of the form
local sum_form_offset_y = 0 -- to move all the objects of the form

removeTudo = function()

  abstractmenugui.removeMenuAbstractObject(backgroundImage, signupImages ) 
  abstractmenugui.removeMenuAbstractObject(backButton, signupButtons ) 
  abstractmenugui.removeMenuAbstractObject(confirmButton, signupButtons ) 

  for i=1,5 do
    abstractmenugui.removeMenuAbstractObject(labels[i], signupLabels ) 
    abstractmenugui.removeMenuAbstractObject(fields[i], signupFields ) 
  end
  
  abstractmenugui.removeMuteSoundButton()  
  
end

criaTudo = function()

    ---------------------------------------------------------------------------------------------------------------------------------------
    --  description -> method (type, x, y, imageDefaultFile, imageOverFile, text, textColor, fieldsize, fontName, fontSize, eventFunction)
    ---------------------------------------------------------------------------------------------------------------------------------------
    -- IMAGE BACKGROUND
    backgroundImage = abstractmenugui.createMenuAbstractObject(
      "image",
      display.contentCenterX, 
      display.contentCenterY,
      templateSignupBackgroundFile,
      nil,nil,nil,nil,nil,nil,nil)

    signupImages:insert( backgroundImage ) 

    ---------------------------------------------------------------------------------------------------------------------------------------
    --  description -> method (type, x, y, imageDefaultFile, imageOverFile, text, textColor, fieldsize, fontName, fontSize, eventFunction)
    ---------------------------------------------------------------------------------------------------------------------------------------
      -- BOTAO BACK
    backButton = abstractmenugui.createMenuAbstractObject(
      "button",
      display.contentCenterX*0.65, 
      display.contentCenterY*1.50,
      templateBackButtonDefaultFile,
      templateBackButtonOverFile, 
      nil,nil,nil,nil,nil, abstractmenugui.menuAbstractTransitionEvent("welcome"))

    signupButtons:insert( backButton )    

    nomes = {"Username","E-mail","Password","Sex","Age"}
    for i=1,5 do
      ---------------------------------------------------------------------------------------------------------------------------------------
      --  description -> method (type, x, y, imageDefaultFile, imageOverFile, text, textColor, fieldsize, fontName, fontSize, eventFunction)
      ---------------------------------------------------------------------------------------------------------------------------------------
        -- LABEL NAME
      labels[i] = abstractmenugui.createMenuAbstractObject(
        "label",
        display.contentCenterX*0.70, 
        display.contentCenterY*0.50 + i*45,
        templateBackButtonDefaultFile,
        templateBackButtonOverFile, 
        nomes[i], nil, nil, native.systemFontBold, 26, nil)  

      ---------------------------------------------------------------------------------------------------------------------------------------
      --  description -> method (type, x, y, imageDefaultFile, imageOverFile, text, textColor, fieldsize, fontName, fontSize, eventFunction)
      ---------------------------------------------------------------------------------------------------------------------------------------
        -- FIELD NAME
      fields[i] = abstractmenugui.createMenuAbstractObject(
        "field",
        display.contentCenterX*1.10, 
        display.contentCenterY*0.50 + i*45,
        templateBackButtonDefaultFile,
        templateBackButtonOverFile, 
        "", nil, nil, nil, 26, nil)  
    end

    -- BOTAO MUTE SOUND
    abstractmenugui.createMuteSoundButton( -- x,y,text
      display.contentCenterX*1.75, 
      display.contentCenterY*1.65,
      "")

    -- Inserting the objects into respective groups
    for i=1,5 do
      signupLabels:insert( labels[i] )
      signupFields:insert( fields[i] )
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