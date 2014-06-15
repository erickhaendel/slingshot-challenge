module(..., package.seeall)

-------------------------------------------
-- LIBs
-------------------------------------------
require( "template" )

-------------------------------------------
-- AUDIO THEME
-------------------------------------------

gameMusic = audio.loadStream( templateThemeSongAudioFile )

-- see globaldefinitions.lua
if sound_mode == "on" then

	gameMusicChannel = audio.play( gameMusic, { channel=1, loops=-1, fadein=5000 } )

end

audio.setVolume( 0.2 )

-------------------------------------------
-- AUDIO MENU
-------------------------------------------

-- buttonSound  		= audio.loadSound( templateButtonSoundAudioFile   )


