local composer = require( "composer" )
local util =  require( "src.infra.util" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local  btnSettings , btnPlay, btnCredits, btnAbout
-- Metodos
local onBtnAboutEvent, onBtnCreditsEvent, onBtnPlayEvent, onBtnPlayEvent



-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view

    -- Create elements
    -- Background & box  welcome
    local background = display.newImage( "resources/images/backgrounds/menu.png", display.contentCenterX , display.contentCenterY , true )
    -- Buttons
    btnX = display.contentCenterX / 2  + display.contentCenterX + 100
    btnY = ( display.contentCenterY  ) 
    btnPlay     = display.newImage( "resources/images/buttons/play.png", display.contentCenterX / 2  , display.contentCenterY / 2  + display.contentCenterY , true  )
    btnSettings = display.newImage( "resources/images/buttons/settings.png", btnX , btnY + 100, true  )
    btnAbout    = display.newImage( "resources/images/buttons/about.png", btnX , btnY + 200, true  )
    btnCredits  = display.newImage( "resources/images/buttons/credits.png", btnX , btnY + 300, true  )

    --Insert elements to scene
    sceneGroup:insert( background ) -- insert background to group
    sceneGroup:insert( btnPlay ) 
    sceneGroup:insert( btnAbout ) 
    sceneGroup:insert( btnCredits ) 
    sceneGroup:insert( btnSettings )

end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then

        -- Eventos
        btnSettings:addEventListener( "touch" , onBtnSettingsEvent )
        btnCredits:addEventListener( "touch" , onBtnCreditsEvent )
        btnAbout:addEventListener( "touch" , onBtnAboutEvent )

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
    removeAll()
end


function removeAll( sceneGroup )
    util.removeObject( background , sceneGroup)  -- destroi imagem de fundo
    util.removeObject( btnPlay , sceneGroup)  -- destroi botao back
    util.removeObject( btnCredits , sceneGroup)  -- destroi botao
    util.removeObject( btnAbout , sceneGroup)  -- destroi botao
    util.removeObject( btnSettings , sceneGroup)  -- destroi botao
    util.removeObject( onOffSwitch , sceneGroup)  -- destroi botao
end

-- Events for Button Play
function onBtnPlayEvent( event )
    -- body
end

-- Events for Button Play
function onBtnCreditsEvent( event )
    composer.gotoScene( "src.management.credits", "fade", 400)
end

-- Events for Button Play
function onBtnAboutEvent( event )
    composer.removeScene('src.management.menu')
    composer.gotoScene( "src.management.about", "fade", 400)
end

-- Events for Button Play
function onBtnSettingsEvent( event )
    if( event.phase == "began") then
        composer.removeScene('src.management.menu')
        composer.gotoScene( "src.management.settings", "fade", 400)
    end
end

-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

local function checkMemory()
   collectgarbage( "collect" )
   local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
   print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
timer.performWithDelay( 1000, checkMemory, 0 )

return scene