local composer = require( "composer" )
local util =  require( "src.infra.util" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local sceneGroup , background
local btnBack

-- Metodos
local removeAll, onBtnBackPress

-- "scene:create()"
function scene:create( event )
    
    local sceneGroup = self.view

    -- Create elements
    -- Background & box  welcome
    background = display.newImage( "resources/images/backgrounds/about.png", display.contentCenterX , display.contentCenterY , true )
    -- Buttons
    btnBack     = display.newImage( "resources/images/buttons/back.png",  200, ( display.contentHeight - 100) , true  )

    --Insert elements to scene
    sceneGroup:insert( background ) -- insert background to group
    sceneGroup:insert( btnBack )


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


function removeAll( sceneGroup )
    util.removeObject( background , sceneGroup)  -- destroi imagem de fundo

    btnBack:removeEventListener( "touch" , onBtnBackPress )
    util.removeObject( btnBack , sceneGroup)  -- destroi botao back
end

-- "scene:destroy()"
function scene:destroy( event )
    local sceneGroup = self.view
    removeAll()
end


-- Events for Button back
function onBtnBackPress( event )
    composer.removeScene('src.management.credits')
    composer.gotoScene( "src.management.menu", "fade", 400)
end

-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene