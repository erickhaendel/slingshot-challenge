------------------------------------------------------------------------------------------------------------------------------
-- main.lua
-- Dewcription: Lauch file
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

-------------------------------------------
-- LIBs
-------------------------------------------
require( "src.infra.includeall" )

math.randomseed( os.time() )

display.setStatusBar( display.HiddenStatusBar )

-----------------------------------------
-- DEBUG MODE
-----------------------------------------
-- Determine if running on Corona Simulator
--
isSimulator = "simulator" == system.getInfo("environment")
if system.getInfo( "platformName" ) == "Mac OS X" then isSimulator = false; end

-- Native Text Fields not supported on Simulator
--
if isSimulator then
    player_name = "Debug Player"  
end 

-------------------------------------------
-- NEXT SCENE
-------------------------------------------
composer.gotoScene('src.management.welcome', "fade", 0 )

