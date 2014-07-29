
module(..., package.seeall)

local configuration = require( "src.gameplay.configuration" )

-- Pass state reference
state = {};
-- Bullet starts off in-active
ready = false;

function newProjectile()

	-- Import easing plugin
	local easingx  = require("easing");
	
	local stone_name = nil

	if configuration.game_current_player == 1 then
		stone_name = "yellow-stone"
	elseif configuration.game_current_player == 2 then
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
	bullet.x = configuration.stone_position_x; bullet.y = _H + 20;
	-- Set up physical properties	
	--physics.addBody(bullet, "static", {density=bun_bullet.density, friction=bun_bullet.friction, bounce=bun_bullet.bounce, radius=bun_bullet.size});
	
	bullet.linearDamping = 0.3;
	bullet.angularDamping = 0.8;
	--bullet.isBullet = true;
	bullet.isSensor = true;
	-- Transition the bullet into position each time it's spawned	
	transition.to(bullet, {time=600, y = configuration.stone_position_y, transition = easingx.easeOutElastic});

	return bullet;
	
end