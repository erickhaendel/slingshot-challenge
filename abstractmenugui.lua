module(..., package.seeall)

-------------------------------------------
-- LIBs
-------------------------------------------
require( "template" )
require( "globaldefinitions" )

-------------------------------------------
-- GROUPS
-------------------------------------------

menuButtonsGroup  = display.newGroup()
menuLabelsGroup   = display.newGroup()
menuImagesGroup   = display.newGroup()

-------------------------------------------
-- AUDIO GUI METHODS
-------------------------------------------

offsetAudioVolume = 0.2

----------------------------------------------------------------------
menuIncreaseVolumeButton  = nil

-- PROTOTYPE METHODS
createMenuIncreaseVolumeButton  = nil
removeMenuIncreaseVolumeButton  = nil
menuIncreaseVolumeButtonPress   = nil
loadingMenuIncreaseVolumeButton = nil

----------------------------------------------------------------------------------------
createMenuIncreaseVolumeButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuIncreaseVolumeButton then loadingMenuIncreaseVolumeButton(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuIncreaseVolumeButton = function()
  if menuIncreaseVolumeButton then menuButtonsGroup:remove( menuIncreaseVolumeButton ); menuIncreaseVolumeButton = nil; end 
end

menuIncreaseVolumeButtonPress = function( event )
  sound_mode = "on"  
  audio.setVolume( audio.getVolume( ) + offsetAudioVolume )
  audio.play( buttonSound ) 
end

loadingMenuIncreaseVolumeButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuIncreaseVolumeButton = widget.newButton 
  { 
    defaultFile = templateSmallButtonDefaultFile,
    overFile = templateSmallButtonOverFile,
    label = text,
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, }, 
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuIncreaseVolumeButtonPress, 
  }

  menuIncreaseVolumeButton.x = x
  menuIncreaseVolumeButton.y = y

  menuButtonsGroup:insert(menuIncreaseVolumeButton)
end

 ----------------------------------------------------------------------------
 
 menuDecreaseVolumeButton  = nil

-- PROTOTYPE
createMenuDecreaseVolumeButton  = nil
removeMenuDecreaseVolumeButton  = nil
menuDecreaseVolumeButtonPress   = nil
loadingMenuDecreaseVolumeButton = nil

------------------------------------------------------------
createMenuDecreaseVolumeButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuDecreaseVolumeButton then loadingMenuDecreaseVolumeButton(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuDecreaseVolumeButton = function()
  if menuDecreaseVolumeButton then menuButtonsGroup:remove( menuDecreaseVolumeButton ); menuDecreaseVolumeButton = nil; end 
end

menuDecreaseVolumeButtonPress = function( event )
  sound_mode = "on"
  audio.setVolume( audio.getVolume( ) - offsetAudioVolume )
  audio.play( buttonSound )  
end

loadingMenuDecreaseVolumeButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuDecreaseVolumeButton = widget.newButton 
  { 
    defaultFile = templateSmallButtonDefaultFile,
    overFile = templateSmallButtonOverFile,
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },  
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuDecreaseVolumeButtonPress, 
  }

  menuDecreaseVolumeButton.x = x
  menuDecreaseVolumeButton.y = y

  menuButtonsGroup:insert(menuDecreaseVolumeButton)
end

-----------------------------------------------------------------------------------------------------

menuSoundButton             = nil
menuMuteSoundButton         = nil 

-- PROTOTYPE METHODS
menuSoundButtonPress        = nil
menuMuteSoundButtonPress    = nil
loadingMenuMuteSoundButton  = nil
loadingMenuSoundButton      = nil
createMuteSoundButton       = nil
removeMuteSoundButton       = nil

-----------------------------------------------------

menuSoundButtonPress = function( event )

  audio.pause( gameMusicChannel )
  local x = menuSoundButton.x
  local y = menuSoundButton.y
  if menuSoundButton          then menuButtonsGroup:remove( menuSoundButton ); menuSoundButton = nil; end 
  if not menuMuteSoundButton  then loadingMenuMuteSoundButton(x,y, text);  end 
  sound_mode = "off"  
