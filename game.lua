-------------------------------------------
-- LIBs
-------------------------------------------
require( "includeall" )

-------------------------------------------
-- Local gameplay Variables
-------------------------------------------
display.setStatusBar( display.HiddenStatusBar )
physics.start()

local scene       = storyboard.newScene()
local centerX     = display.contentCenterX
local centerY     = display.contentCenterY
local _W          = display.contentWidth
local _H          = display.contentHeight
local ballInPlay  = false

slingshotPositionX = -100
slingshotPositionY = 300
offset_left_slingshot = 26
offset_right_slingshot = 50
offset_up_slingshot = 65
offset_down_slingshot = 52

-- Create master display group (for global "camera" scrolling effect)
local game = display.newGroup()
game.x = 0

local force_multiplier = 30

local boingSound, knockSound, squishSound

local sky, sky2, grass, grass2, wall1, slingshot, slingshot_player1, slingshot_player2, boulder

local cans, canBody, myLine, myLineBack, scoreDisplay, turnDisplay

-----------------------------------------
-- Prototype Functions
-----------------------------------------

local criaCenario, removeCenario, projectileTouchListener, startListening, onCanCollision, 
  moveCamera, newRound, resetBoulder, unloadCans, loadCans


unloadCans = function()
  if cans[1]        then game:remove( cans[1] ); cans[1] = nil; end 
  if cans[2]        then game:remove( cans[2] ); cans[2] = nil; end 
  if cans[3]        then game:remove( cans[3] ); cans[3] = nil; end 
  if cans[4]        then game:remove( cans[4] ); cans[4] = nil; end 
  if cans[5]        then game:remove( cans[5] ); cans[5] = nil; end 
  if cans[6]        then game:remove( cans[6] ); cans[6] = nil; end  
end

loadCans = function()

  canBody = { density=0.9, friction=0.8, bounce=0.6 }  
  cans = {}
  cans[1] = movieclip.newAnim{ templateGameplaySodaCanFile, templateGameplaySodaCanSmashed1File }
  cans[2] = movieclip.newAnim{ templateGameplaySodaCanFile, templateGameplaySodaCanSmashed2File }
  cans[3] = movieclip.newAnim{ templateGameplaySodaCanFile, templateGameplaySodaCanSmashed1File }
  cans[4] = movieclip.newAnim{ templateGameplaySodaCanFile, templateGameplaySodaCanSmashed2File }
  cans[5] = movieclip.newAnim{ templateGameplaySodaCanFile, templateGameplaySodaCanSmashed1File }
  cans[6] = movieclip.newAnim{ templateGameplaySodaCanFile, templateGameplaySodaCanSmashed2File }

  cans[1].x = slingshot.x + 510; cans[1].y = 280; cans[1].id = "can1"
  cans[2].x = slingshot.x + 534; cans[2].y = 280; cans[2].id = "can2"
  cans[3].x = slingshot.x + 560; cans[3].y = 280; cans[3].id = "can3"
  cans[4].x = slingshot.x + 522; cans[4].y = 240; cans[4].id = "can4"
  cans[5].x = slingshot.x + 546; cans[5].y = 240; cans[5].id = "can5"
  cans[6].x = slingshot.x + 534; cans[6].y = 200; cans[6].id = "can6"                                          

  game:insert( cans[1] )
  game:insert( cans[2] )
  game:insert( cans[3] )
  game:insert( cans[4] )
  game:insert( cans[5] )
  game:insert( cans[6] )

  physics.addBody( cans[1], canBody )
  physics.addBody( cans[2], canBody )
  physics.addBody( cans[3], canBody )
  physics.addBody( cans[4], canBody )
  physics.addBody( cans[5], canBody )
  physics.addBody( cans[6], canBody )
end

criaCenario = function()

  -------------------------------------------
  -- Graphic Files
  -------------------------------------------
  sky     = display.newImage( templateGameplaySkyFile, 160, 160, true )
  sky2    = display.newImage( templateGameplaySkyFile, 1120, 160, true )
  grass   = display.newImage( templateGameplayGrassFile, 160, 440, true )
  grass2  = display.newImage( templateGameplayGrassFile, 1120, 440, true )
  stone   = display.newImage( templateGamePlaySlingshotBaseFile, slingshotPositionX + 10, slingshotPositionY + 70, true )

  -------------------------------------------
  -- Audio Files
  -------------------------------------------

  -- first, create the image sheet object
local SlingshotImageOptions =
{
    -- The params below are required

    width = 100,
    height = 100,
    numFrames = 2,

    -- The params below are optional; used for dynamic resolution support

    sheetContentWidth = 600,  -- width of original 1x size of entire sheet
    sheetContentHeight = 600  -- height of original 1x size of entire sheet
}

  local isChannel1Playing = audio.isChannelPlaying( 1 )
  if isChannel1Playing then
     audio.pause( 1 )
  end

  if player1_slingshot_color == 0 then -- blue
    local imageSheet = graphics.newImageSheet( templateGameplayBlueSlingshotFile, SlingshotImageOptions )
    slingshot_player1 = display.newImage(imageSheet, 2 )
  elseif player1_slingshot_color == 1 then -- green
    local imageSheet = graphics.newImageSheet( templateGameplayGreenSlingshotFile, SlingshotImageOptions )    
    slingshot_player1 = display.newImage(imageSheet, 2)
  end
  slingshot_player1.x = -2000
  slingshot_player1.y = -2000

  local p2rand = math.random(2)

  if p2rand == 1 then
    player2_slingshot_color = 0
  else
    player2_slingshot_color = 1
  end  

  if player2_slingshot_color == 0 then -- yellow
    slingshot_player2 = display.newImage(templateGameplayBlueSlingshotFile, true)
  elseif player2_slingshot_color == 1 then -- green
    slingshot_player2 = display.newImage(templateGameplayGreenSlingshotFile, true)
  end
  slingshot_player2.x = -2000
  slingshot_player2.y = -2000

  slingshot = slingshot_player1

  slingshot.x = slingshotPositionX
  slingshot.y = slingshotPositionY

  boulder = display.newImage( templateGameplayBoulderFile )
  boulder.x = slingshotPositionX
  boulder.y = slingshotPositionY
  
  wall1   = display.newImage( templateGameplayWallFile )
  wall1.x = slingshot.x + 532; wall1.y = 350
  
  ------------------------------------------
  -- Objects
  --------------------------------------------

  myLine = display.newLine(boulder.x, boulder.y, slingshot.x + offset_left_slingshot, slingshot.y - offset_up_slingshot)
  myLineBack = display.newLine(boulder.x, boulder.y, slingshot.x - offset_right_slingshot,  slingshot.y - offset_down_slingshot);

  myLine:setStrokeColor(243,207,134); 
  myLine.strokeWidth = 2
  myLineBack:setStrokeColor(214,184,130); 
  myLineBack.strokeWidth = 3  

  scoreDisplay = display.newText( "Player 1: "..player1_score.."\nPlayer2: "..player2_score, 0, 0, templateDefaultFont, templateGameplayScoreSizefont )
  scoreDisplay.anchorX = 1; 
  scoreDisplay.x = display.contentWidth - 25; 
  scoreDisplay.y = 40 

  turnDisplay = display.newText( "Turn: "..turn, 0, 0, templateDefaultFont, templateGameplayScoreSizefont )
  turnDisplay.anchorX = 1; 
  turnDisplay.x = display.contentWidth - 250; 
  turnDisplay.y = 40 

  -- SETTING THE OBJECTS
  Runtime:addEventListener( "touch", projectileTouchListener ) 
  Runtime:removeEventListener( "enterFrame", moveCamera )

  -- INSERT OBJECTS
  game:insert( sky )
  game:insert( sky2 )
  game:insert( grass )
  game:insert( grass2 ) 
  game:insert( stone )  
  game:insert( wall1 )
  game:insert( myLine )
  game:insert( myLineBack )
  game:insert( boulder )
  game:insert( scoreDisplay )
  game:insert( turnDisplay )
  game:insert( slingshot )
  loadCans()

  -- PHYSICS 
  physics.addBody( grass, "static", { friction=0.5, bounce=0.3 } )
  physics.addBody( grass2,"static", { friction=0.5, bounce=0.3 } )
  physics.addBody( wall1, "static", { friction=0.5 } )

  physics.addBody( boulder, { density=12.0, friction=0.5, bounce=0.2, radius=9 } )  
  transition.to( boulder, {time=600, y=_H - 140, transition = easingx.easeOutElastic})
end
-------------------------------------------
-- Tratamento de Eventos
-------------------------------------------
projectileTouchListener = function(e)

  if ( not ballInPlay ) and ( e.phase == "began" ) then
    ballInPlay = true
    startListening()
  end

  if(e.phase == "began") then
    display.getCurrentStage():setFocus( boulder );
    boulder.isFocus = true;
    boulder.bodyType = "kinematic";
    boulder.angularVelocity = 0
    boulder:setLinearVelocity(0,0)

    local stretchChannel = audio.play( stretchSound )        

    
    local myLine = nil;
    local myLineBack = nil;
    
  elseif(boulder.isFocus) then

    if(e.phase == "moved") then


      if(myLine) then
        myLine.parent:remove(myLine); 
        myLineBack.parent:remove(myLineBack); 
        myLine = nil;
        myLineBack = nil;
      end

      boulder.x = e.x
      boulder.y = e.y

      if e.y >= 390 then
        boulder.y = 390
      end   

      if e.y < 250 then
        boulder.y = 250
      end 

      if e.x >= slingshot.x then
        boulder.x = slingshot.x
      end
   
      if e.x < slingshot.x - 50 then
        boulder.x = slingshot.x - 50
      end 

        -- If the projectile is in the top left position
        if(e.x < boulder.x - 25 and e.y < boulder.y)then
          myLineBack = display.newLine(boulder.x - 10, boulder.y, slingshot.x - 10, slingshot.y - 30)
          myLine = display.newLine(boulder.x - 10, boulder.y, slingshot.x + 10, slingshot.y - 30)          
        -- If the projectile is in the top right position
        elseif(e.x > boulder.x - 25 and e.y < boulder.y)then
          myLineBack = display.newLine(boulder.x + 30, boulder.y - 25, slingshot.x - 10, slingshot.y - 30)
          myLine = display.newLine(boulder.x + 30, boulder.y - 25, slingshot.x + 10, slingshot.y - 30)           
        -- If the projectile is in the bottom left position
        elseif(e.x < boulder.x - 25 and e.y > boulder.y)then
          myLineBack = display.newLine(boulder.x - 5, boulder.y + 20, slingshot.x - 10, slingshot.y - 30)
          myLine = display.newLine(boulder.x - 5, boulder.y + 20, slingshot.x + 10, slingshot.y - 30)           
        -- If the projectile is in the bottom right position
        elseif(e.x > boulder.x - 25 and e.y > boulder.y)then
          myLineBack = display.newLine(boulder.x + 5, boulder.y + 30, slingshot.x - 10, slingshot.y - 30)
          myLine = display.newLine(boulder.x + 5, boulder.y + 30, slingshot.x + 10, slingshot.y - 30)           
        else
        -- Default position (just in case).
          myLineBack = display.newLine(boulder.x - 5, boulder.y, slingshot.x - 10, slingshot.y - 30)
          myLine = display.newLine(boulder.x - 5, boulder.y, slingshot.x + 10, slingshot.y - 30)
        end

      -- Set the elastic band's visual attributes
      myLineBack.strokeWidth = 2;
      myLine.strokeWidth = 3;
                
    elseif(e.phase == "ended" or e.phase == "cancelled") then

      Runtime:removeEventListener("touch", projectileTouchListener)
      if turn == 1 or turn == 2 then
        Runtime:addEventListener( "enterFrame", moveCamera )
      else
        Runtime:removeEventListener("enterFrame", moveCamera)      
      end

      local bandReleaseChannel = audio.play( bandReleaseSound )          

  		display.getCurrentStage():setFocus(nil)
  		boulder.isFocus = false

  		if(myLine) then
  			myLine.parent:remove(myLine); -- erase previous line
  			myLineBack.parent:remove(myLineBack); -- erase previous line
  			myLine = nil;
  			myLineBack = nil;
  		end

  		boulder.bodyType = "dynamic";
  		boulder:applyForce((slingshot.x - boulder.x)*force_multiplier, (slingshot.y - boulder.y)*force_multiplier, boulder.x, boulder.y);
  		boulder:applyTorque( 100 )
  		boulder.isFixedRotation = false;
                
  		-- Wait a second before the catapult is reloaded (Avoids conflicts).
	 	boulder.timer = timer.performWithDelay(4000, 
          function(e)
            		if(e.count == 1) then
            		  timer.cancel(boulder.timer);
            			boulder.timer = nil;

                  -- player 1
                  if turn == 1 then
                    player1_shoot = player1_shoot + 1
                    if player1_shoot < max_shoot then
                      newRound()
                    else

                      if slingshot then game:remove( slingshot ); slingshot = nil; end 

                      slingshot = slingshot_player2
                      slingshot.x = slingshotPositionX
                      slingshot.y = slingshotPositionY
                      game:insert( slingshot )

                      unloadCans()

                      loadCans()

                      turn = 2
                      newRound()                      
                    end   
                  -- player 2   
                  elseif turn == 2 then
                    player2_shoot = player2_shoot + 1
                    if player2_shoot < max_shoot then
                      newRound()
                    else
                      turn = 3                      
                      game.x = 0
                      Runtime:removeEventListener( "touch", projectileTouchListener ) 
                      Runtime:removeEventListener( "enterFrame", moveCamera )
                      Runtime:removeEventListener("collision", onCollision)
                      
                      ballInPlay = false
                      removeCenario()
                      storyboard.gotoScene( "finalscore" ) 
                    end      
                  elseif turn == 3 then
                   
                  end

            		end   
          end, 1)
  end

  end
