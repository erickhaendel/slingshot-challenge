-- BEGINNING THE FACEBOOK CONFIGURATION AND METHODS -----------------------------------------------
---------------------------------------------------------------------------------------------------
appId  = "721867974520857" -- Add  your App ID here (also go into build.settings under CFBundleURLSchemes)
apiKey = "6ab52894d2688b127634566f28fe2272" -- Not needed at this time
---------------------------------------------------------------------------------------------------

facebookListener = function( event )

  if ( "request" == event.type ) then
      local str = json.decode( event.response )
      player_name =  str["first_name"]
--      local alert = native.showAlert( "Corona",  str["first_name"], { "OK" } )
      if greetingsLabel     then labels:remove( greetingsLabel ); greetingsLabel = nil; end
      if not greetingsLabel then carregaGreetingsLabel();  end 
  end
end

if facebook_login_mode == "on" then
  if ( appId ) then
      facebook.login( appId, facebookListener, {"publish_actions"}  )
  --    facebook.request( "me", "GET", { fields="id,name" } )
      facebook.request( "me" )
  end
end
