
-- nao esta sendo usado, pode ignorar nesse momento
local lastTargettile
function previsaoColisao(t)

	local ps = projectile.newSpecialProjectile(t.x,t.y)
	ps:localToContent( t.x,t.y )
	ps.isVisible = false	

	local s_scale = 1.1

	-- Launch projectile
	ps.bodyType = "dynamic";
	ps:applyForce((slingshot.x - ps.x)*0.4*10, (slingshot.y - ps.y)*0.4*10, ps.x, ps.y);
	ps.isFixedRotation = false;

	-- Register to call t's timer method an infinite number of times
	local timer1 = timer.performWithDelay( 1, function ( event )	
	
			-- remove a mira caso tenha lançado a pedra
			if lastTargettile then
				lastTargettile:removeSelf( );
				lastTargettile = nil
			end		

			if s_scale > 0.5 then
			
				s_scale = s_scale - configuration.projecttile_variation

				local vx, vy = ps:getLinearVelocity()
				ps:setLinearVelocity(vx*0.94,vy*0.94)

			else
	    		timer.cancel( event.source ) 
				ps.isFocus = true;
				ps.isVisible = true	
				ps.bodyType = "static";			
				
				ps:setLinearVelocity(0,0); -- Stop current physics motion, if any
				ps.angularVelocity = 0;
				lastTargettile = ps
			end	
		end
	, 0 )

end