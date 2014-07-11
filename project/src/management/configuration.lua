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
signup_button_image 	= "resources/images/buttons/signup.png"
login_button_image 		= "resources/images/buttons/login.png"
cancel_button_image 	= "resources/images/buttons/cancel.png"
back_button_image 		= "resources/images/buttons/back.png"
confirm_button_image 	= "resources/images/buttons/confirm.png"
ok_button_image 		= "resources/images/buttons/ok.png"
play_button_image 		= "resources/images/buttons/play.png"
settings_button_image 	= "resources/images/buttons/settings.png"
credits_button_image 	= "resources/images/buttons/credits.png"
about_button_image 		= "resources/images/buttons/about.png"

-- BACKGROUND IMAGES
signup_background_image 	= "resources/images/backgrounds/signup.png"
login_background_image 		= "resources/images/backgrounds/login.png"
menu_background_image 		= "resources/images/backgrounds/menu.png"
welcome_background_image 	= "resources/images/backgrounds/welcome.png"
settings_background_image 	= "resources/images/backgrounds/settings.png"
credits_background_image 	= "resources/images/backgrounds/credits.png"
about_background_image 		= "resources/images/backgrounds/about.png"

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

-- LOGIN SCENE OBJECT POSITIONS
login_title_label_x				= display.contentCenterX
login_title_label_y				= display.contentCenterY - 300
login_title_font_size_label		= 36

login_email_label_x				= display.contentCenterX - 150
login_email_label_y				= display.contentCenterY - 200
login_email_font_size_label		= 36

login_email_field_x				= display.contentCenterX + 150
login_email_field_y				= display.contentCenterY - 200
login_email_size_field			= 245

login_password_label_x			= display.contentCenterX - 150
login_password_label_y			= display.contentCenterY - 100
login_password_font_size_label	= 36

login_password_field_x 			= display.contentCenterX + 150
login_password_field_y			= display.contentCenterY - 100
login_password_size_field		= 245

login_cancel_button_x			= display.contentCenterX - 200
login_cancel_button_y			= display.contentCenterY + 50

login_send_button_x				= display.contentCenterX + 200
login_send_button_y				= display.contentCenterY + 50



