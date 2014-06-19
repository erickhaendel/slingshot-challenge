local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local btnVisitor -- type newImage
local btnSignup  -- type newImage

-- "scene:create()"
function scene:create( event )
    print("erick")
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
        btnSettings:addEventListener( "touch" , btnSettingsEvent )
        btnCredits:addEventListener( "touch" , btnCreditsEvent )
        btnAbout:addEventListener( "touch" , btnAboutEvent )

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

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end

-- Events for Button Play
function btnPlayEvent( event )
    -- body
end

-- Events for Button Play
function btnCreditsEvent( event )
    composer.gotoScene( "src.management.credits", "slideLeft", 400)
end

-- Events for Button Play
function btnAboutEvent( event )
   composer.gotoScene( "src.management.about", "slideLeft", 400)
end

-- Events for Button Play
function btnSettingsEvent( event )
      composer.removeScene('src.management.menu')
    composer.gotoScene( "src.management.settings", "slideLeft", 400)
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------



return scene