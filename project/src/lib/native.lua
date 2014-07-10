local composer  = require("composer")

local function onKeyEvent( event )

   local phase = event.phase
   local keyName = event.keyName
   print( event.phase, event.keyName )

   native.showAlert( "OI",  event.keyName  )

   if ( "back" == keyName and phase == "up" ) then
      if ( composer.currentScene == "splash" ) then
         native.requestExit()
      else
         if ( composer.isOverlay ) then
            composer.hideOverlay()
         else
            local lastScene = composer.returnTo
            print( "previous scene", lastScene )
            if ( lastScene ) then
               composer.gotoScene( lastScene, { effect="crossFade", time=500 } )
            else
               native.requestExit()
            end
         end
      end
   end

   if ( keyName == "volumeUp" and phase == "down" ) then
      local masterVolume = audio.getVolume()
      print( "volume:", masterVolume )
      if ( masterVolume < 1.0 ) then
         masterVolume = masterVolume + 0.1
         audio.setVolume( masterVolume )
      end
      return true
   elseif ( keyName == "volumeDown" and phase == "down" ) then
      local masterVolume = audio.getVolume()
      print( "volume:", masterVolume )
      if ( masterVolume > 0.0 ) then
         masterVolume = masterVolume - 0.1
         audio.setVolume( masterVolume )
      end
      return true
   end
   return false  --SEE NOTE BELOW
end

--add the key callback
Runtime:addEventListener( "key", onKeyEvent )