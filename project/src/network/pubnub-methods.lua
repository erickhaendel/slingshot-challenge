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

-------------------------------------------
-- LIBs
-------------------------------------------
-- corona libs
require "pubnub"

-- my libs
local settings = require( "src.network.pubnub-settings" )

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

-- Escuta uma das seguintes mensagens e a trata
multiplayer:subscribe({
    channel  = settings.channel,
    callback = function(message)

    -----------------------------------------
    -- DATABASE SERVER CONNECTION MESSAGES --
    -----------------------------------------
        if(message[settings.my_device_id] == "connexion-successfully-login") then
            -- TODO
        end
        
        if(message[settings.my_device_id] == "connexion-error-login") then
            -- TODO
        end
                
        if(message[settings.my_device_id] == "connexion-successfully-logoff") then
            -- TODO
        end

        if(message[settings.my_device_id] == "connexion-error-logoff") then
            -- TODO
        end
        
        if(message[settings.my_device_id] == "connexion-successfully-signup") then
            -- TODO         
        end    
        
        if(message[settings.my_device_id] == "connexion-error-signup") then
            -- TODO
        end 

    -----------------------------------------
    -- PREGAMEPLAY MESSAGES --
    -----------------------------------------
        if(message[settings.my_device_id] == "letsplay-successfully-request") then
            -- TODO
        end 

        if(message[settings.my_device_id] == "letsplay-error-request") then
            -- TODO
        end     

        if(message[settings.my_device_id] == "letsplay-successfully-acceptedresponse") then
            -- TODO
        end    

        if(message[settings.my_device_id] == "letsplay-error-acceptedresponse") then
            -- TODO
        end   

        if(message[settings.my_device_id] == "letsplay-successfully-rejectedresponse") then
            -- TODO
        end 

        if(message[settings.my_device_id] == "letsplay-error-rejectedresponse") then
            -- TODO
        end 

        if(message[settings.my_device_id] == "letsplay-successfully-agreedproposal") then
            -- TODO
        end  

        if(message[settings.my_device_id] == "letsplay-error-agreedproposal") then
            -- TODO
        end          

    -----------------------------------------
    -- GAMEPLAY MESSAGES --
    -----------------------------------------
        if(message[settings.my_device_id] == "myprojectile-successfully-sent") then
            -- TODO
        end  
        
        if(message[settings.my_device_id] == "myprojectile-error-sent") then
            -- TODO
        end  

        if(message[settings.my_device_id] == "yourprojectile-successfully-received") then
            -- TODO
        end  
        
        if(message[settings.my_device_id] == "yourprojectile-error-received") then
            -- TODO
        end  

        if(message[settings.my_device_id] == "score-successfully-sent") then
            -- TODO
        end  
        
        if(message[settings.my_device_id] == "score-error-sent") then
            -- TODO
        end  

        if(message[settings.my_device_id] == "score-successfully-received") then
            -- TODO
        end  
        
        if(message[settings.my_device_id] == "score-error-received") then
            -- TODO
        end         
    end,
    errorback = function()
--        print("Oh nao!!! A conexao 3G caiu!")
        local alert = native.showAlert( "Conexão", "Oh nao!!! A conexao 3G caiu!", { "OK" }, onComplete )         
    end
})

function send_pubnub(text)
    multiplayer:publish({
        channel = settings.channel,
        message = { msgtext = text },
        callback = function(info) 
     
            -- WAS MESSAGE DELIVERED? 
            if info[1] then 
--                local alert = native.showAlert( "Conexão", "MESSAGE DELIVERED SUCCESSFULLY!", { "OK" }, onComplete )             
--                print("MESSAGE DELIVERED SUCCESSFULLY!") 
            else 
--                print("MESSAGE FAILED BECAUSE -> " .. info[2]) 
                local alert = native.showAlert( "Conexão", "MESSAGE FAILED BECAUSE -> " .. info[2], { "OK" }, onComplete )                         
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