local physics = require ("physics")
local configuration = require("src.gameplay.configuration")

local stone
local lancer
local gravity
local velocityMultiplier = 2

gravity.x = 0 		-- gravidade no eixo X
gravity.y = 0 		-- gravidade no eixo Y
gravity.z = 0 		-- gravidade no eixo Z
stone.x 	  		-- posição atual da pedra no eixo x
stone.y 	  		-- posição atual da pedra no eixo y
stone.z 	  		-- posição atual da pedra no eixo z
stone.velocityX 	--velocidade de movimento da pedra no eixo x
stone.velocityY 	--velocidade de movimento da pedra no eixo y
stone.velocityZ 	--velocidade de movimento da pedra no eixo z
lancer.x 			--posição da pedra no lançador, no eixo x
lancer.y 			--posição da pedra no lançador, no eixo y
lancer.centerX		--centro do lançador no eixo x
lancer.centerY		--centro do lançador no eixo y
wallPosition = 200 	--posição do muro, no eixo z

moving = true 		--boolean que define se a pedra está em movimento
collided = false 	--boolean que define se ouve colisão da pedra com algum outro elemento
objectCollided 		--index com o valor que do objeto que colidiu com a pedra

function setWallPosition( newNumber )
	-- body
	wallPosition = newNumber
end

function lancing( lancer.x, lancer.y )
	-- body
	stone.x = lancer.x
	stone.y = lancer.y
	stone.z = 0 - (lancer.y/100)

	stone.velocityX =  (lancer.centerX - lancer.x)*((10*velocityMultiplier)/(lancer.y - lancer.centerY))
	stone.velocityY = 
	stone.velocityZ = 


end

function setGravity( valueX, valueY, valueZ )
	-- set the new values to gravity system, generally, the gravity system will be represented as negatives values
	gravity.x = valueX
	gravity.y = valueY
	gravity.z = valueZ
end

function checkColision( stoneX, stoneY, collisionObjects, numberOfCollisionObjects )
	-- check if any objects in colisionObjects collide with the stone

	local tempCollisionIndex = 1

	while tempCollisionIndex <= numberOfCollisionObjects do
		local tempCollisionObject = collisionObjects[tempCollisionIndex]
		
		if (stone.x >= tempCollisionObject.x && stone.x <= (tempCollisionObject.x+tempCollisionObject.lengthX) then
			if (stone.y >= tempCollisionObject.y && stone.y <= (tempCollisionObject.y+tempCollisionObject.lengthY)) then
				collided = true
				objectCollided = tempCollisionIndex
			end
		else then
			collided = false
			objectCollided = tempCollisionIndex
		end

		tempCollisionIndex = tempCollisionIndex+1
	end
end

function positionNew( stone, gravity, velocityMultiplier, wallPosition )
	-- receive the stone object (x,y,z,velocityX,velocityY, velocityZ), the gravity system (gravity.x,grativy.z,gravity.y) and the velocityMultiplier
	-- then return the stone in the new position
	-- position must be in pixel

	while moving == true do
		stone.x = stone.x + ((stone.velocityX*velocityMultiplier)+gravity.x)
		stone.y = stone.y + ((stone.velocityY*velocityMultiplier)+gravity.y)
		stone.z = stone.z + ((stone.velocityZ*velocityMultiplier)+gravity.z)

		stone.velocityX = stone.velocityX+gravity.x
		stone.velocityZ = stone.velocityZ+gravity.z
		stone.velocityY = stone.velocityY+gravity.y

		--if (stone.velocityY < 0) then -- removed this to aply gravity 
		--	stone.velocityY = 0
		--	gravity.y = 0
		--end

		if (stone.velocityZ < 0) then --remove to be possible to aply the wind to move stone on the direction of the player
			stone.velocityZ = 0
			gravity.z = 0
		end

		if (stone.velocityX < 0) then --remove to be possible to aply wind on X axis
			stone.velocityX = 0
			gravity.x = 0
		end

		if (stone.z >= wallPosition) then
			checkColision(stone.x, stone.y, colisionObjects)
		end

		if (gravity.x == 0 && gravity.z == 0 && gravity.y == 0) then
			moving = false
		end
	end
end