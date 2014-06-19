
module(..., package.seeall)

-- Pass state reference
state = {};
-- Bullet starts off in-active
ready = false;
-- Pass audio references
shot = {};
band_stretch = {};

function newProjectile()

	-- Import easing plugin
	local easingx  = require("easing");
	
	-- Bullet properties
	local bun_bullet = {
		name = "stone",
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
	bullet.x = display.contentCenterX; bullet.y = _H + 20;
	-- Set up physical properties	
	physics.addBody(bullet, "static", {density=bun_bullet.density, friction=bun_bullet.friction, bounce=bun_bullet.bounce, radius=bun_bullet.size});
	
	bullet.linearDamping = 0.3;
	bullet.angularDamping = 0.8;
	--bullet.isBullet = true;
	bullet.isSensor = true;
	-- Transition the bullet into position each time it's spawned	
	transition.to(bullet, {time=600, y=_H - 180, transition = easingx.easeOutElastic});

	return bullet;
	
end
