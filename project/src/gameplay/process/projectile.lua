
module(..., package.seeall)

local configuration 			= require( "src.gameplay.configuration" )
local assets_audio				= require( "src.gameplay.assets_audio" )
local collision_process_lib 	= require( "src.gameplay.process.collision" )

local network_gameplay   	= require( "src.network.gameplaysync" )
local player1_obj           = require( "src.player.player1" )
local player2_obj           = require( "src.player.player2" )

-- verifica o limite do eslatico do estilingue e devolve os valores corretos
function getBoundaryProjectile( e, stone )
	-- Boundary for the projectile when grabbed			
	local bounds = e.target.stageBounds;
	bounds.xMin = 250
	bounds.yMin = display.contentHeight - 5;
	bounds.xMax = display.contentWidth -250;
	bounds.yMax = display.contentHeight - 250;
	
	-- limita a corda do estilingue para não puxar infinitamente
	if(e.y > bounds.yMax) then stone.y = e.y; end	 -- limita na parte 		
	if(e.x < bounds.xMax) then stone.x = e.x; end	 -- limita a direita
	if(e.y > bounds.yMin) then stone.y = bounds.yMin; end -- limita na parte
	if(e.x < bounds.xMin) then stone.x = bounds.xMin; end -- limita a esquerda

	return stone.x, stone.y
end

-- processa a emulacao gráfica do eixo Z para dar impressão de profundidade
function animationProcess(stone)
	-- Scale Balls
	if configuration.projecttile_scale > 0 then
		configuration.projecttile_scale = configuration.projecttile_scale - configuration.projecttile_variation	
		stone.xScale = configuration.projecttile_scale; stone.yScale = configuration.projecttile_scale
		local vx, vy = stone:getLinearVelocity()
		stone:setLinearVelocity(vx*0.94,vy*0.94)

		local nw, nh 
		local myScaleX, myScaleY = configuration.projecttile_scale, configuration.projecttile_scale

		nw = stone.width*myScaleX*0.5;
		nh = stone.height*myScaleY*0.5;

		physics.addBody( stone, { density=0.15, friction=0.2, bounce=0.6 , shape={-nw,-nh,nw,-nh,nw,nh,-nw,nh}} )						
	end	
end

function ready_to_launch_process(stone)

	-- Play the band stretch
	assets_audio.playBandStretch()

	display.getCurrentStage():setFocus( stone ); -- Set the stage focus to the touched projectile
	stone.isFocus = true;
	stone.bodyType = "kinematic";			
	
	stone:setLinearVelocity(0,0); -- Stop current physics motion, if any

	stone.angularVelocity = 0;

	return stone
end

function launching_process(stone, touch_event)

	-- Boundary for the projectile when grabbed	
	-- evita que estique o elastico infinitamente	
	stone.x,stone.y = getBoundaryProjectile( touch_event, stone )

	return stone
end

function launched_process(stone, e, assets_image, state)

	configuration.game_is_shooted = 1

	-- Reset the stage focus
	display.getCurrentStage():setFocus(nil);
	stone.isFocus = false;

	-- Play the release sound
	assets_audio.playProjecttileShot()

	-- Launch projectile
	stone.bodyType = "dynamic";

	-- FORCA X, FORCA Y, X, Y
	local x_force = (display.contentCenterX - e.x)*configuration.projecttile_force_multiplier
	local y_force = ( assets_image.slingshot_tiles_obj[configuration.game_current_player].y - e.y)*configuration.projecttile_force_multiplier
	stone:applyForce(x_force, y_force, stone.x, stone.y);

	-- SYNC NETWORK
	local info = {}
	info["projectile"] = {}
	info["projectile"][1] = x_force
	info["projectile"][2] = y_force
	info["projectile"][3] = stone.x
	info["projectile"][4] = stone.y	
	network_gameplay.updateMyProjectile(info)			
	
	stone:applyTorque( configuration.projecttile_torque )
	stone.isFixedRotation = false;	

	configuration.projecttile_scale = 1.1

	stone.timer1 = timer.performWithDelay(1, function(e)
		-- diminui a escala da pedra e traça sua trajetoria
		animationProcess(stone)

		-- monitora colisao com as latas
		if configuration.game_is_hit == 0 and configuration.projecttile_scale > 0 then		

			collision_process_lib.collision_process(stone, assets_image)
		else
			timer.cancel(stone.timer1);
			stone.timer1 = nil;
		end			
	end,0)	

	-- Wait a second before the catapult is reloaded (Avoids conflicts).
	stone.timer = timer.performWithDelay(1000, 
		function(e)
			state:dispatchEvent({name="change", state="fire"});

			if(e.count == 1) then
				timer.cancel(stone.timer);
				stone.timer = nil;
			end
		
		end
	, 1)				
end