end

------------------------------------------------------------
-- Add collision listeners to can

startListening = function()
  -- if can1 has a postCollision property then we've already started listening
  -- so return immediately
  if cans[1].postCollision then return; end
  if cans[2].postCollision then return; end
  if cans[3].postCollision then return; end
  if cans[4].postCollision then return; end
  if cans[5].postCollision then return; end
  if cans[6].postCollision then return; end
  
  onCanCollision = function( self, event )
  
    -- Crack this can if collision force is high enough
    if ( event.force > 1.0 ) then
      self:stopAtFrame(2)
      
--      local availableChannel = audio.findFreeChannel()
--      audio.play( squishSound, { channel=availableChannel } )

      if turn == 1 then
        player1_score = player1_score + 15
        scoreDisplay.text = "Player1: " .. player1_score
        turnDisplay.text = "Turn: Player 1"
      elseif turn == 2 then 
        player2_score = player2_score + 15
        scoreDisplay.text = "Player 2: ".. player2_score
        turnDisplay.text = "Turn: Player 2"        
      elseif turn == 3 then
        turnDisplay.text = "Turn: Player 3"
      end 

      -- After this can cracks, it can ignore further collisions
      self:removeEventListener( "postCollision", self )
    end
  end
  
  -- Set table listeners in each egg to check for collisions
  
  cans[1].postCollision = onCanCollision
  cans[1]:addEventListener( "postCollision", cans[1] )
  cans[2].postCollision = onCanCollision
  cans[2]:addEventListener( "postCollision", cans[2] )
  cans[3].postCollision = onCanCollision
  cans[3]:addEventListener( "postCollision", cans[3] )
  cans[4].postCollision = onCanCollision
  cans[4]:addEventListener( "postCollision", cans[4] )
  cans[5].postCollision = onCanCollision
  cans[5]:addEventListener( "postCollision", cans[5] )
  cans[6].postCollision = onCanCollision
  cans[6]:addEventListener( "postCollision", cans[6] )  
end

-------------------------------------------
-- Methods
-------------------------------------------

moveCamera = function() 

  if turn == 1 or turn == 2 then
    if boulder then
      if (boulder.x > 80 and boulder.x < 1000) then
        game.x = -boulder.x + 80
      end
    end
  else
    Runtime:removeEventListener("enterFrame", moveCamera)      
  end
end

resetBoulder = function()
	boulder.bodyType = "kinematic"
  boulder.x = slingshotPositionX
  boulder.y = slingshotPositionY
	boulder:setLinearVelocity( 0, 0 ) -- stop boulder moving
	boulder.angularVelocity = 0 -- stop boulder rotating
	physics.addBody( boulder,  "kinematic", { density=15.0, friction=0.5, bounce=0.2, radius=9 } )
	transition.to( boulder, {time=600, y=slingshot.y-30, transition = easingx.easeOutElastic});

	if(myLine) then
		myLine.parent:remove(myLine); -- erase previous line
		myLineBack.parent:remove(myLineBack); -- erase previous line
		myLine = nil;
		myLineBack = nil;
	end 
	Runtime:addEventListener("touch", projectileTouchListener);  
end

newRound = function( event )

  transition.to(game, {time=600, x=0, transition = easingx.easeOutElastic});

	resetBoulder()
	ballInPlay = false
	return true
end

removeCenario = function()

  if sky            then game:remove( sky ); sky = nil; end  
  if sky2           then game:remove( sky2 ); sky2 = nil; end  
  if grass          then game:remove( grass ); grass = nil; end  
  if grass2         then game:remove( grass2 ); grass2 = nil; end  
  if stone          then game:remove( stone ); stone = nil; end    
  if slingshot      then game:remove( slingshot ); slingshot = nil; end  
  if wall1          then game:remove( wall1 ); wall1 = nil; end  
  if myLine         then game:remove( myLine ); myLine = nil; end  
  if myLineBack     then game:remove( myLineBack ); myLineBack = nil; end 
  if cans[1]        then unloadCans(); end 
  if boulder        then game:remove( boulder ); boulder = nil; end     
	if scoreDisplay   then game:remove( scoreDisplay ); scoreDisplay = nil; end 
  if turnDisplay    then game:remove( turnDisplay ); turnDisplay = nil; end     
end

------------------------------------------------------------

-- Handler that gets notified when the alert closes
local function onComplete( event )
    if "clicked" == event.action then
        local i = event.index
        if 1 == i then
                -- Do nothing; dialog will simply dismiss
        end
    end
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
  criaCenario()
  resetBoulder()
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )

end

-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
  removeCenario()
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene