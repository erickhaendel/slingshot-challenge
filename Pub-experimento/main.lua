require "pubnub"
widget = require "widget" 

local multiplayer = pubnub.new({
    -- ERICK
    --publish_key   = "pub-c-d23a1f82-3792-4632-8226-b1883069c916", -- erick
    --subscribe_key = "sub-c-afd2e9e0-f898-11e3-aa40-02ee2ddab7fe", -- Erick
    --secret_key    = "sec-c-NDBlYmZkOGEtZjlkNi00ZjBiLWE5OGYtYmM4NjUxZjkyNWY0", -- Erick

    -- SAMUEL
    publish_key     = "pub-c-a0a926e6-bcd6-4a70-9db1-fdd4cd614e94", -- Samuel
    subscribe_key   = "sub-c-a6b57a24-0b82-11e4-9ae5-02ee2ddab7fe", -- Samuel
    secret_key      = "sec-c-NzdmNzQ4NmMtZTg5NS00ZjQ0LTgxYWMtYjU5ZWJhMzg2YmJm", -- Samuel
    ssl             = nil,
    origin          = "pubsub.pubnub.com"
})

-- ERICK
-- local action  = nil
-- local status  = "avaliable"
-- local channel = "world"
-- local id  = "erick1"
-- local username = 'erick'

-- SAMUEL
local action  = nil
local status  = "avaliable"
local channel = "world"
local id  = system.getInfo( "deviceID" ) 
local username = 'slunart'
local array_player_channel = {}

local timerAccepetRequest, timerPrePlaying, timerPlaying

local function initStatus()
    status = "avaliable"
    print(status)
end

local function accepetRequest(message)
    multiplayer:publish({
        channel  = channel,
        message  = {
            action      = "accepetRequest",
            idSender    = id,
            idReceiver  = message.idSender
        },

        callback = function(info)
            -- WAS MESSAGE DELIVERED?
            if info[1] then
                status = "preplaying"
                timerAccepetRequest = timer.performWithDelay( 10000, initStatus)
            else
                print("MESSAGE FAILED BECAUSE -> " .. info[2])
            end
        end
    })
end

local function prePlaying(message)
        multiplayer:publish({
            channel  = channel,
            message  = {
                action      = "playing",
                idSender    = id,
                idReceiver  = message.idSender
            },

            callback = function(info)
                -- WAS MESSAGE DELIVERED?
                if info[1] then
                    status = "playing"
                    thread = false
                    timerPrePlaying = timer.performWithDelay( 10000, initStatus)
                else
                    print("MESSAGE FAILED BECAUSE -> " .. info[2])
                end
            end
        })
end

local function playing(message)
    multiplayer:publish({
        channel  = channel,
        message  = {
            action      = "playing",
            idSender    = id,
            idReceiver  = message.idSender
        },

        callback = function(info)
            -- WAS MESSAGE DELIVERED?
            if info[1] then
                status = "playing"
                timerPlaying = timer.performWithDelay( 10000, initStatus)
            else
                print("MESSAGE FAILED BECAUSE -> " .. info[2])
            end
        end
    })
end


-- Function to handle button events
local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
        multiplayer:publish({
            channel  = channel,
            message  = {
                action      = "request_game",
                idSender    = id,
              --  idReceiver  = array_player_channel[channel][1]
            },
            callback = function(info)
                -- WAS MESSAGE DELIVERED?
                if info[1] then
                    print("MESSAGE DELIVERED SUCCESSFULLY!")
                else
                    print("MESSAGE FAILED BECAUSE -> " .. info[2])
                end
            end
        })
    end
end

--
-- PUBNUB SUBSCRIBE CHANNEL (RECEIVE MESSAGES)
--
multiplayer:subscribe({
    channel  = channel,
    callback = function(message)
        if message.idSender ~= id then
        print("status "..status .." | resposta "..message.action.." |  veio ".. message.idSender)
            if status == "avaliable" then
                if message.action == "request_game"  then
                    accepetRequest(message)
                elseif message.action == "accepetRequest" then
                    if message.idReceiver == id then
                        prePlaying(message)
                    end
                end
            elseif status == "preplaying" then
                 if message.action == "playing" then
                    if message.idReceiver == id then
                        prePlaying(message)
                    end
                end
            elseif status == "playing" then
                 if message.action == "preplaying" then
                    if message.idReceiver == id then
                        if timerAccepetRequest ~= nil then timer.cancel( timerAccepetRequest ) end
                        if timerPrePlaying ~= nil then timer.cancel( timerPrePlaying ) end
                        if timerPlaying ~= nil then timer.cancel( timerPlaying ) end
                        playing(message)
                    end
                elseif message.action == "playing" then
                     if message.idReceiver == id then
                        if timerAccepetRequest ~= nil then timer.cancel( timerAccepetRequest ) end
                        if timerPrePlaying ~= nil then timer.cancel( timerPrePlaying ) end
                        if timerPlaying ~= nil then timer.cancel( timerPlaying ) end
                        playing(message)
                    end
                end
            end
        end
    end,

    errorback = function()
        print("Network Connection Lost")
    end
})

-- Create the widget
local button1 = widget.newButton
{
    left = 100,
    top = 200,
    id = "button1",
    label = "Default",
    onEvent = handleButtonEvent
}