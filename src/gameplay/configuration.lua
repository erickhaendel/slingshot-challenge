
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
game_current_turn = 1 			-- 1 rodada possui dois turnos, um para cada player  - NAO_MODIFICAR_VALOR
game_max_allowed_turns = 2 		-- numero maximo de turnos por rodada - PODE_MODIFICAR_VALOR
game_current_player = 1 		-- identifica o jogador que esta jogando no momento  - NAO_MODIFICAR_VALOR
game_current_round = 1 			-- rodada atual - NAO_MODIFICAR_VALOR
game_total_rounds = 1 		 	-- guarda o numero sorteado de rounds - NAO_MODIFICAR_VALOR
game_max_allowed_rounds = 5 	-- numero maximo de rounds em um sorteio - PODE_MODIFICAR_VALOR

-- NETWORK
port = 80
player1_ip = "127.1.1.1"
player2_ip = "127.1.1.1"

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

-- PROJECT TILE TRAJECTORY
local circle_id = 1 									-- contador de pontos da trajetoria
local trajetory = {} 									-- contador de pontos da trajetoria

-----------------------
-- ASSETS
-----------------------

-- HOUSE
house_position_x = display.contentCenterX - 540 				-- posicao do tile casa
house_position_y = display.contentCenterY - 280 				-- poiscao do tile casa
house_image_filename = "resources/images/objects/house.png"		-- nome de arquivo da imagem casa

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
slingshot_image_filename = "resources/images/objects/slingshot.png"
stone_position_x = display.contentCenterX
stone_position_y = slingshot_position_y[1] - 70

-- LINE BAND SLINGSHOT
myLine_x2 = slingshot_position_x[1] - 49
myLine_y2 = slingshot_position_y[1] - 80
myLineBack_x2 = slingshot_position_x[1] + 49
myLineBack_y2 = slingshot_position_y[1] - 80

-- WALL
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

-- CANS
cans_x = {}; cans_y = {}
cans_x[1] = display.contentCenterX - 280
cans_y[1] = display.contentCenterY - 100
cans_x[2] = display.contentCenterX + 280
cans_y[2] = display.contentCenterY - 100
cans_x[3] = display.contentCenterX + 1080
cans_y[3] = display.contentCenterY - 100
cans_x[4] = display.contentCenterX + 1680
cans_y[4] = display.contentCenterY - 100

can_image_dir = "resources/images/objects/"
can_xScale = 0.50; can_yScale =can_xScale
player1_can = "yellow-can.png"
player2_can = "green-can.png"

score_cans_x = {}; score_cans_y = {}
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
sky_x[1] = display.contentCenterX - 1210
sky_y[1] = display.contentCenterY - 280
sky_x[2] = display.contentCenterX + 70
sky_y[2] = display.contentCenterY - 280
sky_x[3] = display.contentCenterX + 1350
sky_y[3] = display.contentCenterY - 280
sky_x[4] = display.contentCenterX + 2630
sky_y[4] = display.contentCenterY - 280
sky_image_filename = "resources/images/objects/sky.png"

-- TITLE PLAYER LABEL
title_player_label_x = {}; title_player_label_y = {}
title_player_label_x[1] = display.contentCenterX
title_player_label_y[1] = display.contentCenterY-280
title_player_label_x[2] = display.contentCenterX + 1400
title_player_label_y[2] = display.contentCenterY-280

-- SCORE PLAYER LABEL
score_player_label_x = {}; score_player_label_y = {}
score_player_label_x[1] = display.contentCenterX - 575
score_player_label_y[1] = display.contentCenterY + 375
score_player_label_x[2] = display.contentCenterX + 430
score_player_label_y[2] = display.contentCenterY + 375
score_player_label_x[3] = display.contentCenterX + 865
score_player_label_y[3] = display.contentCenterY + 375
score_player_label_x[4] = display.contentCenterX + 1870
score_player_label_y[4] = display.contentCenterY + 375