end

menuMuteSoundButtonPress = function( event )

  audio.resume( gameMusicChannel )
  local x = menuMuteSoundButton.x
  local y = menuMuteSoundButton.y
  if menuMuteSoundButton      then menuButtonsGroup:remove( menuMuteSoundButton ); menuMuteSoundButton = nil; end 
  if not menuSoundButton      then loadingMenuSoundButton(x,y, text);  end 
  sound_mode = "on"  
end

loadingMenuMuteSoundButton = function(x,y, text)

  if text == nil then text = ""; end

  if menuSoundButton      then menuButtonsGroup:remove( menuSoundButton ); menuSoundButton = nil; end 

  menuMuteSoundButton = widget.newButton 
  {
    defaultFile = templateMuteSoundButtonDefaultFile,
    overFile = templateMuteSoundButtonOverFile, 
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuMuteSoundButtonPress, 
  }

  menuMuteSoundButton.x = x
  menuMuteSoundButton.y = y

  menuButtonsGroup:insert(menuMuteSoundButton)
end

loadingMenuSoundButton = function(x,y, text)

  if text == nil then text = ""; end

  if menuMuteSoundButton  then menuButtonsGroup:remove( menuMuteSoundButton ); menuMuteSoundButton = nil; end  

  menuSoundButton = widget.newButton 
  {
    defaultFile = templateAllowSoundButtonDefaultFile,
    overFile = templateAllowSoundButtonOverFile, 
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuSoundButtonPress, 
  }

  menuSoundButton.x = x
  menuSoundButton.y = y

  menuButtonsGroup:insert(menuSoundButton)
end

createMuteSoundButton = function(x,y, text)
  if  sound_mode == "on" then
    if not menuSoundButton then loadingMenuSoundButton(x,y, text);  end 
  else 
    if not menuMuteSoundButton then loadingMenuMuteSoundButton(x,y, text);  end 
  end
end

removeMuteSoundButton = function()
  if menuSoundButton      then menuButtonsGroup:remove( menuSoundButton ); menuSoundButton = nil; end 
  if menuMuteSoundButton  then menuButtonsGroup:remove( menuMuteSoundButton ); menuMuteSoundButton = nil; end   
end

-------------------------------------------
-- BACK BUTTON GUI METHODS
-------------------------------------------
menuBackButton = nil

-- PROTOTYPE
createMenuBackButton      = nil
removeMenuBackButton      = nil
menuBackButtonPress       = nil
loadingMenuBackButton     = nil

-----------------------------------------------

createMenuBackButton = function(x,y,destination)
  if not menuBackButton then loadingMenuBackButton(x,y,destination);  end 
end

removeMenuBackButton = function()
  if menuBackButton then menuButtonsGroup:remove( menuBackButton ); menuBackButton = nil; end 
end

menuBackButtonPress = function( event )
  if sound_mode == "on" then
    audio.play( buttonSound )
  end

  local buttonListener = {}
  function buttonListener:timer( event )
    storyboard.gotoScene( menuBackButton.destination )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )  
end

loadingMenuBackButton = function(x,y,destination)
  menuBackButton = widget.newButton
  { 

    defaultFile = templateMediumButtonDefaultFile,
    overFile    = templateMediumButtonOverFile,
    label       = "Back",
    labelColor  = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, }, 
    font        = templateDefaultFont,
    fontSize    = templateDefaultButtonSizeFont,
    emboss      = true,
    onPress     = menuBackButtonPress,
  }

  menuBackButton.x = x
  menuBackButton.y = y

  menuButtonsGroup:insert(menuBackButton)

  menuBackButton.destination = destination -- goToScene
end

-------------------------------------------
-- ABOUT BUTTON GUI METHODS
-------------------------------------------

menuAboutButton = nil

