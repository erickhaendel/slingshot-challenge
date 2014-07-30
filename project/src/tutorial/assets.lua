------------------------------------------------------------------------------------------------------------------------------
-- assets.lua
-- Description: 
-- @author Samuel Martins <samuellunamartins@gmail.com>
-- @modified 
-- @version 1.00
-- @date 07/30/2014
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

local configuration = require( "src.tutorial.tutorial_settings" )

local can_tiles_lib 				= require( "src.tutorial.assets.can_tiles" )
local ground_tiles_lib 				= require( "src.tutorial.assets.ground_tiles" )
local house_tiles_lib 				= require( "src.tutorial.assets.house_tiles" )
local tree_tiles_lib 				= require( "src.tutorial.assets.tree_tiles" )
local score_player_tiles_lib 		= require( "src.tutorial.assets.score_player_tiles" )
local scoreboard_tiles_lib 			= require( "src.tutorial.assets.scoreboard_tiles" )
local sky_tiles_lib 				= require( "src.tutorial.assets.sky_tiles" )
local slingshot_tiles_lib 			= require( "src.tutorial.assets.slingshot_tiles" )
local target_tiles_lib 				= require( "src.tutorial.assets.target_tiles" )
local wall_tiles_lib 				= require( "src.tutorial.assets.wall_tiles" )
local hand_tiles_lib 				= require( "src.tutorial.assets.hand_tiles" )

---------------------------------------------------------------------------------------------------------------
-- OBJECTS
---------------------------------------------------------------------------------------------------------------
project_tiles_obj			= nil;
band_line_tiles_obj 		= nil; 
ground_tiles_obj 			= nil; 
house_tiles_obj 			= nil;  
tree_tiles_obj 				= nil;  
score_player_tiles_obj 		= nil;
scoreboard_tiles_obj 		= nil; 
sky_tiles_obj 				= nil; 
background_sky_obj 			= nil;
slingshot_tiles_obj 		= nil; 
target_tiles_obj 			= nil;
wall_tiles_obj 				= nil;
hand_tiles_obj 				= nil;
single_can_tiles_obj 		= nil;

---------------------------------------------------------------------------------------------------------------
-- GROUPS
---------------------------------------------------------------------------------------------------------------

local assetsGroup = display.newGroup();

function getAssetsGroup()
	return assetsGroup
end

function setAssetsGroupPosition(x,y)

	if x then assetsGroup.x = x; end
	if y then assetsGroup.y = y; end
end

-- Variables setup
local projectiles_container = nil;

---------------------------------------------------------------------------------------------------------------
-- METHODS
---------------------------------------------------------------------------------------------------------------

local function create_sky_tiles_obj()
	sky_tiles_obj, background_sky_obj = sky_tiles_lib.startSky();	
	sky_tiles_lib.transitionNightDay(sky_tiles_obj,background_sky_obj)
	background_sky_obj:toBack( )
end

local function create_house_tiles_obj(  )
	house_tiles_obj = house_tiles_lib.newHouseTile()
	for i=1, #house_tiles_obj do
		assetsGroup:insert( house_tiles_obj[i] )	
	end	
end

local function create_tree_tiles_obj(  )
	tree_tiles_obj = tree_tiles_lib.newTreeTile()
	for i=1, #tree_tiles_obj do
		assetsGroup:insert( tree_tiles_obj[i] )	
	end	
end

local function create_wall_tiles_obj(  )
	wall_tiles_obj = wall_tiles_lib.newWallTile();
	for i=1, #wall_tiles_obj do
		assetsGroup:insert( wall_tiles_obj[i] )	
	end		
end

-- cria apenas uma lata com as configuracoes passadas por parâmetro
local function create_single_can_tiles_obj( color, x, y )
	single_can_tiles_obj = can_tiles_lib.newSingleCanTile(color, x, y)
	assetsGroup:insert( single_can_tiles_obj )	
	single_can_tiles_obj:toFront( )
end

local function create_ground_tiles_obj(  )
	ground_tiles_obj = ground_tiles_lib.newGrassTile()
	for i=1, #ground_tiles_obj do
		assetsGroup:insert( ground_tiles_obj[i] )	
	end	
end

local function create_slingshot_tiles_obj(  )
	slingshot_tiles_obj = slingshot_tiles_lib.newSlingshotTile()
	for i=1, #slingshot_tiles_obj do
		assetsGroup:insert( slingshot_tiles_obj[i] )	
		slingshot_tiles_obj[i]:toFront( )		
	end	

end

-- GRADE DE PONTOS
local function create_scoreboard_tiles_obj(  )
	scoreboard_tiles_obj = scoreboard_tiles_lib.new_scoreboard()
	-- matriz de 20 - 4 linhas da grade por 5 colunas
	local M = 4 ; local N = 5	
	for k = 1, 4 do	
		for j = 1, M do
			for i = 1, N do
				assetsGroup:insert( scoreboard_tiles_obj[k][M * (i-1) + j] )
			end
		end
	end	
end

-- LABEL DA GRADE
local function create_score_player_tiles_obj(  )
	score_player_tiles_obj = score_player_tiles_lib.newScorePlayerLabel()
	for i=1, #score_player_tiles_obj do
		assetsGroup:insert( score_player_tiles_obj[i] )	
	end	
end

