
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

	if configuration.game_stage == 1 then
		stone_name = "gray-stone"
	elseif configuration.game_stage == 2 or configuration.game_stage == 3 or configuration.game_stage == 4 then
		stone_name = "yellow-stone"
	elseif configuration.game_stage == 5 then
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
	-- Set up physical properties	
	--physics.addBody(bullet, "static", {density=bun_bullet.density, friction=bun_bullet.friction, bounce=bun_bullet.bounce, radius=bun_bullet.size});
	
	bullet.linearDamping = 0.3;
	bullet.angularDamping = 0.8;
	--bullet.isBullet = true;
	bullet.isSensor = true;


	if configuration.game_stage == 1 then

		-- Transition the bullet into position each time it's spawned	
		transition.to(bullet, {time=600, y = configuration.stone_position_y, transition = easingx.easeOutElastic});

	elseif configuration.game_stage == 2 or configuration.game_stage == 3 or configuration.game_stage == 4 then
		
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
			transition.to(bullet, {time=2600, y = configuration.stone_position_y, transition = easingx.easeOutElastic});
		end )

	elseif configuration.game_stage == 5 then

		-- Transition the bullet into position each time it's spawned	
		transition.to(bullet, {time=600, y = configuration.stone_position_y, transition = easingx.easeOutElastic});
		
	end

	return bullet;
	
end