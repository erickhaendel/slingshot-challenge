-------------------------------------------
-- LIBs
-------------------------------------------

require( "includeall" )

local scene = storyboard.newScene()

local titleLabel, greetingsLabel

local labels = display.newGroup()

local menuVoltarButton

local menuButtons = display.newGroup()

local function removeTudo() 
  if titleLabel       then labels:remove( titleLabel ); titleLabel = nil; end    
  if menuVoltarButton       then menuButtons:remove( menuVoltarButton ); menuVoltarButton = nil; end        
end

local menuVoltarButtonPress = function( event )
  removeTudo(); storyboard.gotoScene( "menu" ) 
end

local carregaMenuVoltarButton = function()
  menuVoltarButton = widget.newButton { 
  defaultFile = templateButtonDefaultFile, 
  overFile = templateButtonOverFile, 
  label = "Back",
  labelColor = { default = { 255, 255, 255 }, }, fontSize = templateDefaultButtonSizeFont,
   emboss = true, onPress = menuVoltarButtonPress, }
  local s = display.getCurrentStage()
  menuVoltarButton.x = s.contentWidth/2; menuVoltarButton.y = 450
  menuButtons:insert(menuVoltarButton)
end

local criaTudo = function() 
  if not menuVoltarButton then carregaMenuVoltarButton();  end 
end

function scene:createScene( event ) 
  local group = self.view
  -- Load the background image
  local bg = display.newImage( templateBackgroundFile, 160, 160, true )
  group:insert( bg )  
  criaTudo()  
end

function scene:enterScene( event )
  criaTudo()
end

function scene:exitScene( event )
  removeTudo()
end

function scene:destroyScene( event )
  removeTudo()
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene