
module(..., package.seeall)

local configuration 			= require( "src.gameplay.configuration" )
local assets_audio				= require( "src.gameplay.assets_audio" )
local smoke_sprite_lib 			= require( "src.gameplay.assets.smoke_sprite" )
local collision_process_lib 	= require( "src.gameplay.process.collision" )

local network_gameplay   	= require( "src.network.gameplaysync" )
local player1_obj           = require( "src.player.player1" )
local player2_obj           = require( "src.player.player2" )

-- verifica o limite do eslatico do estilingue e devolve os valores corretos
function getBoundaryProjectile( e, stone )
	-- Boundary for the projectile when grabbed			
	local bounds = e.target.stageBounds;
	bounds.xMin = 550
	bounds.yMin = display.contentHeight - 50;
	bounds.xMax = display.contentWidth - 550;
	bounds.yMax = display.contentHeight - 200;
	
	-- limita a corda do estilingue para não puxar infinitamente
	if(e.y > bounds.yMax) then stone.y = e.y; end	 -- limita na parte 		
	if(e.x < bounds.xMax) then stone.x = e.x; end	 -- limita a direita
	if(e.y > bounds.yMin) then stone.y = bounds.yMin; end -- limita na parte
	if(e.x < bounds.xMin) then stone.x = bounds.xMin; end -- limita a esquerda

	return stone.x, stone.y
end


function ready_to_launch_process(stone)

	-- Play the band stretch
	assets_audio.playBandStretch()

	display.getCurrentStage():setFocus( stone ); -- Set the stage focus to the touched projectile
	stone.isFocus = true;
	--stone.bodyType = "kinematic";			
	
	--stone:setLinearVelocity(0,0); -- Stop current physics motion, if any

	--stone.angularVelocity = 0;

	return stone
end

function launching_process(stone, touch_event)

	-- Boundary for the projectile when grabbed	
	-- evita que estique o elastico infinitamente	
	stone.x,stone.y = getBoundaryProjectile( touch_event, stone )

	return stone
end


-- A trajectory in world space
function trajectory(v,elevation,x0,y0,g)
    x0 = x0 or 0
    y0 = y0 or 0
    local th = math.rad(elevation or 45)
    g = g or 9.81

    return function(x)
        x = x-x0
        local a = x*math.tan(th)
		local temp
		if (2*(v*math.cos(th))^2) == 0 then temp = 0.01 else temp = (2*(v*math.cos(th))^2); end
        local b = (g*x^2)/temp
        return y0+a-b
    end
end

-- convert between screen and world
function converter(iso)
    iso = math.rad(iso or 0)
    return function(toscreen,x,y)
        if toscreen then
            y = y+x*math.sin(iso)
            x = x*math.cos(iso)
        else
			local temp
			if math.cos(iso) == 0 then temp = math.cos(iso - 1); else temp = math.cos(iso) end
            x = x/temp
            y = y-x*math.sin(iso)
        end
        return x,y
    end
end

-- Metodo de lancamneto de pedra multiplayer
function remote_launched_process( info )

	local stone = configuration.projectile_object
	local assets_image = configuration.assets_image_object

	stone.isVisible = true

	configuration.game_is_shooted = 1

	-- Reset the stage focus
	display.getCurrentStage():setFocus(nil);
	stone.isFocus = false;	
	-- Launch projectile

	configuration.projecttile_scale = 1.0