local function create_hand_tiles_obj(  )
	hand_tiles_obj = hand_tiles_lib.newHandTile()

	assetsGroup:insert( hand_tiles_obj )	
	
	hand_tiles_obj:toFront( )
end

---------------------------------------------------------------------------------------------------------------

local function remove_sky_tiles_obj()

	timer.cancel( configuration.sky_transition_event )

	if sky_tiles_obj then		
		sky_tiles_lib.removeSky( sky_tiles_obj, background_sky_obj )
	end
end

local function remove_house_tiles_obj(  )
	if house_tiles_obj then
		for i=1, #house_tiles_obj do
			assetsGroup:remove( house_tiles_obj[i] )			
		end	
		house_tiles_lib.removeHouseTile( house_tiles_obj )			
	end
end

local function remove_tree_tiles_obj(  )
	if tree_tiles_obj then
		for i=1, #tree_tiles_obj do
			assetsGroup:remove( tree_tiles_obj[i] )			
		end	
		tree_tiles_lib.removeTreeTile( tree_tiles_obj )			
	end
end

local function remove_wall_tiles_obj(  )
	if wall_tiles_obj then
		for i=1, #wall_tiles_obj do
			assetsGroup:remove( wall_tiles_obj[i] )	
		end	
		wall_tiles_lib.removeWallTiles( wall_tiles_obj )
	end
end

local function remove_single_can_tiles_obj(  )

	if single_can_tiles_obj then

		assetsGroup:remove( single_can_tiles_obj )	

		can_tiles_lib.removeSingleCanTiles(single_can_tiles_obj)
	end
end

local function remove_ground_tiles_obj(  )

	if ground_tiles_obj then

		for i=1, #ground_tiles_obj do
			assetsGroup:remove( ground_tiles_obj[i] )	
		end	

		ground_tiles_lib.removeGrassTile( ground_tiles_obj )
	end
end

local function remove_slingshot_tiles_obj(  )
	if slingshot_tiles_obj then
		for i=1, #slingshot_tiles_obj do
			assetsGroup:remove( slingshot_tiles_obj[i] )	
			slingshot_tiles_lib.removeSlingshotTile( slingshot_tiles_obj[i] )			
		end	
	end
end

local function remove_scoreboard_tiles_obj(  )
	if scoreboard_tiles_obj then
		-- matriz de 20 - 4 linhas da grade por 5 colunas
		local M = 4 ; local N = 5
		for k = 1, 4 do	
			for j = 1, M do
				for i = 1, N do
					assetsGroup:remove( scoreboard_tiles_obj[k][M * (i-1) + j] )	
				end	
			end
		end
		scoreboard_tiles_lib.removeScoreboard( scoreboard_tiles_obj )
	end
end

local function remove_score_player_tiles_obj(  )
	if score_player_tiles_obj then 
		for i=1, #score_player_tiles_obj do
			assetsGroup:remove( score_player_tiles_obj[i] )	
		end	
		score_player_tiles_lib.removeScoreLabels( score_player_tiles_obj )
	end
end

local function remove_hand_tiles_obj(  )
	if hand_tiles_obj then
		assetsGroup:remove( hand_tiles_obj )		
		hand_tiles_lib.removeHandTiles( hand_tiles_obj )
	end
end

---------------------------------------------------------------------------------------------------------------

-- remove all elements from scene
function removeStage()
	remove_sky_tiles_obj()
	remove_house_tiles_obj()
	remove_tree_tiles_obj()	
	remove_wall_tiles_obj()
	remove_ground_tiles_obj()
	remove_slingshot_tiles_obj()
end

-- create all basic elements to the scene
function createStage1()
	create_sky_tiles_obj() 	-- Animacao do ceu
	create_house_tiles_obj() -- carrega a casa
	create_tree_tiles_obj()	-- carrega a tree	
	create_wall_tiles_obj()	-- carrega a parede no cenario
	create_ground_tiles_obj()	-- carrega o chao
	create_slingshot_tiles_obj()	-- carrega a imagem do slingshot
	
	sky_tiles_lib.skyGroup:toBack( )	

	create_hand_tiles_obj()

	timer.performWithDelay( 6500, function( )
		remove_hand_tiles_obj(  )
	end )
end

function createStage2()

	create_single_can_tiles_obj("yellow",display.contentCenterX - 200, display.contentCenterY - 120)

	single_can_tiles_obj:toFront( )
end

---------------------------------------------------------------------------------------------------------------

-- animation between of thw two players screen
function moveCamera( )	

	-- Vai do cenario 1 para o 2
	if configuration.game_current_player == 2 then

		if (assetsGroup.x > -1450) then	
			sky_tiles_lib.skyGroup.x = sky_tiles_lib.skyGroup.x - configuration.camera_velocity 
			sky_tiles_lib.skyGroup:toBack( )			
			assetsGroup.x = assetsGroup.x - configuration.camera_velocity	
		end

	-- vai do cenario 2 para o 1
	elseif configuration.game_current_player == 1 then	

		if (assetsGroup.x < 0) then		
			sky_tiles_lib.skyGroup.x = sky_tiles_lib.skyGroup.x + configuration.camera_velocity 
			sky_tiles_lib.skyGroup:toBack( )
			assetsGroup.x = assetsGroup.x + configuration.camera_velocity
		end
	end
end