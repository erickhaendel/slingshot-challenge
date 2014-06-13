module(..., package.seeall)

-------------------------------------------
-- LIBs
-------------------------------------------
require( "template" )

-------------------------------------------
-- AUDIO THEME
-------------------------------------------

gameMusic = audio.loadStream( templateThemeSongAudioFile )

gameMusicChannel = audio.play( gameMusic, { channel=1, loops=-1, fadein=5000 } )

audio.setVolume( 0.2 )

-------------------------------------------
-- AUDIO MENU
-------------------------------------------

buttonSound  		= audio.loadSound( templateButtonSoundAudioFile   )
boingSound  		= audio.loadSound( templateBoingSongAudioFile   )
knockSound  		= audio.loadSound( templateKnockSongAudioFile   )
squishSound 		= audio.loadSound( templateSquishSongAudioFile  )
bandReleaseSound  	= audio.loadSound( templateBandReleaseAudioFile   )
stretchSound 		= audio.loadSound( templateStretchAudioFile  )

