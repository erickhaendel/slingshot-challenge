require( "src.infra.includeall" )
local configuration = require( "src.gameplay.configuration" )

local background, btnMenu

-- Events for Button Visitor
function btnBackEvent( event )
    composer.removeScene('src.gameplay.results')	
	composer.gotoScene( "src.management.menu", "slideLeft", 400 )
end

local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	background = display.newImageRect( "resources/images/backgrounds/results.png",  display.contentCenterX , display.contentCenterY   )

	btnMenu = display.newImage( "resources/images/buttons/back.png", display.contentCenterX , display.contentCenterY , true  )

	configuration.game_score_player[1] = 0 	
	configuration.game_score_player[2] = 0 	
	configuration.game_final_score_player[1] = 0 	
	configuration.game_final_score_player[2] = 0 
	configuration.game_turn = 1 					
	configuration.game_current_round = 1 			
	configuration.game_total_rounds = 1 	

	--Insert elements to scene
	sceneGroup:insert( background )
	sceneGroup:insert( btnMenu )	

	audio.stop(1)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

    elseif ( phase == "did" ) then

        btnMenu:addEventListener( "touch" , btnBackEvent )

    end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
	elseif phase == "did" then
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
end



-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene