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

    local sceneGroup = self.view

    -- Create elements
   	-- Background & box  welcome
    --local boxWelcome = display.newImage( "resources/images/backgrounds/welcome.png", display.contentCenterX , display.contentCenterY , true )
     local boxWelcome = display.newImageRect( "resources/images/backgrounds/welcome.png",  display.contentWidth  ,  display.contentHeight  )

     print( boxWelcome.width)
     print( display.contentWidth )

     boxWelcome.x , boxWelcome.y =  display.contentCenterX , display.contentCenterY 
    
    -- Buttons
    btnX = display.contentCenterX / 2 
    btnY = ( display.contentCenterY  + display.contentCenterY / 2 ) 
    
    btnVisitor = display.newImage( "resources/images/buttons/visitor.png", btnX , btnY , true  )
    btnSignup = display.newImage( "resources/images/buttons/signup.png", btnX + display.contentCenterX , btnY , true  )



    --Insert elements to scene
    sceneGroup:insert( boxWelcome ) -- inserindo o box welcome
    sceneGroup:insert( btnVisitor ) -- inserindo o button visitor
    sceneGroup:insert( btnSignup ) -- inserindo o button signup

end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then

    	-- Eventos
        btnVisitor:addEventListener( "touch" , btnVisitorEvent )
        btnSignup:addEventListener( "touch" ,  btnSignupEvent )

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


-- Events for Button Visitor
function btnVisitorEvent( event )
	composer.gotoScene( "src.management.menu", "slideLeft", 400 )
end

-- Events for Button Signup
function btnSignupEvent( event )
	composer.gotoScene( "src.management.menu", "fade", 400 )
end





-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene