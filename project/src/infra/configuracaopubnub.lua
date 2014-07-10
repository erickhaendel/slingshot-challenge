require "pubnub"

-- Handler that gets notified when the alert closes
local function onComplete( event )
    if "clicked" == event.action then
        local i = event.index
        if 1 == i then
                -- Do nothing; dialog will simply dismiss
        end
    end
end

multiplayer = pubnub.new({
    publish_key   = "pub-c-3dd0f6d7-d780-4f40-aebe-1366e8b49005",
    subscribe_key = "sub-c-63ae1e86-4ad3-11e3-aab4-02ee2ddab7fe",
    secret_key    = "sec-c-NWRiNGRmYjgtMmQzYy00MDZmLWExMjItM2E0ZDI5YjZlMjYx",
    ssl           = nil,
    origin        = "pubsub.pubnub.com"
})

multiplayer:subscribe({
    channel  = "jogodavelha",
    callback = function(message)

        if(message[my_player_id] == "login_sucesso") then
          setLogin(1)
        end
        
        if(message[my_player_id] == "login_erro") then
          setLogin(0)
        end
                
        if(message[my_player_id] == "logoff_sucesso") then
          setLogin(0)
        end

        if(message[my_player_id] == "logoff_erro") then
          
        end
        
        if(message[my_player_id] == "cadastro_sucesso") then
          setCadastro(1)          
        end    
        
        if(message[my_player_id] == "cadastro_erro") then
          setCadastro(0)
        end 
        
        if(message[my_player_id] == "score_enviado_sucesso") then
          
        end  
        
        if(message[my_player_id] == "score_enviado_erro") then
          
        end        
    end,
    errorback = function()
--        print("Oh nao!!! A conexao 3G caiu!")
        local alert = native.showAlert( "Conexão", "Oh nao!!! A conexao 3G caiu!", { "OK" }, onComplete )         
    end
})

function send_pubnub(text)
    multiplayer:publish({
        channel = "jogodavelha",
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
        channel = "jogodavelha",
        callback = function(message) 

            timer.performWithDelay ( 1000, request_pubnub) 
        end,
        errorback = function() 
            print("Network Connection Lost") 
            local conexao_erro2 = native.showAlert( "Conexão", "Erro, sem conexão com o servidor", { "OK" }, onComplete )            
        end         
        })
end