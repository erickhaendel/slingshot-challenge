------------------------------------------------------------------------------------------------------------------------------
-- game.lua
-- Dewcription: menu configuration file
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

------------------------------------------------
-- IMAGES 									  --
------------------------------------------------

-- BUTTONS IMAGES
signup_button_image 		= "resources/images/buttons/signup.png"
login_button_image 			= "resources/images/buttons/login.png"
cancel_button_image 		= "resources/images/buttons/cancel.png"
back_button_image 			= "resources/images/buttons/back.png"
menu_button_image 			= "resources/images/buttons/menu.png"
confirm_button_image 		= "resources/images/buttons/confirm.png"
ok_button_image 			= "resources/images/buttons/ok.png"
play_button_image 			= "resources/images/buttons/play.png"
singleplayer1_button_image 	= "resources/images/buttons/singleplayer1.png"
singleplayer2_button_image 	= "resources/images/buttons/singleplayer2.png"
singleplayer3_button_image  = "resources/images/buttons/singleplayer3.png"
singleplayer4_button_image 	= "resources/images/buttons/singleplayer4.png"
singleplayer4_button_image  = "resources/images/buttons/singleplayer4.png"
tit_for_tat_button_image    = "resources/images/buttons/tit-for-tat.png"
random_tit_for_tat_button_image  = "resources/images/buttons/randon-tit-for-tat.png"
generous_tit_for_tat_button_image  = "resources/images/buttons/generous-tit-for-tat.png"
full_random_button_image  = "resources/images/buttons/full_random.png"
tutorial_button_image 		= "resources/images/buttons/tutorial.png"
invite_button_image 		= "resources/images/buttons/invite.png"
settings_button_image 		= "resources/images/buttons/settings.png"
credits_button_image 		= "resources/images/buttons/credits.png"
about_button_image 			= "resources/images/buttons/about.png"
more_button_image 			= "resources/images/buttons/more.png"
less_button_image 			= "resources/images/buttons/less.png"

-- BACKGROUND IMAGES
signup_background_image 	= "resources/images/backgrounds/signup.png"
login_background_image 		= "resources/images/backgrounds/login.png"
menu_background_image 		= "resources/images/backgrounds/menu.png"
welcome_background_image 	= "resources/images/backgrounds/welcome.png"
settings_background_image 	= "resources/images/backgrounds/settings.png"
credits_background_image 	= "resources/images/backgrounds/credits.png"
about_background_image 		= "resources/images/backgrounds/about.png"
results_background_image	= "resources/images/backgrounds/results.png"

-- SPRITES
results_sprite_image	= "resources/images/backgrounds/results-sprite.jpg"

------------------------------------------------
-- AUDIOS 									  --
------------------------------------------------

-- AUDIO MENU
background_sound_theme 				= "resources/audio/songs/menu.wav"
background_config_sound_theme 		= { channel=1, loops=-1, fadein=5000 }
background_sound_theme_volume_level = 0.5
press_button_sound					= ""

------------------------------------------------
-- POSITIONS, FONTS, COLORS, TYPES, SIZES	  --
------------------------------------------------

-- MENU_SCENE OBJECT POSITIONS

tutorial_button_x			= display.contentCenterX/2 + 750
tutorial_button_y			= display.contentCenterY - 50
play_button_x				= display.contentCenterX/2 - 100
play_button_y				= display.contentCenterY + 200
singleplayer1_button_x		= display.contentCenterX/2 - 100
singleplayer1_button_y		= display.contentCenterY  -- img 3
singleplayer2_button_x		= display.contentCenterX/2 - 100 
singleplayer2_button_y		= display.contentCenterY -200 -- img 1
singleplayer3_button_x		= display.contentCenterX/2 - 100 
singleplayer3_button_y		= display.contentCenterY + 100 --img 4
singleplayer4_button_x		= display.contentCenterX/2 - 100
singleplayer4_button_y		= display.contentCenterY -100 -- img 2

about_button_x				= display.contentCenterX/2 - 100
about_button_y				= display.contentCenterY + 280
credits_button_x			= display.contentCenterX - 100
credits_button_y			= display.contentCenterY + 280
settings_button_x			= display.contentCenterX/2 + 750
settings_button_y			= display.contentCenterY + 100


-- LOGIN SCENE OBJECT POSITIONS

login_email_field_x				= display.contentCenterX + 150
login_email_field_y				= display.contentCenterY - 50
login_email_size_field			= 320

login_password_field_x 			= display.contentCenterX + 150
login_password_field_y			= display.contentCenterY + 30
login_password_size_field		= 320

login_cancel_button_x			= display.contentCenterX - 200
login_cancel_button_y			= display.contentCenterY + 200

login_send_button_x				= display.contentCenterX + 200
login_send_button_y				= display.contentCenterY + 200

-- SIGNUP SCENE OBJECT POSITIONS
signup_username_field_x			= display.contentCenterX + 150
signup_username_field_y			= display.contentCenterY - 50
signup_username_size_field		= 320

signup_password_field_x 		= display.contentCenterX + 150
signup_password_field_y			= display.contentCenterY + 30
signup_password_size_field		= 320

signup_email_field_x			= display.contentCenterX + 150
signup_email_field_y			= display.contentCenterY - 50
signup_email_size_field			= 320

signup_age_field_x 				= display.contentCenterX + 150
signup_age_field_y				= display.contentCenterY + 30
signup_age_size_field			= 320

signup_gender_field_x 			= display.contentCenterX + 150
signup_gender_field_y			= display.contentCenterY + 30
signup_gender_size_field		= 320

signup_cancel_button_x			= display.contentCenterX - 200
signup_cancel_button_y			= display.contentCenterY + 200

signup_send_button_x			= display.contentCenterX + 200
signup_send_button_y			= display.contentCenterY + 200

--PRE GAMEPLAY SCENE
pregameplay_menu_button_x		= display.contentCenterX - 500
pregameplay_menu_button_y		= display.contentCenterY + 280

pregameplay_play_button_x		= display.contentCenterX
pregameplay_play_button_y		= display.contentCenterY + 280

pregameplay_status_label_x		= display.contentCenterX
pregameplay_status_label_y		= display.contentCenterY - 100
pregameplay_status_font_size 	= 72
pregameplay_status_font_name	= native.systemFontBold

-- RESULTS SCENE
results_menu_button_x			= display.contentCenterX
results_menu_button_y			= display.contentCenterY + 300

results_sprite_x				= display.contentWidth/2
results_sprite_y				= display.contentHeight/2

results_font_name				= native.systemFontBold

results_player1_title_label_x	= display.contentCenterX - 400
results_player1_title_label_y	= display.contentCenterY - 100
results_player1_title_font_size = 96

results_player1_score_label_x	= display.contentCenterX - 500
results_player1_score_label_y	= display.contentCenterY + 100
results_player1_score_font_size = 64

results_player2_title_label_x	= display.contentCenterX + 450
results_player2_title_label_y	= display.contentCenterY - 100
results_player2_title_font_size = 96

results_player2_score_label_x	= display.contentCenterX + 400
results_player2_score_label_y	= display.contentCenterY + 100
results_player2_score_font_size = 64

results_imagesheet_options 		= { width=1280, height=800, numFrames=10, sheetContentWidth=1280, sheetContentHeight=8000 }
results_sprite_options			= { name = "normalRun", start=1, count=10, time=900, loopCount = 1 }

-- SETTINGS SCENE
back_settings_button_x			= display.contentCenterX + 400
back_settings_button_y			= display.contentCenterY - 200
rounds_label_x					= display.contentCenterX 
rounds_label_y					= display.contentCenterY
rounds_label_font_name			= native.systemFontBold
rounds_label_font_size			= 64
rounds_number_label_x			= display.contentCenterX
rounds_number_label_y			= display.contentCenterY + 100
rounds_number_label_font_name	= native.systemFontBold
rounds_number_label_font_size	= 64
more_rounds_button_x			= display.contentCenterX + 100
more_rounds_button_y			= display.contentCenterY + 100
less_rounds_button_x			= display.contentCenterX - 100
less_rounds_button_y			= display.contentCenterY + 100
