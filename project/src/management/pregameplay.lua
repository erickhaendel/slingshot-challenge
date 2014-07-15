-- my libs
require( "src.infra.includeall" )
local configuration = require( "src.management.configuration" )


-- Require the widget library
local widget = require( "widget" );

display.setStatusBar( display.HiddenStatusBar )     -- hide status bar

-- Determine if running on Corona Simulator
--
local isSimulator = "simulator" == system.getInfo("environment")
if system.getInfo( "platformName" ) == "Mac OS X" then isSimulator = false; end

-- Determine the platform type
-- "iPhoneOS" or "Android" or "Mac OS X"
--
local isAndroid = "Android" == system.getInfo("platformName")

-- Note: currently this feature works in device builds or Xcode simulator builds only (also works on Corona Mac Simulator)
local isAndroid = "Android" == system.getInfo("platformName")
local inputFontSize = 18
local inputFontHeight = 30
tHeight = 30

if isAndroid then
    -- Android text fields have more chrome. It's either make them bigger, or make the font smaller.
    -- We'll do both
    inputFontSize = 14
    inputFontHeight = 42
    tHeight = 40
end
    
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local  btnBack, btnPlay, btnTest
local ipField, player2IP
-- Metodos
local onBtnBackEvent, onBtTestEvent, onBtnPlayEvent

-- You could also assign different handlers for each textfield

local function fieldHandler( textField )
    return function( event )
        if ( "began" == event.phase ) then
            -- This is the "keyboard has appeared" event
            -- In some cases you may want to adjust the interface when the keyboard appears.
        
        elseif ( "ended" == event.phase ) then
            -- This event is called when the user stops editing a field: for example, when they touch a different field
            
        elseif ( "editing" == event.phase ) then
        
        elseif ( "submitted" == event.phase ) then
            -- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
            print( textField().text )
            
            -- Hide keyboard
            native.setKeyboardFocus( nil )
        end
    end
end

local function networkListener( event )
    if ( event.isError ) then
        ipField.text = "Network error!"
    else
        ipField.text = "See Corona Terminal for response"
        print ( "RESPONSE: " .. event.response )
    end
end

local function removeObject(object, group)
	if group then group:remove( object ); end
  	if object then object = nil; end 
end

-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view

    -- Create elements
    -- Background & box  welcome
    local background = display.newImage( "resources/images/backgrounds/menu.png", display.contentCenterX , display.contentCenterY , true )
    local popup = display.newImage( "resources/images/backgrounds/popup.png", display.contentCenterX , display.contentCenterY , true )

    local options = 
    {
        --parent = textGroup,
        text = "Digite o IP do Player 2: ",     
        x = display.contentCenterX - 250,
        y = display.contentCenterY - 50,
        width = 300,     --required for multi-line and alignment
        font = native.systemFontBold,   
        fontSize = 28,
        align = "right"  --new alignment parameter
    }
    local player2IP = display.newText(options)
    player2IP:setFillColor( 0, 0, 0 )

    local ipField = native.newTextField( display.contentCenterX + 50, display.contentCenterY - 50, 180, tHeight )
    ipField.font = native.newFont( native.systemFontBold, inputFontSize )
    ipField:addEventListener( "userInput", fieldHandler( function() return ipField end ) ) 

    btnTest = display.newImage( "resources/images/buttons/test.png", display.contentCenterX + 300 , display.contentCenterY - 50, true  )

    btnBack = display.newImage( "resources/images/buttons/back.png", display.contentCenterX  - 250, display.contentCenterY + 200, true  )

    btnPlay = display.newImage( "resources/images/buttons/play-small.png", display.contentCenterX + 250, display.contentCenterY + 200, true  )

    network.request( "http://127.1.1.1", "GET", networkListener )


    --Insert elements to scene
    sceneGroup:insert( background ) -- insert background to group
    sceneGroup:insert( popup ) -- insert background to group
    sceneGroup:insert( btnPlay ) 
    sceneGroup:insert( btnBack ) 
    sceneGroup:insert( btnTest ) 
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then

        -- Eventos
        btnPlay:addEventListener( "touch" , onBtnPlayEvent )
        btnTest:addEventListener( "touch" , onBtnTestEvent )
        btnBack:addEventListener( "touch" , onBtnBackEvent )

    end
end


-- "scene:hide()"
function scene:hide( event )
    removeAll()
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
    removeObject( background , sceneGroup)  -- destroi imagem de fundo
    removeObject( btnPlay , sceneGroup)  -- destroi botao back
    removeObject( btnTest , sceneGroup)  -- destroi botao
    removeObject( btnBack , sceneGroup)  -- destroi botao
end

-- Events for Button Play
function onBtnPlayEvent( event )
    removeAll()
    composer.removeScene('src.management.menu')
    composer.gotoScene( "src.gameplay.game", "fade", 400)
    print( "lets play" )
end

-- Events for Button Credits
function onBtnBackEvent( event )
    removeAll()
    composer.removeScene('src.management.menu')
    composer.gotoScene( "src.management.credits", "fade", 400)
end

-- Events for Button About
function onBtnTestEvent( event )

end

-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene