------------------------------------------------------------------------------------------------------------------------------
-- game.lua
-- Dewcription: gameplay configuration file
-- @author Samuel Martins <samuellunamartins@gmail.com>
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

require( "src.infra.includeall" )

_W = display.contentWidth;
_H = display.contentHeight;

-- PLAYERS
game_score_player = {}			-- NAO_MODIFICAR_VALOR
game_score_player[1] = 0 		-- NAO_MODIFICAR_VALOR
game_score_player[2] = 0 		-- NAO_MODIFICAR_VALOR
game_round_score_player = {}
game_round_score_player[1] = 0
game_round_score_player[2] = 0
game_final_score_player = {} 	-- NAO_MODIFICAR_VALOR
game_final_score_player[1] = 0 	-- NAO_MODIFICAR_VALOR
game_final_score_player[2] = 0 	-- NAO_MODIFICAR_VALOR
game_all_round = {{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0}}
game_all_intent = {{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0}}

game_hit_choose = {} 			-- intencao de acerto de cada player
game_hit_choose[1] = {}			-- player 1
game_hit_choose[2] = {} 		-- player 2

-- NPC
npc_strategy = "random"			-- esse valor padrao eh alterado quando se clica nos botoes singleplayer 1 e 2

-- GAME STATE MACHINE
game_is_shooted = 0 			-- se a pedra foi disparada
game_is_hit = 0 				-- se a lata foi atingida
game_current_turn = 1 			-- 1 rodada possui dois turnos, um para cada player  - NAO_MODIFICAR_VALOR
game_max_allowed_turns = 2 		-- numero maximo de turnos por rodada - PODE_MODIFICAR_VALOR
game_i_am_player_number = nil
game_current_player = 1 		-- identifica o jogador que esta jogando no momento  - NAO_MODIFICAR_VALOR
game_current_round = 1 			-- rodada atual - NAO_MODIFICAR_VALOR
game_total_rounds = 3		 	-- guarda o numero sorteado de rounds - NAO_MODIFICAR_VALOR
game_max_allowed_rounds = 3 	-- numero maximo de rounds em um sorteio - PODE_MODIFICAR_VALOR
game_ended = 0

-- ANIMATION CONFIG
camera_velocity = 12 									-- velocidade da animcao de transicao de tela
time_hide_title_player_label = 64000 / camera_velocity	-- tempo de duracao de exibicao do nome player
time_delay_toshow_slingshot = 72000 / camera_velocity   -- tempo de espera para que o estilingue fique pronto para uso
time_show_round_label =  64000 / camera_velocity 		-- tempo de espera para que apareca o titulo do round atual
time_hide_round_label = 2000							-- tempo de espera para ocultar o titulo de round atual
time_start_next_round = 4000 							-- espera 5 segundos para iniciar a proxima rodada

time_cantile_animation_delay = 1000						-- 
time_cantile_transition_delay = 500						--

-- Projecttile
projecttile_torque = 100 								-- força de rotacao da pedra
projecttile_scale = 1.1 								-- escala da pedra
projecttile_variation = 0.03 							-- variacao da escala da pedra ao ser lancada
projecttile_force_multiplier = 10 						-- valor que multiplica a forca em cada eixo
projectile_object = nil
assets_image_object = nil
state_object = nil

-- PROJECT TILE TRAJECTORY
local circle_id = 1 									-- contador de pontos da trajetoria
local trajetory = {} 									-- contador de pontos da trajetoria

-----------------------
-- ASSETS
-----------------------

-- HOUSE
house_position_x = {}
house_position_y = {}
house_position_x[1] = display.contentCenterX - 740 				-- posicao do tile casa
house_position_y[1] = display.contentCenterY - 280 	
house_position_x[2] = display.contentCenterX + 2750 			-- posicao do tile casa
house_position_y[2] = display.contentCenterY - 280 				-- poiscao do tile casa
house_image_filename = {}
house_image_filename[1] = "resources/images/objects/house1.png"		-- nome de arquivo da imagem casa
house_image_filename[2] = "resources/images/objects/house2.png"		-- nome de arquivo da imagem casa

-- TREE
tree_position_x = {}
tree_position_y = {}
tree_position_x[1] = display.contentCenterX + 700				-- posicao do tile tree
tree_position_y[1] = display.contentCenterY - 280 	
tree_position_x[2] = display.contentCenterX + 1050 				-- posicao do tile tree
tree_position_y[2] = display.contentCenterY - 280 				-- poiscao do tile tree
tree_image_filename = {}
tree_image_filename[1] = "resources/images/objects/tree1.png"		-- nome de arquivo da imagem tree
tree_image_filename[2] = "resources/images/objects/tree2.png"		-- nome de arquivo da imagem tree

-- GRASS
grass_position_x = {}
grass_position_y = {}
grass_position_x[1] = display.contentCenterX
grass_position_y[1] = display.contentCenterY + 254
grass_position_x[2] = display.contentCenterX + 1439
grass_position_y[2] = display.contentCenterY + 254
grass_image_filename = 'resources/images/objects/grass.png'
grassBody = { friction=0.5, bounce=0.3 }

