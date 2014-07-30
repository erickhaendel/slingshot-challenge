------------------------------------------------------------------------------------------------------------------------------
-- game.lua
-- Dewcription: tutorial configuration file
-- @author Samuel Martins <samuellunamartins@gmail.com>
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

require( "src.infra.includeall" )

_W = display.contentWidth;
_H = display.contentHeight;

-- PLAYERS
game_score_player = {}			-- NAO_MODIFICAR_VALOR
game_score_player[1] = 0 		-- NAO_MODIFICAR_VALOR
game_score_player[2] = 0 		-- NAO_MODIFICAR_VALOR
game_final_score_player = {} 	-- NAO_MODIFICAR_VALOR
game_final_score_player[1] = 0 	-- NAO_MODIFICAR_VALOR
game_final_score_player[2] = 0 	-- NAO_MODIFICAR_VALOR

-- GAME STATE MACHINE
game_is_shooted = 0 			-- se a pedra foi disparada
game_is_hit = 0 				-- se a lata foi atingida
game_i_am_player_number = 1
game_current_player = 1 		-- identifica o jogador que esta jogando no momento  - NAO_MODIFICAR_VALOR
game_stage = 1

-- ANIMATION CONFIG
camera_velocity = 12 									-- velocidade da animcao de transicao de tela
time_delay_toshow_slingshot = 2400 / camera_velocity   -- tempo de espera para que o estilingue fique pronto para uso

time_cantile_animation_delay = 1000						-- 
time_cantile_transition_delay = 500						--

-- Projecttile
projecttile_torque = 100 								-- força de rotacao da pedra
projecttile_scale = 1.1 								-- escala da pedra
projecttile_variation = 0.03 							-- variacao da escala da pedra ao ser lancada
projecttile_force_multiplier = 10 						-- valor que multiplica a forca em cada eixo
projectile_object = nil
assets_image_object = nil 								-- objeto com todos os elementos atuais do cenario
state_object = nil 										-- maquina de estados do tutorial

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
grass_image_filename = 'resources/images/objects/grass2.png'
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
cans_x[1] = display.contentCenterX - 280
cans_y[1] = display.contentCenterY - 40
cans_x[2] = display.contentCenterX + 280
cans_y[2] = cans_y[1]
cans_x[3] = display.contentCenterX + 1080
cans_y[3] = cans_y[1]
cans_x[4] = display.contentCenterX + 1680
cans_y[4] = cans_y[1]

can_image_dir = "resources/images/objects/"		-- diretorio onde estao as imagens das latas
can_xScale = 1.00; 
can_yScale = can_xScale		-- escala da lata na parede
can_width = 40 * can_xScale
can_height = 85 * can_yScale
player1_can = "yellow-can.png"					-- imagem da lata do player 1
player2_can = "green-can.png"					-- imagem da lata do player 2
neutral_can = "white-can.png"					-- imagem da lata neutra
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
title_player_label_x[1] = display.contentCenterX
title_player_label_y[1] = display.contentCenterY-280
title_player_label_x[2] = display.contentCenterX + 1400
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

-- HAND
hand_position_x = display.contentWidth - 100 					-- posicao do tile hand
hand_position_y = 100
hand_image_filename = "resources/images/objects/hand.png"		-- nome de arquivo da imagem hand


-- SMOKE SPRITE
smoke_sprite_image			= "resources/images/objects/smoke-sprite.png"
smoke_imagesheet_options 	= { width=128, height=128, numFrames=40, sheetContentWidth=1024, sheetContentHeight=1024 }
smoke_sprite_options		= { name = "normalRun", start=1, count=40, time=900, loopCount = 1 }

-- DONOTTOUCH SPRITE
donottouch_sprite_image			= "resources/images/objects/donottouch-sprite.png"
donottouch_imagesheet_options 	= { width=100, height=100, numFrames=5, sheetContentWidth=500, sheetContentHeight=100 }
donottouch_sprite_options		= { name = "normalRun", start=1, count=5, time=400, loopCount = 1 }

-- CHECKED SPRITE
checked_sprite_image			= "resources/images/objects/checked-sprite.png"
checked_imagesheet_options 		= { width=236, height=213, numFrames=5, sheetContentWidth=1180, sheetContentHeight=213 }
checked_sprite_options			= { name = "normalRun", start=1, count=5, time=900, loopCount = 1 }
checked_sprite_position_x 		= display.contentCenterX 		
checked_sprite_position_y 		= display.contentCenterY 

