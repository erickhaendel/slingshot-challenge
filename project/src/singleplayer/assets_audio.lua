------------------------------------------------------------------------------------------------------------------------------
-- assets_audio.lua
-- Dewcription: 
-- @author Samuel Martins <samuellunamartins@gmail.com>
-- @version 1.00
-- @date 06/29/2014
-- @website http://www.psyfun.com.br
-- @license MIT license
--
-- The MIT License (MIT)
--
-- Copyright (c) 2014 psyfun
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--
------------------------------------------------------------------------------------------------------------------------------

module(..., package.seeall)

local configuration = require( "src.singleplayer.configuration" )


-- musica de fundo singleplayer
function startBackgroundMusic( )
	local gameplay_song = audio.loadStream( "resources/audio/songs/gameplay.wav" )
	audio.stop( 1 )
	gameMusicChannel = audio.play( gameplay_song, { channel=1, loops=-1, fadein=5000 } )
	return gameMusicChannel
end

-- som de disparo do estilingue
function playBandStretch()
	local band_stretch = audio.loadSound("resources/audio/effects/stretch-1.wav");
	audio.play(band_stretch); -- Play the band stretch
end

-- som do elastico sendo esticado
function playProjecttileShot()
	local shot = audio.loadSound("resources/audio/effects/band-release.wav");
	audio.play(shot);
end

-- som do elastico sendo esticado
function playHitCan()
	local shot = audio.loadSound("resources/audio/effects/tinhit.wav");
	audio.play(shot);
end

-- som do elastico sendo esticado
function playIncreasingScore()
	local shot = audio.loadSound("resources/audio/effects/score.wav");
	audio.play(shot);
end