-- SLINGSHOT
slingshot_position_x = {}; slingshot_position_y = {}
slingshot_position_x[1] = display.contentCenterX
slingshot_position_y[1] = _H - 150
slingshot_position_x[2] = display.contentCenterX + 1455
slingshot_position_y[2] = _H - 150
slingshot_image_filename = "resources/images/objects/slingshot.png"
stone_position_x = display.contentCenterX
stone_position_y = slingshot_position_y[1] - 70

-- LINE BAND SLINGSHOT
myLine_x2 = slingshot_position_x[1] - 49
myLine_y2 = slingshot_position_y[1] - 80
myLineBack_x2 = slingshot_position_x[1] + 49
myLineBack_y2 = slingshot_position_y[1] - 80

-----------
-- WALL
-----------
wall_x = {}; wall_y = {} -- declaracao das tabelas
wall_x[1] = display.contentCenterX - 360
wall_y[1] = display.contentCenterY + 10
wall_x[2] = display.contentCenterX + 360
wall_y[2] = display.contentCenterY + 10
wall_x[3] = display.contentCenterX + 1080
wall_y[3] = display.contentCenterY + 10
wall_x[4] = display.contentCenterX + 1800
wall_y[4] = display.contentCenterY + 10
wall_image_filename = 'resources/images/objects/wall.png'
wallBody = { density=882.0, friction=880.3, bounce=0.4 }

---------------
-- CANS
---------------

cans_x = {}; cans_y = {}					-- para 04 grupos de 4 latas, posicao delas no muro no cenario 1 e 2
cans_x[1] = display.contentCenterX - 300
cans_y[1] = display.contentCenterY - 40
cans_x[2] = display.contentCenterX + 180
cans_y[2] = cans_y[1]
cans_x[3] = display.contentCenterX + 1650
cans_y[3] = cans_y[1]
cans_x[4] = display.contentCenterX + 1160
cans_y[4] = cans_y[1]

player_can= {}
player_can[1] =  1
player_can[2] =  2
player_can[3] =  2
player_can[4] =  1

can_image_dir = "resources/images/objects/"		-- diretorio onde estao as imagens das latas
can_xScale = 1.00; 
can_yScale = can_xScale		-- escala da lata na parede
can_width = 45 * can_xScale
can_height = 80 * can_yScale
player1_can = "yellow-can.png"					-- imagem da lata do player 1
player2_can = "green-can.png"					-- imagem da lata do player 2
neutral_can = "neutral-can.png"					-- imagem da lata neutra
pack_of_cans = 4 								-- quantidade de latas agrupadas no muro para cada player


-----------------
-- SCOREBOARD
-----------------
score_cans_x = {}; score_cans_y = {}			-- NAO MODIFICAR NADA ABAIXO - POSICAO DOS PONTOS NA GRADE DE SCORE
score_cans_x[1] = display.contentCenterX - 720 -- scoreboard 1 - tela 01
score_cans_y[1] = display.contentCenterY + 367
score_cans_x[2] = display.contentCenterX + 340 -- scoreboard 2 - tela 01
score_cans_y[2] = display.contentCenterY + 367
score_cans_x[3] = display.contentCenterX + 720 -- scoreboard 3 - tela 02
score_cans_y[3] = display.contentCenterY + 367
score_cans_x[4] = display.contentCenterX + 1780 -- scoreboard 4 - tela 02
score_cans_y[4] = display.contentCenterY + 367
player1_score_can = "yellow-can-score.png"
player2_score_can = "green-can-score.png"	

-- SKY
sky_x = {}; sky_y = {}
sky_x[1] = display.contentCenterX - 1510
sky_y[1] = display.contentCenterY - 280
sky_x[2] = display.contentCenterX - 230
sky_y[2] = display.contentCenterY - 280
sky_x[3] = display.contentCenterX + 1050
sky_y[3] = display.contentCenterY - 280
sky_x[4] = display.contentCenterX + 2330
sky_y[4] = display.contentCenterY - 280
sky_image_filename = "resources/images/objects/sky.png"
sky_transition_event = nil

-- TITLE PLAYER LABEL
title_player_label_x = {}; title_player_label_y = {}
title_player_label_x[1] = display.contentCenterX + 15
title_player_label_y[1] = display.contentCenterY-280
title_player_label_x[2] = display.contentCenterX + 1465
title_player_label_y[2] = display.contentCenterY-280
title_player_image = {}
title_player_image[1] = "resources/images/buttons/player1.png"
title_player_image[2] = "resources/images/buttons/player2.png"

-- SCORE PLAYER LABEL
score_player_label_x = {}; score_player_label_y = {}
score_player_label_x[1] = display.contentCenterX - 555
score_player_label_y[1] = display.contentCenterY + 375
score_player_label_x[2] = display.contentCenterX + 450
score_player_label_y[2] = display.contentCenterY + 375
score_player_label_x[3] = display.contentCenterX + 885
score_player_label_y[3] = display.contentCenterY + 375
score_player_label_x[4] = display.contentCenterX + 1890
score_player_label_y[4] = display.contentCenterY + 375

