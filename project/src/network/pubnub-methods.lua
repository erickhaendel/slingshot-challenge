------------------------------------------------------------------------------------------------------------------------------
-- pubnub-settings.lua
-- Description: 
-- @author Samuel Martins <samuellunamartins@gmail.com>
-- @version 1.00
-- @date 07/14/2014
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

-------------------------------------------
-- LIBs
-------------------------------------------
-- corona libs
require("src.network.pubnub")
local configuration         = require( "src.gameplay.configuration" )

-- my libs
local settings      = require( "src.network.pubnub-settings" )
local player1_obj   = require( "src.player.player1" )
local player2_obj   = require( "src.player.player2" )

require( "src.infra.includeall" )

-- Handler that gets notified when the alert closes
local function onComplete( event )
    if "clicked" == event.action then
        local i = event.index
        if 1 == i then
                -- Do nothing; dialog will simply dismiss
        end
    end
end

-- Cria uma conexao com o servidor PUBNUB com as configurações passadas
multiplayer = pubnub.new({
    publish_key   = settings.publish_key,
    subscribe_key = settings.subscribe_key,
    secret_key    = settings.secret_key,
    ssl           = settings.ssl,
    origin        = settings.origin
})


function disconnect_pubnub()
    multiplayer:unsubscribe({channel  = settings.channel})
end

function receive_pubnub()
    -----------------------------------------
    -- DATABASE SERVER CONNECTION MESSAGES --
    -----------------------------------------

    -- Escuta uma das seguintes mensagens e a trata
    multiplayer:subscribe({
        channel  = settings.channel,
        callback = function(message)

            if(message["msgtext"]) then
                if(message["msgtext"] == "invitetoplay" and configuration.game_i_am_player_number == nil) then  
                    print( "recebeu ".. message["msgtext"] )
                    configuration.game_i_am_player_number = 2
                end
                if message["msgtext"]["projectile"]  then  
                    print( "recebi uma pedra "..message["msgtext"]["projectile"] )
                end
            end

        end,

        errorback = function()
            local alert = native.showAlert( "Alert", "Error", { "OK" }, onComplete )         
        end
    })
    
end

function send_pubnub(text)

    multiplayer:publish({
        channel = settings.channel,
        message = { msgtext = text },
        callback = function(info) 

           -- print( "enviou "..text )
     
            -- WAS MESSAGE DELIVERED? 
            if info[1] then 
                return 1
            else 
                print("MESSAGE FAILED BECAUSE -> " .. info[2]) 
                --local alert = native.showAlert( "Conexão", "MESSAGE FAILED BECAUSE -> " .. info[2], { "OK" }, onComplete )  
                return 0                       
            end 
     
        end         
    })
end


function request_pubnub()
    multiplayer:publish({
        channel = "world",
        callback = function(message) 

            timer.performWithDelay ( 1000, request_pubnub) 
        end,
        errorback = function() 
            print("Network Connection Lost") 
            local conexao_erro2 = native.showAlert( "Conexão", "Erro, sem conexão com o servidor", { "OK" }, onComplete )            
        end         
        })
end