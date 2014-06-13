-------------------------------------------
-- LIBs
-------------------------------------------

require( "includeall" )

local scene = storyboard.newScene()

local menuLoginButton

local menuButtons = display.newGroup()

local titleLabel, bodyTextLabel

local labels = display.newGroup()

local function removeTudo()
  if titleLabel       then labels:remove( titleLabel ); titleLabel = nil; end  
  if bodyTextLabel    then labels:remove( bodyTextLabel ); bodyTextLabel = nil; end  
  if menuLoginButton  then menuButtons:remove( menuLoginButton ); menuLoginButton = nil; end        
end

local menuLoginButtonPress = function( event )
  removeTudo(); storyboard.gotoScene( "login" ) 
end

local carregaTitleLabel = function()
	titleLabel = display.newText( "Login to Play!", 0, 0, templateDefaultFont, templateDefaultTitleSizeFont )
    titleLabel:setFillColor( 0, 0, 0 )  
	local s = display.getCurrentStage()
	titleLabel.x = s.contentWidth/2; titleLabel.y = 40
	labels:insert(titleLabel)
end

local carregaBodyTextLabel = function()

	text = "You need a Facebook account to play!"	
	
	local s = display.getCurrentStage()
	bodyTextLabel = display.newText( text,  s.contentWidth/2, 230, 300, 300, 
    templateDefaultFont, templateDefaultBobdySizeFont )
    bodyTextLabel:setFillColor( 0, 0, 0 )  
	labels:insert(bodyTextLabel)
end

local carregaMenuLoginButton = function()
  menuLoginButton = widget.newButton { 
  defaultFile = templateFacebookButtonFile, 
  overFile = templateFacebookButtonOverFile, 
  label = "Login",
  labelColor = { default = { 255, 255, 255 }, }, fontSize = templateDefaultButtonSizeFont, 
  emboss = true, onPress = menuLoginButtonPress, }
  local s = display.getCurrentStage()
  menuLoginButton.x = s.contentWidth/2; menuLoginButton.y = 250
  menuButtons:insert(menuLoginButton)
end

local criaTudo = function() 
  if not titleLabel       then carregaTitleLabel();  end 
  if not bodyTextLabel    then carregaBodyTextLabel();  end   
  if not menuLoginButton  then carregaMenuLoginButton();  end 
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