-- velocity, angle, x, y
	-- SYNC NETWORK
	--info["projectile"]["player"] = configuration.game_i_am_player_number
	local angle = info["projectile"]["angle"]
	local dx = info["projectile"]["dx"] 
	local dy = info["projectile"]["dy"] 
	local sentido = info["projectile"]["sentido"]	

	t = trajectory(120,angle,dx,dy)

	-- iso projection of 1 deg
	c = converter(1)

		timer.performWithDelay(1, function(e)
				local xx = c(false,dx,0) -- x in world co-ords
				local y = t(xx) -- y in world co-ords
				local _,yy = c(true,xx,y) -- y in screen co-ords
				local _,y0 = c(true,xx,0) --ground in screen co-ords
				yy = math.floor(yy) -- not needed 
				
				dx = dx + 7
					
				dy = yy

				if yy>y0 then 

					if sentido == 1 then		
						stone.x = dx
					else
						stone.x = (display.contentWidth - dx)
					end

					stone.y = (display.contentHeight )	- dy 

					-- abaixo do muro
					if stone.y > 400 then
						
						if stone.xScale > 0.4 then
							
							stone.xScale = stone.xScale - dy*0.00005
							stone.yScale = stone.yScale - dy*0.00005

						else
							timer.cancel( e.source )
							smoke_sprite_lib.newSmokeSprite(stone.x, stone.y)								
							stone.isVisible = false
												
						end	
					
					-- acima do muro
					elseif (stone.xScale - dy*0.00004) > 0 then
												

						stone.xScale = stone.xScale - dy*0.00001
						stone.yScale = stone.yScale - dy*0.00001
					end
				end -- if it's above ground
		end,1000)

	stone.timer1 = timer.performWithDelay(1, function(e)
		-- diminui a escala da pedra e traça sua trajetoria

		-- monitora colisao com as latas
		if configuration.game_is_hit == 0 and configuration.projecttile_scale > 0 then		

			collision_process_lib.collision_process(stone, configuration.assets_image_object)
		else
			timer.cancel(stone.timer1);
			stone.timer1 = nil;
		end			
	end,0)	

	-- Wait a second before the catapult is reloaded (Avoids conflicts).
	stone.timer = timer.performWithDelay(1000, 
		function(e)
			configuration.state_object:dispatchEvent({name="change", state="fire"});

			if(e.count == 1) then
				timer.cancel(stone.timer);
				stone.timer = nil;			
			end
		
		end
	, 1)
end


function launched_process(stone, e, assets_image, state)

	configuration.game_is_shooted = 1

	-- Reset the stage focus
	display.getCurrentStage():setFocus(nil);
	stone.isFocus = false;

	-- Play the release sound
	assets_audio.playProjecttileShot()

	-- copia da pedra, usado pelo pubnub
	configuration.projectile_object = stone		

	configuration.projecttile_scale = 1.0

	local deltay = stone.y - configuration.stone_position_y
	local deltax = stone.x - configuration.stone_position_x
	
	deltax = math.sqrt( math.pow( deltax, 2 ) )
	deltay = math.sqrt( math.pow( deltay, 2 ) )

	local angle = math.deg(math.atan( deltay/deltax ))	

	print(angle)

	dx = configuration.stone_position_x
	dy = (display.contentHeight ) - configuration.stone_position_y

	stone.isVisible = true

	-- x in screen co-ords
	local sentido = 1	
	if e.x < configuration.stone_position_x then
		sentido = 1
	else
		sentido = -1
	end
	
	-- velocity, angle, x, y
	-- SYNC NETWORK
	local info = {}
	info["projectile"] = {}
	info["projectile"]["player"] = configuration.game_i_am_player_number
	info["projectile"]["angle"] = angle
	info["projectile"]["dx"] =dx
	info["projectile"]["dy"] = dy
	info["projectile"]["sentido"] = sentido	

	network_gameplay.updateMyProjectile(info)			
	
	t = trajectory(120,angle,dx,dy)

	-- iso projection of 1 deg
	c = converter(1)

	stone.timer1 = timer.performWithDelay(1, function(e)
		-- diminui a escala da pedra e traça sua trajetoria

		-- monitora colisao com as latas
		if configuration.game_is_hit == 0 and configuration.game_ended == 0 and stone.xScale > 0 and configuration.game_total_rounds > configuration.game_current_round and configuration.game_current_turn ~= 2 then

			collision_process_lib.collision_process(stone, configuration.assets_image_object)
		else
			timer.cancel(stone.timer1);
			stone.timer1 = nil;
		end			
	end,0)	

	timer.performWithDelay(1, function(e)
			local xx = c(false,dx,0) -- x in world co-ords
			local y = t(xx) -- y in world co-ords
			local _,yy = c(true,xx,y) -- y in screen co-ords
			local _,y0 = c(true,xx,0) --ground in screen co-ords
			yy = math.floor(yy) -- not needed 
			
			dx = dx + 7
				
			dy = yy

			if yy>y0 then 

				if sentido == 1 then		
					stone.x = dx
				else
					stone.x = (display.contentWidth - dx)
				end

				stone.y = (display.contentHeight )	- dy 

				-- abaixo do muro
				if stone.y > 400 then
					
					if stone.xScale > 0.4 then
						
						stone.xScale = stone.xScale - dy*0.00005
						stone.yScale = stone.yScale - dy*0.00005

					else
						timer.cancel( e.source )
						smoke_sprite_lib.newSmokeSprite(stone.x, stone.y)								
						stone.isVisible = false
											
					end	
				
				-- acima do muro
				elseif (stone.xScale - dy*0.00004) > 0 then
											

					stone.xScale = stone.xScale - dy*0.00001
					stone.yScale = stone.yScale - dy*0.00001
				end
			end -- if it's above ground
	end,1000)



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
