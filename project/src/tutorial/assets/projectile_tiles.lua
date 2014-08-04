
module(..., package.seeall)

local configuration 			= require( "src.tutorial.tutorial_settings" )

-- Pass state reference
state = {};
-- Bullet starts off in-active
ready = false;

function newProjectile()

	-- Import easing plugin
	local easingx  = require("easing");
	
	local stone_name = nil

	if configuration.game_stage == 1 then -- aprendendo a usar o estilingue
		stone_name = "gray-stone"
	elseif configuration.game_stage == 2  then -- aprendendo a acertar uma lata
		stone_name = "yellow-stone"
	elseif configuration.game_stage == 3  then -- aprendendo que lata neutra nao conta ponto
		stone_name = "yellow-stone"	
	elseif configuration.game_stage == 4  then -- aprendendo a acertar as latas do player 2
		stone_name = "yellow-stone"
	elseif configuration.game_stage == 5  then -- assistir o player 2 jogar
		stone_name = "green-stone"		
	elseif configuration.game_stage == 6  then -- assistir o player 2 jogar
		stone_name = "green-stone"		
	end

	-- Bullet properties
	local bun_bullet = {
		name = stone_name,
		type = "bullet",
		density=0.15,
		friction=0.2,
		bounce=0.5,
		size = 20,
		rotation = 100
	}

	-- Init bullet
	local bullet = display.newImage("resources/images/objects/ammo/" .. bun_bullet.name .. ".png");
	-- Place bullet
	bullet.x = configuration.stone_position_x; 
	bullet.y = _H + 20;

	bullet.linearDamping = 0.3;
	bullet.angularDamping = 0.8;
	--bullet.isBullet = true;
	bullet.isSensor = true;

	-- mostra como usar o estilingue
	if configuration.game_stage == 1 then

		-- Transition the bullet into position each time it's spawned	
		transition.to(bullet, {time=600, y = configuration.stone_position_y, transition = easingx.easeOutElastic});

	-- mostra que sua cor eh amarela e mostra como acertar uma lata
	elseif configuration.game_stage == 2 then
		
		-- essa animacao ocorre apenas uma vez nesse estagio
		if configuration.game_is_shooted == 0 then
			-- pedra cinza que vira amarela		
			local bullet2 = display.newImage("resources/images/objects/ammo/gray-stone.png");
			bullet2.x = configuration.stone_position_x; 
			bullet2.y = _H - 50;
			bullet.y = _H - 50;

			-- destruicao da pedra cinza
			timer.performWithDelay( 3000, function( )
				bullet2:removeSelf( ); bullet2 = nil;
			end )

			timer.performWithDelay( 6000, function( )
				-- surge a pedra amaerla
				transition.to(bullet, {time=600, y = configuration.stone_position_y, transition = easingx.easeOutElastic});
			end )

		else
			-- Transition the bullet into position each time it's spawned	
			transition.to(bullet, {time=600, y = configuration.stone_position_y, transition = easingx.easeOutElastic});
		end

	-- mostra que existe latas neutras que nao contam pontos
	elseif configuration.game_stage == 3 then

		-- Transition the bullet into position each time it's spawned	
		transition.to(bullet, {time=600, y = configuration.stone_position_y, transition = easingx.easeOutElastic});

	-- mostra que existe latas verdes que os pontos vao para o players
	elseif configuration.game_stage == 4 then
		
		-- Transition the bullet into position each time it's spawned	
		transition.to(bullet, {time=600, y = configuration.stone_position_y, transition = easingx.easeOutElastic});

	-- assiste o player 2 jogar	
	elseif configuration.game_stage == 5 then

		-- essa animacao ocorre apenas uma vez nesse estagio
		if configuration.game_is_shooted == 0 then
			-- pedra cinza que vira verde		
			local bullet2 = display.newImage("resources/images/objects/ammo/gray-stone.png");
			bullet2.x = configuration.stone_position_x; 
			bullet2.y = _H - 50;
			bullet.y = _H - 50;

			-- destruicao da pedra cinza
			timer.performWithDelay( 3000, function( )
				bullet2:removeSelf( ); bullet2 = nil;
			end )

			timer.performWithDelay( 6000, function( )
				-- surge a pedra verde
				transition.to(bullet, {time=600, y = configuration.stone_position_y, transition = easingx.easeOutElastic});
			end )

		else
			-- Transition the bullet into position each time it's spawned	
			transition.to(bullet, {time=600, y = configuration.stone_position_y, transition = easingx.easeOutElastic});
		end
	-- mostra que existe latas verdes que os pontos vao para o players
	elseif configuration.game_stage == 6 then
		
		-- Transition the bullet into position each time it's spawned	
		transition.to(bullet, {time=600, y = configuration.stone_position_y, transition = easingx.easeOutElastic});
	end

	return bullet;
	
end