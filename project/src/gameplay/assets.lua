------------------------------------------------------------------------------------------------------------------------------
-- assets.lua
-- Description: 
-- @author Samuel Martins <samuellunamartins@gmail.com>
-- @modified 
-- @version 1.00
-- @date 06/29/2014
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

local configuration = require( "src.gameplay.configuration" )

local can_tiles_lib 				= require( "src.gameplay.assets.can_tiles" )
local ground_tiles_lib 				= require( "src.gameplay.assets.ground_tiles" )
local house_tiles_lib 				= require( "src.gameplay.assets.house_tiles" )
local tree_tiles_lib 				= require( "src.gameplay.assets.tree_tiles" )
local score_player_tiles_lib 		= require( "src.gameplay.assets.score_player_tiles" )
local scoreboard_tiles_lib 			= require( "src.gameplay.assets.scoreboard_tiles" )
local sky_tiles_lib 				= require( "src.gameplay.assets.sky_tiles" )
local slingshot_tiles_lib 			= require( "src.gameplay.assets.slingshot_tiles" )
local stone_trajectory_tiles_lib 	= require( "src.gameplay.assets.stone_trajectory_tiles" )
local target_tiles_lib 				= require( "src.gameplay.assets.target_tiles" )
local title_player_tiles_lib 		= require( "src.gameplay.assets.title_player_tiles" )
local title_round_tiles_lib 		= require( "src.gameplay.assets.title_round_tiles" )
local wall_tiles_lib 				= require( "src.gameplay.assets.wall_tiles" )
local upperScore_tiles_lib			= require( "src.gameplay.assets.upperScore_tiles")

---------------------------------------------------------------------------------------------------------------
-- OBJECTS
---------------------------------------------------------------------------------------------------------------
project_tiles_obj			= nil;
band_line_tiles_obj 		= nil; 
can_tiles_obj 				= nil; 
ground_tiles_obj 			= nil; 
house_tiles_obj 			= nil;  
tree_tiles_obj 				= nil;  
score_player_tiles_obj 		= nil;
scoreboard_tiles_obj 		= nil; 
sky_tiles_obj 				= nil; 
background_sky_obj 			= nil;
slingshot_tiles_obj 		= nil; 
stone_trajectory_tiles_obj 	= nil; 
target_tiles_obj 			= nil;
title_player_tiles_obj 		= nil; 
score_round_tiles_obj 		= nil; 
wall_tiles_obj 				= nil;
upperScore_tiles_obj					= nil;
myCircleYellow_upperScore_tiles_obj		= nil;
myCircleGreen_upperScore_tiles_obj		= nil;


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

local function create_can_tiles_obj(  )
	can_tiles_obj = can_tiles_lib.newCanTile()
	for i=1, #can_tiles_obj do
		for j=1, #can_tiles_obj do
			assetsGroup:insert( can_tiles_obj[i][j] )	
		end
	end		
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

local function create_title_player_tiles_obj(  )
	title_player_tiles_obj = title_player_tiles_lib.newTitlePlayerLabel()
	for i=1, #title_player_tiles_obj do
		assetsGroup:insert( title_player_tiles_obj[i] )	
	end		
end

local function create_title_round_tiles_obj(  )	
	title_round_tiles_obj = title_round_tiles_lib.newRoundLabel()
	for i=1, #title_round_tiles_obj do
		assetsGroup:insert( title_round_tiles_obj[i] )	
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

local function create_upperScore_tiles_obj(  )

	upperScore_tiles_obj, myCircleYellow_upperScore_tiles_obj, myCircleGreen_upperScore_tiles_obj  = upperScore_tiles_lib.newUpperBoardTile()

	for i=1,2 do
		--assetsGroup:insert( upperScore_tiles_obj[i] )		
		upperScore_tiles_obj[i]:toFront( )
	end

	for i=1,3 do
		for j=1,7 do
			myCircleYellow_upperScore_tiles_obj[i][j]:toFront( )
			myCircleGreen_upperScore_tiles_obj[i][j]:toFront( )
		end
	end
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

local function remove_can_tiles_obj(  )

	if can_tiles_obj then

		local M = 2 ; local N = 2

		-- removendo as ltas do grupo
		for k=1,4 do
			for i = 1, N do
				for j = 1, M do
					assetsGroup:remove( can_tiles_obj[k][M * (i-1) + j] )	
				end
			end
		end	

		-- remove todas as latas
		can_tiles_lib.removeCanTiles(can_tiles_obj)
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

