
require "configuracaopubnub"

local widget = require( "widget" )
local storyboard = require( "storyboard" )

local scene = storyboard.newScene()

local tHeight   -- forward reference

local scene = storyboard.newScene()
require( "status" )


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

local highscoreButton, reiniciarButton, menuButton
local gameoverButtons = display.newGroup()

local function removeTudo()

  if(highscoreButton) then gameoverButtons:remove( highscoreButton ); highscoreButton = nil; end  
  
  if(reiniciarButton) then gameoverButtons:remove( reiniciarButton ); reiniciarButton = nil; end       

  if(menuButton) then gameoverButtons:remove( menuButton ); menuButton = nil; end 
end

local highscoreButtonPress = function( event )

  setStatus(3)
  
  removeTudo()
        
  storyboard.gotoScene( "highscore" ) 
end

local reiniciarButtonPress = function( event )

  setStatus(3)
  
  removeTudo()
        
  storyboard.gotoScene( "game" ) 
  
end

local menuButtonPress = function( event )

   setStatus(1)     
   setWinner(0)
  
  removeTudo()
        
  storyboard.gotoScene( "menu" ) 
  
end

local function carregaHighscoreButton()

  highscoreButton = widget.newButton
  {
    defaultFile = "buttonBlue.png",
    overFile = "buttonBlueOver.png",
    label = "Highscore",
    labelColor = 
    { 
      default = { 255, 255, 255 }, 
    },
    fontSize = 26,
    emboss = true,
    onPress = highscoreButtonPress,
  }
  local s = display.getCurrentStage()
  highscoreButton.x = s.contentWidth/2; highscoreButton.y = 300
  gameoverButtons:insert(highscoreButton)
end

local function carregaReiniciarButton()

  reiniciarButton = widget.newButton
  {
    defaultFile = "buttonBlue.png",
    overFile = "buttonBlueOver.png",
    label = "Reiniciar",
    labelColor = 
    { 
      default = { 255, 255, 255 }, 
    },
    fontSize = 26,
    emboss = true,
    onPress = reiniciarButtonPress,
  }
  local s = display.getCurrentStage()
  reiniciarButton.x = s.contentWidth/2; reiniciarButton.y = 370
  gameoverButtons:insert(reiniciarButton)
end

local function carregaMenuButton()

  menuButton = widget.newButton
  {
    defaultFile = "buttonBlue.png",
    overFile = "buttonBlueOver.png",
    label = "Menu",
    labelColor = 
    { 
      default = { 255, 255, 255 }, 
    },
    fontSize = 26,
    emboss = true,
    onPress = menuButtonPress,
  }
  local s = display.getCurrentStage()
  menuButton.x = s.contentWidth/2; menuButton.y = 440
  gameoverButtons:insert(menuButton)
end

local criaTudo = function()
  
  if not highscoreButton then carregaHighscoreButton();  end 

  if not reiniciarButton then carregaReiniciarButton();  end   

  if not menuButton then carregaMenuButton();  end   
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
  local group = self.view

  -- Load the background image
  local winner = getWinner()
  local bg = display.newImage( "end" .. winner .. ".png" )
  
  -- Samuel
--  send_game_winner(winner)
  
  group:insert( bg )
  
  criaTudo()  

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )

  removeTudo()
  
  local group = self.view

  -- Load the background image
  local winner = getWinner()
  local bg = display.newImage( "end" .. winner .. ".png" )
  
  -- Samuel
--  send_game_winner(winner)
  
  group:insert( bg )
    
  criaTudo()
    
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
  local group = self.view
  
  removeTudo()
    
  
end

-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
  local group = self.view
  
  removeTudo()
    
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