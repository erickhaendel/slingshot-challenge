
module(..., package.seeall)

require( "src.infra.includeall" )
local configuration = require( "src.gameplay.configuration" )

_W = display.contentWidth;
_H = display.contentHeight;

-- ANIMATION CONFIG
camera_velocity = 10
time_hide_title_player_label = 64000 / camera_velocity
time_delay_toshow_slingshot = 48000 / camera_velocity

time_cantile_animation_delay = 1000
time_cantile_transition_delay = 500

-- Projecttile
projecttile_torque = 100
projecttile_scale = 1.1
projecttile_variation = 0.03
projecttile_force_multiplier = 10
-----------------------
-- ASSETS
-----------------------

-- HOUSE
house_position_x = display.contentCenterX - 540 
house_position_y = display.contentCenterY - 280
house_image_filename = "resources/images/objects/house.png"

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