local function remove_title_player_tiles_obj(  )
	if title_player_tiles_obj then
		for i=1, #title_player_tiles_obj do
			assetsGroup:remove( title_player_tiles_obj[i] )	
		end	
		title_player_tiles_lib.removeTitlePlayerLabel( title_player_tiles_obj )
	end
end

local function remove_title_round_tiles_obj(  )
	if title_round_tiles_obj then
		for i=1, #title_round_tiles_obj do
			assetsGroup:remove( title_round_tiles_obj[i] )	
		end	
		title_round_tiles_lib.removeRoundLabel( title_round_tiles_obj )
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

local function remove_upperScore_tiles_obj(  )
	if upperScore_tiles_obj then 
		-- for i=1, #upperScore_tiles_obj do
		-- 	assetsGroup:remove( upperScore_tiles_obj[i] )	
		-- end	
		upperScore_tiles_lib.removeUpperBoardTile( upperScore_tiles_obj, myCircleYellow_upperScore_tiles_obj, myCircleGreen_upperScore_tiles_obj )
	end
end

---------------------------------------------------------------------------------------------------------------

-- remove all elements from scene
function removeGameplayScenario()

	remove_sky_tiles_obj()
	remove_house_tiles_obj()
	remove_tree_tiles_obj()	
	remove_wall_tiles_obj()
	remove_can_tiles_obj()
	remove_ground_tiles_obj()
	remove_slingshot_tiles_obj()
	remove_title_player_tiles_obj()
	remove_title_round_tiles_obj()
	-- remove_scoreboard_tiles_obj()
	remove_score_player_tiles_obj()
	remove_upperScore_tiles_obj()	
end

-- create all basic elements to the scene
function createGameplayScenario()

	create_sky_tiles_obj() 	-- Animacao do ceu
	create_house_tiles_obj() -- carrega a casa
	create_tree_tiles_obj()	-- carrega a tree	
	create_wall_tiles_obj()	-- carrega a parede no cenario
	create_can_tiles_obj()	-- carrega as latas em cima da parede
	create_ground_tiles_obj()	-- carrega o chao
	create_slingshot_tiles_obj()	-- carrega a imagem do slingshot
	create_title_player_tiles_obj()	-- carrega as labels identificando os cenários

	timer.performWithDelay( configuration.time_hide_title_player_label, function ( event )	
			remove_title_player_tiles_obj(  )
		end)

	-- carrega os titlos dos rounds
	timer.performWithDelay( configuration.time_show_round_label, function ( event )	
		create_title_round_tiles_obj(  )

		timer.performWithDelay( configuration.time_hide_round_label, function ( event )	
				remove_title_round_tiles_obj(  )
			end)
		end)

	-- create_scoreboard_tiles_obj()	-- as latas de scores dos scoreboards

	create_score_player_tiles_obj()	-- carrega as labels identificando os scoreboards

	if configuration.game_current_player == 1 then
		setAssetsGroupPosition(display.contentCenterX - 2100, nil)
	end	


	create_upperScore_tiles_obj() -- carrega novo placar de pontos
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

function reload_round_tiles( )

	-- carrega os titulos dos rounds
	timer.performWithDelay( configuration.time_show_round_label, function ( event )	
		create_title_round_tiles_obj(  )

		timer.performWithDelay( configuration.time_hide_round_label, function ( event )	
				remove_title_round_tiles_obj(  )
			end)
		end)
end

function reload_can_tiles( )

	-- remove as latas do round anterior
	remove_can_tiles_obj(  )

	-- carrega as latas em cima da parede
	timer.performWithDelay(1000, function ( event )	
		create_can_tiles_obj(  )
		end)
end

-- -- hide all scores from all scoreboards
-- function hidePointsScoreboards()

-- 	local M = 4 ; local N = 5

-- 	for k = 1, 4 do	
-- 		for j = 1, M do
-- 			for i = 1, N do
-- 				scoreboard_tiles_obj[k][M * (i-1) + j].isVisible = false
-- 			end
-- 		end
-- 	end

-- 	return scoreboard_tiles_obj
-- end

