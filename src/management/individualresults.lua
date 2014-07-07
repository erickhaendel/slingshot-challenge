local composer = require( "composer" )
local configuration       = require( "src.gameplay.configuration" )
-- local util =  require( "src.infra.util" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local function removeObject(object, group)
	if group then group:remove( object ); end
  	if object then object = nil; end 
end

local sceneGroup , background
local btncontinue , btnAgain
local scorePlayer1 , scorePlayer2, scoreTotal



-- Metodos
local removeAll, onBtnBackPress, onBtnAgainPress

-- "scene:create()"
function scene:create( event )
    
    local sceneGroup = self.view

    -- Create elements
    -- Background & box  welcome
    background = display.newImage( "resources/images/backgrounds/individualresults.png", display.contentCenterX , display.contentCenterY, true )
    -- Buttons
    btncontinue     = display.newImage( "resources/images/buttons/continue.png",  display.contentCenterX + 75, ( display.contentCenterY + 325) , true  )
    

    -- Texto mostrando os resultados
    --Falta colocar a variavel responsavel pela contagem dos pontos.
    scorePlayer1 = display.newText( configuration.game_final_score_player[1], display.contentCenterX - 400, display.contentCenterY+130, "Arial" , 30 )
    scorePlayer2 = display.newText( configuration.game_final_score_player[2], display.contentCenterX + 420, display.contentCenterY+130, "Arial" , 30 )
    scoreTotal = display.newText( "Total = "..(configuration.game_final_score_player[1]+configuration.game_final_score_player[2]), display.contentCenterX + 50, display.contentCenterY + 250, "Arial", 35 )

    --Insert elements to scene
    -- a ordem de inserçao no grupo eh a ordemm da "tela"
    sceneGroup:insert( background ) -- insert background to group
    sceneGroup:insert( btncontinue )
    sceneGroup:insert(scorePlayer1)
    sceneGroup:insert( scorePlayer2)
    sceneGroup:insert( scoreTotal )

end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Eventos
        btncontinue:addEventListener( "touch" , onBtncontinuePress )
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
    removeObject( background , sceneGroup)  -- destroi imagem de fundo
    removeObject( btncontinue , sceneGroup)  -- destroi botao back
    removeObject(scorePlayer1)
    removeObject(scorePlayer2)
    removeObject(scoreTotal)
end

-- "scene:destroy()"
function scene:destroy( event )
    local sceneGroup = self.view
    removeAll()
end


-- Events for Button back
function onBtncontinuePress( event )
    composer.removeScene('src.management.individualresults')
    composer.gotoScene('src.management.menu', "fade", 400)
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene
