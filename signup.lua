-- signup
-------------------------------------------
-- LIBs
-------------------------------------------

require( "includeall" )

-----------------------------------------
-- Prototype Objects and Methods
-----------------------------------------

local criaTudo, removeTudo, webListener

local labels = {}
local fields = {}
local cancelButton, confirmButton, backgroundImage, webView

local imagesGroup = display.newGroup()
local buttonsGroup = display.newGroup()


-----------------------------------------
-- VAR
-----------------------------------------
local sum_form_offset_x = 0 -- to move all the objects of the form
local sum_form_offset_y = 0 -- to move all the objects of the form

removeObject = function(object, group)
  if group then group:remove( object ); end
  if object then object:removeSelf( ); object = nil; end 
end

removeTudo = function()
  removeObject(backgroundImage, imagesGroup)  -- destroi imagem de fundo
  removeObject(loginButton, buttonsGroup)  -- destroi botao Confirm
  removeObject(cancelpButton, buttonsGroup)  -- destroi botao Cancel 
end

function webListener( event )
    if ( event.url ) then
        print( "You are visiting: " .. event.url )
    end
end

createWebView = function()
  webView = native.newWebView( display.contentCenterX, display.contentCenterY, 640, 960 )
  webView:request( "http://scpanel.psyfun.com.br/players/add" )

  webView:addEventListener( "urlRequest", webListener )
end

criaTudo = function()

    -- IMAGE BACKGROUND

  createWebView()


 

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