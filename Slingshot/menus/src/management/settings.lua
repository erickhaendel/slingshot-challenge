-- Imports
local composer = require( "composer" )
local widget = require( "widget" )

local util =  require( "src.infra.util" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local sceneGroup , background
local btnBack, onOffSwitch
-- Metodos
local removeAll, onBtnBackPress, onSwitchPress

-- "scene:create()"
function scene:create( event )
     sceneGroup = self.view

    -- Create elements
    -- Background & box  welcome
    background = display.newImage( "resources/images/backgrounds/settings.png", display.contentCenterX , display.contentCenterY , true )
    -- Buttons
    btnBack     = display.newImage( "resources/images/buttons/back.png",  200, ( display.contentHeight - 100) , true  )
    -- Create the widget
    onOffSwitch = widget.newSwitch
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
  --  removeAll()
    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
    end
end


function removeAll( sceneGroup )
    util.removeObject( background , sceneGroup)  -- destroi imagem de fundo

    btnBack:removeEventListener( "touch" , onBtnBackPress )
    util.removeObject( btnBack , sceneGroup)  -- destroi botao back
    
    util.removeObject( onOffSwitch , sceneGroup)  -- destroi botao
end

-- "scene:destroy()"
function scene:destroy( event )
    local sceneGroup = self.view
    removeAll( sceneGroup )
end
 
-- Events for Button back
function onBtnBackPress( event )
    composer.removeScene('src.management.settings')
    composer.gotoScene( "src.management.menu", "fade", 400)
end


-- Handle press events for the checkbox
local function onSwitchPress( event )
    local switch = event.target
end

-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene