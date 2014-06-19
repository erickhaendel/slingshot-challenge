local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local btnVisitor -- type newImage
local btnSignup  -- type newImage
local sceneGroup


function removeObject(object, group)
  if group then group:remove( object ); end
  if object then object:removeSelf( ); object = nil; end 
end

function removeAll()
  removeObject(backgroundImage, imagesGroup)  -- destroi imagem de fundo
  removeObject(loginButton, buttonsGroup)  -- destroi botao Confirm
  removeObject(cancelButton, buttonsGroup)  -- destroi botao Cancel 
end

-- "scene:create()"
function scene:create( event )
     sceneGroup = self.view

    -- Create elements
    -- Background & box  welcome
    local background = display.newImage( "resources/images/backgrounds/settings.png", display.contentCenterX , display.contentCenterY , true )
    
    -- Buttons
    btnBack     = display.newImage( "resources/images/buttons/back.png",  200, ( display.contentHeight - 100) , true  )

    -- Create the widget
    local onOffSwitch = widget.newSwitch
    {
        left = 250,
        top = 200,
        style = "onOff",
        id = "onOffSwitch",
        onPress = onSwitchPress
    }


    --Insert elements to scene
    sceneGroup:insert( background ) -- insert background to group

    sceneGroup:insert( btnBack )
    sceneGroup:insert( onOffSwitch )



end

-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then

        -- Eventos
        btnBack:addEventListener( "touch" , onBtnBackPress )

    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

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
    display.remove( sceneGroup )
    display.remove( object )



    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end

-- Events for Button back
function onBtnBackPress( event )
    composer.removeScene('src.management.settings')

    print(sceneGroup.numChildren)

    composer.gotoScene( "src.management.menu", "fade", 400)
    
end


-- Handle press events for the checkbox
local function onSwitchPress( event )
    local switch = event.target
    print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene