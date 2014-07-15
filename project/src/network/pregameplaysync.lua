------------------------------------------------------------------------------------------------------------------------------
-- pregameplay.lua
-- Dewcription: welcome screen
-- @author Samuel <samuellunamartins@gmail.com>
-- @modified 
-- @version 1.00
-- @date 07/15/2014
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

-- this file is a lib!
module(..., package.seeall)

-- my libs
local pubnub_settings 	= require( "src.network.pubnub-settings" )
local pubnub_methods 	= require( "src.network.pubnub-methods" )

function findAvailablePlayer()
	local player2 = pubnub_methods.receive_pubnub("find_available_player")
	return player2
end

function inviteToPlay( player_id )
	local message = '{"service:invitetoplay","id":"'..pubnub_settings.my_device_id..'","guest":"'..player_id..'"}'

	return pubnub_methods.send_pubnub(message)
end

function beGuestToPlay()
	local player2 = pubnub_methods.receive_pubnub("be_guest_to_play")
	return player2
end

function sendUserStatus(status)
	local message = '{"service":"availableplayer","id":"'..pubnub_settings.my_device_id..'","username":"playerdebug","status":"'..status..'"}'

	return pubnub_methods.send_pubnub(message)
end