-- MAN_YELLOW_RIGHT SPRITE
man_yellow_right_sprite_image				= "resources/images/objects/man-yellow-right-sprite.png"
man_yellow_right_imagesheet_options 		= {  width=250, height=250, numFrames=8, sheetContentWidth=1000, sheetContentHeight=500 }
man_yellow_right_sprite_options				= {{ name = "normalRun", start=1, count=8, time=800, loopCount = 5 }, { name = "moonWalker", frames={ 8,7,6,5,4,3,2,1 }, time=800, loopCount = 5 }}
man_yellow_right_sprite_position_x 			= 100		
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
man_yellow_left_sprite_position_x 			= display.contentCenterX 		
man_yellow_left_sprite_position_y 			= display.contentHeight - 150

-- MAN_GREEN_LEFT SPRITE
man_green_left_sprite_image					= "resources/images/objects/man-green-left-sprite.png"
man_green_left_imagesheet_options 			= { width=250, height=250, numFrames=8, sheetContentWidth=1000, sheetContentHeight=500 }
man_green_left_sprite_options				= {{ name = "normalRun", start=1, count=8, time=800, loopCount = 5 }, { name = "moonWalker", frames={ 8,7,6,5,4,3,2,1 }, time=800, loopCount = 5 }}
man_green_left_sprite_position_x 			= display.contentCenterX 		
man_green_left_sprite_position_y 			= display.contentHeight - 150

-- ARROW_UPWARDS SPRITE
arrow_0_sprite_image			= "resources/images/objects/arrow-0-sprite.png"
arrow_0_imagesheet_options 	= { width=82, height=350, numFrames=4, sheetContentWidth=82, sheetContentHeight=1400 }
arrow_0_sprite_options		= { name = "normalRun", start=1, count=4, time=900 }

-- ARROW DIAGONAL UPWARDS TO THE RIGHT SPRITE
arrow_45_sprite_image			= "resources/images/objects/arrow-45-sprite.png"
arrow_45_imagesheet_options 	= { width=350, height=350, numFrames=4, sheetContentWidth=350, sheetContentHeight=1400 }
arrow_45_sprite_options		= { name = "normalRun", start=1, count=40, time=900 }

-- ARROW TO THE RIGHT SPRITE
arrow_90_sprite_image			= "resources/images/objects/arrow-90-sprite.png"
arrow_90_imagesheet_options 	= {  width=350, height=82, numFrames=4, sheetContentWidth=1400, sheetContentHeight=82 }
arrow_90_sprite_options		= { name = "normalRun", start=1, count=40, time=900 }

-- ARROW DIAGONAL DOWNWARDS TO THE RIGHT SPRITE
arrow_135_sprite_image			= "resources/images/objects/arrow-135-sprite.png"
arrow_135_imagesheet_options 	= { width=350, height=350, numFrames=4, sheetContentWidth=1400, sheetContentHeight=350 }
arrow_135_sprite_options		= { name = "normalRun", start=1, count=40, time=900 }

-- ARROW DOWN SPRITE
arrow_180_sprite_image			= "resources/images/objects/arrow-180-sprite.png"
arrow_180_imagesheet_options 	= { width=85, height=350, numFrames=4, sheetContentWidth=85, sheetContentHeight=1400 }
arrow_180_sprite_options		= { name = "normalRun", start=1, count=40, time=900 }

-- ARROW DIAGONAL DOWNWARDS TO THE LEFT SPRITE
arrow_45_sprite_image			= "resources/images/objects/arrow-225-sprite.png"
arrow_45_imagesheet_options 	= { width=350, height=350, numFrames=4, sheetContentWidth=350, sheetContentHeight=1400 }
arrow_45_sprite_options		= { name = "normalRun", start=1, count=40, time=900 }

-- ARROW TO THE LEFT SPRITE
arrow_90_sprite_image			= "resources/images/objects/arrow-270-sprite.png"
arrow_90_imagesheet_options 	= { width=350, height=85, numFrames=4, sheetContentWidth=1400, sheetContentHeight=85 }
arrow_90_sprite_options		= { name = "normalRun", start=1, count=40, time=900 }

-- ARROW DIAGONAL UPWARDS TO THE LEFT SPRITE
arrow_135_sprite_image			= "resources/images/objects/arrow-315-sprite.png"
arrow_135_imagesheet_options 	= { width=350, height=350, numFrames=4, sheetContentWidth=1400, sheetContentHeight=350 }
arrow_135_sprite_options		= { name = "normalRun", start=1, count=40, time=900 }