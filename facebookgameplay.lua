-------------------------------------------
-- LIBs
-------------------------------------------

require( "includeall" )

local scene = storyboard.newScene()

local menuVoltarButton, menuChoosingSlingshotButton

local menuButtons = display.newGroup()

local titleLabel, bodyTextLabel

local labels = display.newGroup()

local function removeTudo()
  if titleLabel                   then labels:remove( titleLabel ); titleLabel = nil; end  
  if bodyTextLabel                then labels:remove( bodyTextLabel ); bodyTextLabel = nil; end  
  if menuChoosingSlingshotButton  then menuButtons:remove( menuChoosingSlingshotButton ); menuChoosingSlingshotButton = nil; end     
  if menuVoltarButton             then menuButtons:remove( menuVoltarButton ); menuVoltarButton = nil; end        
end

local menuChoosingSlingshotButtonPress = function( event )
  removeTudo(); storyboard.gotoScene( "choosingslingshot" ) 
end

local menuVoltarButtonPress = function( event )
  removeTudo(); storyboard.gotoScene( "menu" ) 
end

local carregaTitleLabel = function()
	titleLabel = display.newText( "Facebook Play", 0, 0, templateDefaultFont, templateDefaultTitleSizeFont )
  titleLabel:setTextColor( 0, 0, 0 )  
	local s = display.getCurrentStage()
	titleLabel.x = s.contentWidth/2; titleLabel.y = 40
	labels:insert(titleLabel)
end

local carregaBodyTextLabel = function()
	local path = system.pathForFile( "facebookgameplayinstructions.txt", system.ResourceDirectory )
	local file = io.open( path, "r" )
	local howtoplayText = ""
	if file then
		howtoplayText = file:read( "*a" )	
		io.close( file )
		file = nil
	else
		howtoplayText = "Error: could not load How To Play text."	
	end
	local s = display.getCurrentStage()
	bodyTextLabel = display.newText( howtoplayText,  s.contentWidth/2, 230, 300, 300, 
    templateDefaultFont, templateDefaultBobdySizeFont )
	labels:insert(bodyTextLabel)
end

local carregaMenuChoosingSlingshotButton = function()
  menuChoosingSlingshotButton = widget.newButton { 
  defaultFile = templateButtonDefaultFile, 
  overFile = templateButtonOverFile, 
  label = "Choose your Slingshot",
  labelColor = { default = { 255, 255, 255 }, }, fontSize = templateDefaultButtonSizeFont, 
  emboss = true, onPress = menuChoosingSlingshotButtonPress, }
  local s = display.getCurrentStage()
  menuChoosingSlingshotButton.x = s.contentWidth/2; menuChoosingSlingshotButton.y = 400
  menuButtons:insert(menuChoosingSlingshotButton)
end

local carregaMenuVoltarButton = function()
  menuVoltarButton = widget.newButton { 
  defaultFile = templateButtonDefaultFile, 
  overFile = templateButtonOverFile, 
  label = "Back to Main",
  labelColor = { default = { 255, 255, 255 }, }, fontSize = templateDefaultButtonSizeFont, 
  emboss = true, onPress = menuVoltarButtonPress, }
  local s = display.getCurrentStage()
  menuVoltarButton.x = s.contentWidth/2; menuVoltarButton.y = 470
  menuButtons:insert(menuVoltarButton)
end

local criaTudo = function() 
  if not titleLabel                  then carregaTitleLabel();  end 
  if not bodyTextLabel               then carregaBodyTextLabel();  end   
  if not menuChoosingSlingshotButton then carregaMenuChoosingSlingshotButton();  end 
  if not menuVoltarButton            then carregaMenuVoltarButton();  end 
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