-- PROTOTYPE
loadingMenuAboutButton    = nil
menuAboutButtonPress      = nil
createMenuAboutButton     = nil
removeMenuAboutButton     = nil

----------------------------------------------

createMenuAboutButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuAboutButton then loadingMenuAboutButton(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuAboutButton = function()
  if menuAboutButton then menuButtonsGroup:remove( menuAboutButton ); menuAboutButton = nil; end 
end

menuAboutButtonPress = function( event )
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    storyboard.gotoScene( "about" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

loadingMenuAboutButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuAboutButton = widget.newButton 
  {
    defaultFile = buttonImageDefaultFile,
    overFile = buttonImageOverFile,
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuAboutButtonPress, 
   }

  menuAboutButton.x = x
  menuAboutButton.y = y

  menuButtonsGroup:insert(menuAboutButton)
end

-------------------------------------------
-- PLAY BUTTON GUI METHODS
-------------------------------------------

menuPlayButton = nil

-- PROTOTYPE
loadingMenuPlayButton   = nil
menuPlayButtonPress     = nil
createMenuPlayButton    = nil
removeMenuPlayButton    = nil

----------------------------------------------

createMenuPlayButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuPlayButton then loadingMenuPlayButton(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuPlayButton = function()
  if menuPlayButton then menuButtonsGroup:remove( menuPlayButton ); menuPlayButton = nil; end 
end

menuPlayButtonPress = function( event )
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    storyboard.gotoScene( "choosegamemode" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

loadingMenuPlayButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuPlayButton = widget.newButton 
  {
    defaultFile = buttonImageDefaultFile,
    overFile = buttonImageOverFile,
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuPlayButtonPress, 
   }

  menuPlayButton.x = x
  menuPlayButton.y = y

  menuButtonsGroup:insert(menuPlayButton)
end

-------------------------------------------
-- SETTING BUTTON GUI METHODS
-------------------------------------------

menuSettingButton = nil

-- PROTOTYPE
loadingMenuSettingButton    = nil
menuSettingButtonPress      = nil
createMenuSettingButton     = nil
removeMenuSettingButton     = nil

----------------------------------------------

createMenuSettingButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuSettingButton then loadingMenuSettingButton(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuSettingButton = function()
  if menuSettingButton then menuButtonsGroup:remove( menuSettingButton ); menuSettingButton = nil; end 
end

menuSettingButtonPress = function( event )
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    storyboard.gotoScene( "setting" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

loadingMenuSettingButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuSettingButton = widget.newButton 
  {
    defaultFile = templateButtonDefaultFile,
    overFile = templateButtonOverFile,
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuSettingButtonPress, 
   }

  menuSettingButton.x = x
  menuSettingButton.y = y

  menuButtonsGroup:insert(menuSettingButton)
end

-------------------------------------------
-- HOWTOPLAY BUTTON GUI METHODS
-------------------------------------------

menuHowToPlayButton = nil

-- PROTOTYPE
loadingMenuHowToPlayButton    = nil
menuHowToPlayButtonPress      = nil
createMenuHowToPlayButton     = nil
removeMenuHowToPlayButton     = nil

----------------------------------------------

createMenuHowToPlayButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuHowToPlayButton then loadingMenuHowToPlayButton(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuHowToPlayButton = function()
  if menuHowToPlayButton then menuButtonsGroup:remove( menuHowToPlayButton ); menuHowToPlayButton = nil; end 
end

menuHowToPlayButtonPress = function( event )
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    storyboard.gotoScene( "howtoplay" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

loadingMenuHowToPlayButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuHowToPlayButton = widget.newButton 
  {
    defaultFile = templateButtonDefaultFile,
    overFile = templateButtonOverFile,
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuHowToPlayButtonPress, 
   }

  menuHowToPlayButton.x = x
  menuHowToPlayButton.y = y

  menuButtonsGroup:insert(menuHowToPlayButton)
end

-------------------------------------------
-- PRIVACY POLICY BUTTON GUI METHODS
-------------------------------------------

menuPrivacyPolicyButton = nil

-- PROTOTYPE
loadingMenuPrivacyPolicyButton    = nil
menuPrivacyPolicyButtonPress      = nil
createMenuPrivacyPolicyButton     = nil
removeMenuPrivacyPolicyButton     = nil

----------------------------------------------

createMenuPrivacyPolicyButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuPrivacyPolicyButton then loadingMenuPrivacyPolicyButton(x,y);  end 
end

removeMenuPrivacyPolicyButton = function()
  if menuPrivacyPolicyButton then menuButtonsGroup:remove( menuPrivacyPolicyButton ); menuPrivacyPolicyButton = nil; end 
end

menuPrivacyPolicyButtonPress = function( event )
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    storyboard.gotoScene( "privacypolicy" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

loadingMenuPrivacyPolicyButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuPrivacyPolicyButton = widget.newButton 
  {
    defaultFile = templateButtonDefaultFile,
    overFile = templateButtonOverFile,
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuPrivacyPolicyButtonPress, 
   }

  menuPrivacyPolicyButton.x = x
  menuPrivacyPolicyButton.y = y

  menuButtonsGroup:insert(menuPrivacyPolicyButton)
end

-------------------------------------------
-- LOGIN BUTTON GUI METHODS
-------------------------------------------

menuLoginButton = nil

-- PROTOTYPE
loadingMenuLoginButton    = nil
menuLoginButtonPress      = nil
createMenuLoginButton     = nil
removeMenuLoginButton     = nil

----------------------------------------------

createMenuLoginButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuLoginButton then loadingMenuLoginButton(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuLoginButton = function()
  if menuLoginButton then menuButtonsGroup:remove( menuLoginButton ); menuLoginButton = nil; end 
end

menuLoginButtonPress = function( event )
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    storyboard.gotoScene( "login" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

loadingMenuLoginButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuLoginButton = widget.newButton 
  {
    defaultFile = buttonImageDefaultFile,
    overFile = buttonImageOverFile,
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuLoginButtonPress, 
   }

  menuLoginButton.x = x
  menuLoginButton.y = y

  menuButtonsGroup:insert(menuLoginButton)
end

-------------------------------------------
-- LOGOFF BUTTON GUI METHODS
-------------------------------------------

menuLogoffButton = nil

-- PROTOTYPE
loadingMenuLogoffButton    = nil
menuLogoffButtonPress      = nil
createMenuLogoffButton     = nil
removeMenuLogoffButton     = nil

----------------------------------------------

createMenuLogoffButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuLogoffButton then loadingMenuLogoffButton(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuLogoffButton = function()
  if menuLogoffButton then menuButtonsGroup:remove( menuLogoffButton ); menuLogoffButton = nil; end 
end

menuLogoffButtonPress = function( event )
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    storyboard.gotoScene( "welcome" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

loadingMenuLogoffButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuLogoffButton = widget.newButton 
  {
    defaultFile = buttonImageDefaultFile,
    overFile = buttonImageOverFile,
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuLogoffButtonPress, 
   }

  menuLogoffButton.x = x
  menuLogoffButton.y = y

  menuButtonsGroup:insert(menuLogoffButton)
end

-------------------------------------------
-- SIGNUP BUTTON GUI METHODS
-------------------------------------------

menuSignupButton = nil

-- PROTOTYPE METHODS
loadingMenuSignupButton     = nil
menuSignupButtonPress       = nil
createMenuSignupButton      = nil
removeMenuSignupButton      = nil

----------------------------------------------

createMenuSignupButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuSignupButton then loadingMenuSignupButton(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuSignupButton = function()
  if menuSignupButton then menuButtonsGroup:remove( menuSignupButton ); menuSignupButton = nil; end 
end

menuSignupButtonPress = function( event )
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    storyboard.gotoScene( "signup" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

loadingMenuSignupButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuSignupButton = widget.newButton 
  {
    defaultFile = buttonImageDefaultFile,
    overFile = buttonImageOverFile,
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuSignupButtonPress, 
   }

  menuSignupButton.x = x
  menuSignupButton.y = y

  menuButtonsGroup:insert(menuSignupButton)
end

-------------------------------------------
-- PLAY TUTORIAL BUTTON GUI METHODS
-------------------------------------------

menuPlayTutorialButton = nil

-- PROTOTYPE
loadingMenuPlayTutorialButton   = nil
menuPlayTutorialButtonPress     = nil
createMenuPlayTutorialButton    = nil
removeMenuPlayTutorialButton    = nil

----------------------------------------------

createMenuPlayTutorialButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuPlayTutorialButton then loadingMenuPlayTutorialButton(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuPlayTutorialButton = function()
  if menuPlayTutorialButton then menuButtonsGroup:remove( menuPlayTutorialButton ); menuPlayTutorialButton = nil; end 
end

menuPlayTutorialButtonPress = function( event )
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    storyboard.gotoScene( "playtutorial" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

loadingMenuPlayTutorialButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuPlayTutorialButton = widget.newButton 
  {
    defaultFile = templateButtonDefaultFile,
    overFile = templateButtonOverFile,
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuPlayTutorialButtonPress, 
   }

  menuPlayTutorialButton.x = x
  menuPlayTutorialButton.y = y

  menuButtonsGroup:insert(menuPlayTutorialButton)
end

-------------------------------------------
-- PLAY ONLINE BUTTON GUI METHODS
-------------------------------------------

menuPlayOnlineButton = nil

-- PROTOTYPE
loadingMenuPlayOnlineButton   = nil
menuPlayOnlineButtonPress     = nil
createMenuPlayOnlineButton    = nil
removeMenuPlayOnlineButton    = nil

----------------------------------------------

createMenuPlayOnlineButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuPlayOnlineButton then loadingMenuPlayOnlineButton(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuPlayOnlineButton = function()
  if menuPlayOnlineButton then menuButtonsGroup:remove( menuPlayOnlineButton ); menuPlayOnlineButton = nil; end 
end

menuPlayOnlineButtonPress = function( event )
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    storyboard.gotoScene( "playonline" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

loadingMenuPlayOnlineButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuPlayOnlineButton = widget.newButton 
  {
    defaultFile = templateButtonDefaultFile,
    overFile = templateButtonOverFile,
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuPlayOnlineButtonPress, 
   }

  menuPlayOnlineButton.x = x
  menuPlayOnlineButton.y = y

  menuButtonsGroup:insert(menuPlayOnlineButton)
end

-------------------------------------------
-- CHOOSING SLINGSHOOT BUTTON GUI METHODS
-------------------------------------------

menuChoosingSlingshotButton = nil

-- PROTOTYPE
loadingMenuChoosingSlingshotButton   = nil
menuChoosingSlingshotButtonPress     = nil
createMenuChoosingSlingshotButton    = nil
removeMenuChoosingSlingshotButton    = nil

----------------------------------------------

createMenuChoosingSlingshotButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuChoosingSlingshotButton then loadingMenuChoosingSlingshotButton(x,y);  end 
end

removeMenuChoosingSlingshotButton = function()
  if menuChoosingSlingshotButton then menuButtonsGroup:remove( menuChoosingSlingshotButton ); menuChoosingSlingshotButton = nil; end 
end

menuChoosingSlingshotButtonPress = function( event )
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    storyboard.gotoScene( "choosingslingshot" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

loadingMenuChoosingSlingshotButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuChoosingSlingshotButton = widget.newButton 
  {
    defaultFile = templateButtonDefaultFile,
    overFile = templateButtonOverFile,
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuChoosingSlingshotButtonPress, 
   }

  menuChoosingSlingshotButton.x = x
  menuChoosingSlingshotButton.y = y

  menuButtonsGroup:insert(menuChoosingSlingshotButton)
end

-------------------------------------------
--GREEN SLINGSHOOT BUTTON GUI METHODS
-------------------------------------------

menuGreenSlingshotButton = nil

-- PROTOTYPE
loadingMenuGreenSlingshotButton   = nil
menuGreenSlingshotButtonPress     = nil
createMenuGreenSlingshotButton    = nil
removeMenuGreenSlingshotButton    = nil

----------------------------------------------

createMenuGreenSlingshotButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuGreenSlingshotButton then loadingMenuGreenSlingshotButton(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuGreenSlingshotButton = function()
  if menuGreenSlingshotButton then menuButtonsGroup:remove( menuGreenSlingshotButton ); menuGreenSlingshotButton = nil; end 
end

menuGreenSlingshotButtonPress = function( event )
  player1_slingshot_color = 1 
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    storyboard.gotoScene( "game" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

loadingMenuGreenSlingshotButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuGreenSlingshotButton = widget.newButton 
  {
    defaultFile = templateButtonDefaultFile,
    overFile = templateButtonOverFile,
    label = text,
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuGreenSlingshotButtonPress, 
   }

  menuGreenSlingshotButton.x = x
  menuGreenSlingshotButton.y = y

  menuButtonsGroup:insert(menuGreenSlingshotButton)
end

-------------------------------------------
--BLUE SLINGSHOOT BUTTON GUI METHODS
-------------------------------------------

menuBlueSlingshotButton = nil

-- PROTOTYPE
loadingMenuBlueSlingshotButton   = nil
menuBlueSlingshotButtonPress     = nil
createMenuBlueSlingshotButton    = nil
removeMenuBlueSlingshotButton    = nil

----------------------------------------------

createMenuBlueSlingshotButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuBlueSlingshotButton then loadingMenuBlueSlingshotButton(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuBlueSlingshotButton = function()
  if menuBlueSlingshotButton then menuButtonsGroup:remove( menuBlueSlingshotButton ); menuBlueSlingshotButton = nil; end 
end

menuBlueSlingshotButtonPress = function( event )
  player1_slingshot_color = 0
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    storyboard.gotoScene( "game" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

loadingMenuBlueSlingshotButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuBlueSlingshotButton = widget.newButton 
  {
    defaultFile = templateButtonDefaultFile,
    overFile = templateButtonOverFile,
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuBlueSlingshotButtonPress, 
   }

  menuBlueSlingshotButton.x = x
  menuBlueSlingshotButton.y = y

  menuButtonsGroup:insert(menuBlueSlingshotButton)
end

-------------------------------------------
-- TITLE LABEL GUI METHODS
-------------------------------------------
menuTitleLabel = nil

-- PROTOTYPE
createMenuTitleLabel  = nil
removeMenuTitleLabel  = nil
loagingMenuTitleLabel = nil

--------------------------------------------

createMenuTitleLabel = function()
  if not menuTitleLabel   then loadingMenuTitleLabel();  end 
end

removeMenuTitleLabel = function()
  if menuTitleLabel       then menuLabelsGroup:remove( menuTitleLabel ); menuTitleLabel = nil; end 
end

loagingMenuTitleLabel = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)

  menuTitleLabel = display.newText ( templateGameName, x, y, templateDefaultFont, templateDefaultTitleSizeFont )

  menuTitleLabel:setFillColor( templateFontColorR, templateFontColorG, templateFontColorB  )

  menuLabelsGroup:insert(menuTitleLabel)
end

-------------------------------------------
-- HIGHSCORE BUTTON GUI METHODS
-------------------------------------------

menuHighscoreButton = nil

-- PROTOTYPE
loadingMenuHighscoreButton    = nil
menuHighscoreButtonPress      = nil
createMenuHighscoreButton     = nil
removeMenuHighscoreButton     = nil

----------------------------------------------

createMenuHighscoreButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuHighscoreButton then loadingMenuHighscoreButton(x,y);  end 
end

removeMenuHighscoreButton = function()
  if menuHighscoreButton then menuButtonsGroup:remove( menuHighscoreButton ); menuHighscoreButton = nil; end 
end

menuHighscoreButtonPress = function( event )
  if sound_mode == "on" then
    audio.play( buttonSound )
  end
  local buttonListener = {}
  function buttonListener:timer( event )
    storyboard.gotoScene( "highscore" )
  end

  timer.performWithDelay( templateButtonTimeDelay, buttonListener )
end

loadingMenuHighscoreButton = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuHighscoreButton = widget.newButton 
  {
    defaultFile = templateHighscoreButtonFile,
    overFile = templateHighscoreButtonOverFile,
    label = text, 
    labelColor = { default = { templateFontColorButtonR, templateFontColorButtonG, templateFontColorButtonB }, },
    font = templateDefaultFont,
    fontSize = templateDefaultButtonSizeFont,
    emboss = true, 
    onPress = menuHighscoreButtonPress, 
   }

  menuHighscoreButton.x = x
  menuHighscoreButton.y = y

  menuButtonsGroup:insert(menuHighscoreButton)
end

-------------------------------------------
-- VOLUME LABEL GUI METHODS
-------------------------------------------
menuVolumeLabel = nil

-- PROTOTYPE
createMenuVolumeLabel  = nil
removeMenuVolumeLabel  = nil
loadingMenuVolumeLabel = nil

--------------------------------------------

createMenuVolumeLabel = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuVolumeLabel then loadingMenuVolumeLabel(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuVolumeLabel = function()
  if menuVolumeLabel then menuLabelsGroup:remove( menuVolumeLabel ); menuVolumeLabel = nil; end 
end

loadingMenuVolumeLabel = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if text == nil then text = ""; end
  menuVolumeLabel = display.newText ( text, x, y, templateDefaultFont, templateDefaultVolumeSizeFont )

  menuVolumeLabel:setFillColor( templateFontColorR, templateFontColorG, templateFontColorB  )

  menuLabelsGroup:insert(menuVolumeLabel)
end

-------------------------------------------
-- GREETINGS LABEL GUI METHODS
-------------------------------------------
menuGreettingsLabel = nil

-- PROTOTYPE
createMenuGreettingsLabel  = nil
removeMenuGreettingsLabel  = nil
loadingMenuGreettingsLabel = nil

--------------------------------------------

createMenuGreettingsLabel = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuGreettingsLabel then loadingMenuGreettingsLabel(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuGreettingsLabel = function()
  if menuGreettingsLabel then menuLabelsGroup:remove( menuGreettingsLabel ); menuGreettingsLabel = nil; end 
end

loadingMenuGreettingsLabel = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)

  local greetings = ""
  
  if facebook_login_mode == "on" then
    if player_name then 
      greetings = "Welcome " .. player_name
    else
      greetings = "Welcome Error type"
    end
  else
    local greetings = "Welcome Player!"
  end

  menuGreettingsLabel = display.newText ( greetings, x, y, templateDefaultFont, templateDefaultGreettingsSizeFont )

  menuGreettingsLabel:setFillColor( templateFontColorR, templateFontColorG, templateFontColorB  )

  menuLabelsGroup:insert(menuGreettingsLabel)
end

-------------------------------------------
-- BODY TEXT BOX FILE LABEL GUI METHODS
-------------------------------------------
menuBodyTextFileBoxLabel = nil
myRoundedRect = nil

-- PROTOTYPE
createMenuBodyTextFileBoxLabel  = nil
removeMenuBodyTextFileBoxLabel  = nil
loadingMenuBodyTextFileBoxLabel = nil

--------------------------------------------

createMenuBodyTextFileBoxLabel = function(x,y,filename)
  if not menuBodyTextFileBoxLabel then loadingMenuBodyTextFileBoxLabel(x,y,filename);  end 
end

removeMenuBodyTextFileBoxLabel = function()
  if menuBodyTextFileBoxLabel then menuLabelsGroup:remove( menuBodyTextFileBoxLabel ); menuBodyTextFileBoxLabel = nil; end 
  if myRoundedRect then menuLabelsGroup:remove( myRoundedRect ); myRoundedRect = nil; end 
end

loadingMenuBodyTextFileBoxLabel = function(x,y,filename)

  local path = system.pathForFile( filename, system.ResourceDirectory )
  local file = io.open( path, "r" )
  local mytext = ""
  if file then
    mytext = file:read( "*a" ) 
    io.close( file )
    file = nil
  else
    mytext = "Error: could not load About text." 
  end
  local s = display.getCurrentStage()
  myRoundedRect = display.newRoundedRect(x, y, 590, 320,  12 )
  myRoundedRect.strokeWidth = 3
  myRoundedRect:setFillColor( 0.9 )
  myRoundedRect:setStrokeColor( 0, 0, 0 ) 
  menuLabelsGroup:insert( myRoundedRect )
  myRoundedRect.alpha = 0.7 

  menuBodyTextFileBoxLabel = display.newText ( mytext, x, y, 550, 300, templateDefaultFont, templateDefaultBodyTextBoxSizeFont )

  menuBodyTextFileBoxLabel:setFillColor( templateFontColorBodyTextR, templateFontColorBodyTextG, templateFontColorBodyTextB  )

  menuLabelsGroup:insert(menuBodyTextFileBoxLabel)
end

-------------------------------------------
-- BODY TEXT BOX STRING LABEL GUI METHODS
-------------------------------------------
menuBodyTextStringBoxLabel = nil
myRoundedRect = nil

-- PROTOTYPE
createMenuBodyTextStringBoxLabel  = nil
removeMenuBodyTextStringBoxLabel  = nil
loadingMenuBodyTextStringBoxLabel = nil

--------------------------------------------

createMenuBodyTextStringBoxLabel = function(x,y,mytext)
  if not menuBodyTextStringBoxLabel then loadingMenuBodyTextStringBoxLabel(x,y,mytext);  end 
end

removeMenuBodyTextStringBoxLabel = function()
  if menuBodyTextStringBoxLabel then menuLabelsGroup:remove( menuBodyTextStringBoxLabel ); menuBodyTextStringBoxLabel = nil; end 
  if myRoundedRect then menuLabelsGroup:remove( myRoundedRect ); myRoundedRect = nil; end 
end

loadingMenuBodyTextStringBoxLabel = function(x,y,mytext)

  local s = display.getCurrentStage()
  myRoundedRect = display.newRoundedRect(x, y, 590, 320,  12 )
  myRoundedRect.strokeWidth = 3
  myRoundedRect:setFillColor( 0.9 )
  myRoundedRect:setStrokeColor( 0, 0, 0 ) 
  menuLabelsGroup:insert( myRoundedRect )
  myRoundedRect.alpha = 0.7 

  menuBodyTextStringBoxLabel = display.newText ( mytext, x, y, 550, 300, templateDefaultFont, templateDefaultBodyTextBoxSizeFont )

  menuBodyTextStringBoxLabel:setFillColor( templateFontColorBodyTextR, templateFontColorBodyTextG, templateFontColorBodyTextB  )

  menuLabelsGroup:insert(menuBodyTextStringBoxLabel)
end


-------------------------------------------
-- TITLE IMAGE GUI METHODS
-------------------------------------------

menuTitleImage = nil

-- PROTOTYPE
createMenuTitleImage  = nil
removeMenuTitleImage  = nil
loadingTitleImage     = nil

createMenuTitleImage = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  if not menuTitleImage then loadingMenuTitleImage(x,y, buttonImageDefaultFile, buttonImageOverFile, text);  end 
end

removeMenuTitleImage = function()
  if menuTitleImage then menuImagesGroup:remove( menuTitleImage ); menuTitleImage = nil; end 
end

loadingMenuTitleImage = function(x,y, buttonImageDefaultFile, buttonImageOverFile, text)
  menuTitleImage = display.newImage( templateLogoFile, x, y, true )  
  menuImagesGroup:insert( menuTitleImage )
end