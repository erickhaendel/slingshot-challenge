
module(..., package.seeall)

local configuration = require( "src.gameplay.configuration" )

-- musica de fundo gameplay
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

-- verifica se houve colisao entre dois objetos
function hitTestObjects(obj1, obj2)
    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
    return (left or right) and (up or down)
end

-- verifica o limite do eslatico do estilingue e devolve os valores corretos
function getBoundaryProjectile( e, t )
	-- Boundary for the projectile when grabbed			
	local bounds = e.target.stageBounds;
	bounds.xMin = 250
	bounds.yMin = display.contentHeight - 5;
	bounds.xMax = display.contentWidth -250;
	bounds.yMax = display.contentHeight - 250;
	
	-- limita a corda do estilingue para não puxar infinitamente
	if(e.y > bounds.yMax) then t.y = e.y; end	 -- limita na parte 		
	if(e.x < bounds.xMax) then t.x = e.x; end	 -- limita a direita
	if(e.y > bounds.yMin) then t.y = bounds.yMin; end -- limita na parte
	if(e.x < bounds.xMin) then t.x = bounds.xMin; end -- limita a esquerda

	return t.x, t.y
end

function changeCurrentPlayer()
		-- change the current player
	if configuration.game_current_player == 1 then 
		configuration.game_current_player = 2; 
	else 
		configuration.game_current_player = 1; 
	end
end

-- debug console
function debug_gameplay()
	print( "Current player: "..configuration.game_current_player )
	print( "Current round: "..configuration.game_current_round )
	print( "Player 1 Score: "..configuration.game_final_score_player[1])
	print( "Player 2 Score: "..configuration.game_final_score_player[2])		
	print( "Total de rounds a ser disputados: "..configuration.game_total_rounds )
end

-- trajectory of project tile
function remove_projectile_trajectory()
	-- remove a trajetoria anterior
	for i=1,#trajetory do
		if trajetory[i] then
			trajetory[i]:removeSelf( )
		end
	end

	circle_id = 1
	configuration.projecttile_scale = 1.1
end