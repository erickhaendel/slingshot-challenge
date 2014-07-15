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
require("src.network.pubnub")

-- my libs
require( "src.infra.includeall" )

module(..., package.seeall)

publish_key   = "pub-c-a0a926e6-bcd6-4a70-9db1-fdd4cd614e94"
subscribe_key = "sub-c-a6b57a24-0b82-11e4-9ae5-02ee2ddab7fe"
secret_key    = "sec-c-NzdmNzQ4NmMtZTg5NS00ZjQ0LTgxYWMtYjU5ZWJhMzg2YmJm"
ssl           = nil
origin        = "pubsub.pubnub.com"
channel       = "world"
my_device_id  = system.getInfo( "deviceID" )