-- TITLE ROUND LABEL
title_round_image = {}
title_round_image[1] = "resources/images/buttons/round1.png"
title_round_image[2] = "resources/images/buttons/round2.png"
title_round_image[3] = "resources/images/buttons/round3.png"
title_round_image[4] = "resources/images/buttons/round4.png"
title_round_image[5] = "resources/images/buttons/round5.png"

-- TITLE TURN LABEL
title_turn_image = {}
title_turn_image[1] = "resources/images/buttons/turn1.png"
title_turn_image[2] = "resources/images/buttons/turn2.png"

-- SMOKE SPRITE
smoke_sprite_image			= "resources/images/objects/smoke-sprite.png"
smoke_imagesheet_options 	= { width=128, height=128, numFrames=40, sheetContentWidth=1024, sheetContentHeight=1024 }
smoke_sprite_options		= { name = "normalRun", start=1, count=40, time=900, loopCount = 1 }

-- DONOTTOUCH SPRITE
donottouch_sprite_image			= "resources/images/objects/donottouch-sprite.png"
donottouch_imagesheet_options 	= { width=100, height=100, numFrames=5, sheetContentWidth=500, sheetContentHeight=100 }
donottouch_sprite_options		= { name = "normalRun", start=1, count=5, time=400, loopCount = 1 }

-- SLINGSHOTLEFT SPRITE
slingshotleft_sprite_image			= "resources/images/objects/slingshotleft-sprite.png"
slingshotleft_imagesheet_options 	= { width=80, height=128, numFrames=40, sheetContentWidth=3612, sheetContentHeight=1072 }
slingshotleft_sprite_options		= { name = "normalRun", start=1, count=40, time=900, loopCount = 1 }

-- SLINGSHOTRIGHT SPRITE
slingshotright_sprite_image			= "resources/images/objects/slingshotright-sprite.png"
slingshotright_imagesheet_options 	= { width=80, height=128, numFrames=40, sheetContentWidth=3612, sheetContentHeight=1072 }
slingshotright_sprite_options		= { name = "normalRun", start=1, count=40, time=900, loopCount = 1 }

-- MAN_YELLOW_RIGHT SPRITE
man_yellow_right_sprite_image				= "resources/images/objects/man-yellow-right-sprite.png"
man_yellow_right_imagesheet_options 		= {  width=250, height=250, numFrames=8, sheetContentWidth=1000, sheetContentHeight=500 }
man_yellow_right_sprite_options				= {{ name = "normalRun", start=1, count=8, time=800, loopCount = 5 }, { name = "moonWalker", frames={ 8,7,6,5,4,3,2,1 }, time=800, loopCount = 5 }}
man_yellow_right_sprite_position_x 			=  -100 - display.contentWidth		
man_yellow_right_sprite_position_y 			= display.contentHeight - 150

-- MAN_GREEN_RIGHT SPRITE
man_green_right_sprite_image				= "resources/images/objects/man-green-right-sprite.png"
man_green_right_imagesheet_options 			= {  width=250, height=250, numFrames=8, sheetContentWidth=1000, sheetContentHeight=500}
man_green_right_sprite_options				= {{ name = "normalRun", start=1, count=8, time=800, loopCount = 5 }, { name = "moonWalker", frames={ 8,7,6,5,4,3,2,1 }, time=800, loopCount = 5 }}
man_green_right_sprite_position_x 			= display.contentCenterX 		
man_green_right_sprite_position_y 			= display.contentHeight - 150

-- MAN_YELLOW_LEFT SPRITE
man_yellow_left_sprite_image				= "resources/images/objects/man-yellow-left-sprite.png"
man_yellow_left_imagesheet_options 			= {  width=250, height=250, numFrames=8, sheetContentWidth=1000, sheetContentHeight=500 }
man_yellow_left_sprite_options				= {{ name = "normalRun", start=1, count=8, time=800, loopCount = 5 }, { name = "moonWalker", frames={ 8,7,6,5,4,3,2,1 }, time=800, loopCount = 5 }}
man_yellow_left_sprite_position_x 			= display.contentWidth - 150		
man_yellow_left_sprite_position_y 			= display.contentHeight - 150

-- MAN_GREEN_LEFT SPRITE
man_green_left_sprite_image					= "resources/images/objects/man-green-left-sprite.png"
man_green_left_imagesheet_options 			= { width=250, height=250, numFrames=8, sheetContentWidth=1000, sheetContentHeight=500 }
man_green_left_sprite_options				= {{ name = "normalRun", start=1, count=8, time=800, loopCount = 5 }, { name = "moonWalker", frames={ 8,7,6,5,4,3,2,1 }, time=800, loopCount = 5 }}
man_green_left_sprite_position_x 			= display.contentWidth - 150		
man_green_left_sprite_position_y 			= display.contentHeight - 150
