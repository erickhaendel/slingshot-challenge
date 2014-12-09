------------------------------------------------------------------------------------------------------------------------------
-- can_disposal.lua
-- Description:
-- @author Samuel Martins <samuellunamartins@gmail.com>
-- @modified 
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

local configuration = require( "src.singleplayer.singleplayer_settings" )

local invertido = math.random(0,1)
print( invertido.."esta invertendo?" )

if invertido == 0 then
	p1scene1 = 1;
	p2scene1 = 2;
	p1scene2 = 3;
	p2scene2 = 4;
else
	p1scene1 = 2;
	p2scene1 = 1;
	p1scene2 = 4;
	p2scene2 = 3;
end


function prepare_can_organization(  )

	local can_organization = {}
	can_organization[p1scene1] = {} --player1
	can_organization[p2scene1] = {} --player2
	can_organization[p1scene2] = {} --player1
	can_organization[p2scene2] = {} --player2

	can_organization[p1scene1][ 1] = {1,0,1,0}
	can_organization[p1scene1][ 2] = {0,1,1,0} 
	can_organization[p1scene1][ 3] = {1,0,0,1} 
	can_organization[p1scene1][ 4] = {1,1,0,0}	
	can_organization[p1scene1][ 5] = {0,0,1,0} 
	can_organization[p1scene1][ 6] = {1,0,1,0}
	can_organization[p1scene1][ 7] = {1,0,0,1}
	can_organization[p1scene1][ 8] = {1,0,0,0}	
	can_organization[p1scene1][ 9] = {0,1,1,0} 
	can_organization[p1scene1][10] = {0,1,1,0}
	can_organization[p1scene1][11] = {0,1,0,1}
	can_organization[p1scene1][12] = {0,1,0,0}	
	can_organization[p1scene1][13] = {0,0,1,1}
	can_organization[p1scene1][14] = {0,0,1,0}
	can_organization[p1scene1][15] = {0,0,0,1}
	can_organization[p1scene1][16] = {1,1,0,0}	
	can_organization[p1scene1][17] = {1,0,1,0}
	can_organization[p1scene1][18] = {1,0,0,1}
	can_organization[p1scene1][19] = {0,0,0,1}
	can_organization[p1scene1][20] = {0,1,0,1}	

	can_organization[p2scene1][ 1] = {1,1,1,1}
	can_organization[p2scene1][ 2] = {1,1,1,1} 
	can_organization[p2scene1][ 3] = {1,1,1,1} 
	can_organization[p2scene1][ 4] = {1,1,1,1}	
	can_organization[p2scene1][ 5] = {0,1,1,0} 
	can_organization[p2scene1][ 6] = {1,1,1,1}
	can_organization[p2scene1][ 7] = {1,1,1,1}
	can_organization[p2scene1][ 8] = {1,1,0,0}	
	can_organization[p2scene1][ 9] = {1,1,1,1} 
	can_organization[p2scene1][10] = {1,1,1,1}
	can_organization[p2scene1][11] = {1,1,1,1}
	can_organization[p2scene1][12] = {1,1,0,0}	
	can_organization[p2scene1][13] = {1,1,1,1}
	can_organization[p2scene1][14] = {0,0,1,1}
	can_organization[p2scene1][15] = {0,1,0,1}
	can_organization[p2scene1][16] = {1,1,1,1}	
	can_organization[p2scene1][17] = {1,1,1,1}
	can_organization[p2scene1][18] = {1,1,1,1}
	can_organization[p2scene1][19] = {1,0,0,1}
	can_organization[p2scene1][20] = {1,1,1,1}		

	can_organization[p1scene2][ 1] = {1,0,1,0}
	can_organization[p1scene2][ 2] = {0,1,1,0} 
	can_organization[p1scene2][ 3] = {1,0,0,1} 
	can_organization[p1scene2][ 4] = {1,1,0,0}	
	can_organization[p1scene2][ 5] = {0,0,1,0} 
	can_organization[p1scene2][ 6] = {1,0,1,0}
	can_organization[p1scene2][ 7] = {1,0,0,1}
	can_organization[p1scene2][ 8] = {1,0,0,0}	
	can_organization[p1scene2][ 9] = {0,1,1,0} 
	can_organization[p1scene2][10] = {0,1,1,0}
	can_organization[p1scene2][11] = {0,1,0,1}
	can_organization[p1scene2][12] = {0,1,0,0}	
	can_organization[p1scene2][13] = {0,0,1,1}
	can_organization[p1scene2][14] = {0,0,1,0}
	can_organization[p1scene2][15] = {0,0,0,1}
	can_organization[p1scene2][16] = {1,1,0,0}	
	can_organization[p1scene2][17] = {1,0,1,0}
	can_organization[p1scene2][18] = {1,0,0,1}
	can_organization[p1scene2][19] = {0,0,0,1}
	can_organization[p1scene2][20] = {0,1,0,1}	

	can_organization[p2scene2][ 1] = {1,1,1,1}
	can_organization[p2scene2][ 2] = {1,1,1,1} 
	can_organization[p2scene2][ 3] = {1,1,1,1} 
	can_organization[p2scene2][ 4] = {1,1,1,1}	
	can_organization[p2scene2][ 5] = {0,1,1,0} 
	can_organization[p2scene2][ 6] = {1,1,1,1}
	can_organization[p2scene2][ 7] = {1,1,1,1}
	can_organization[p2scene2][ 8] = {1,1,0,0}	
	can_organization[p2scene2][ 9] = {1,1,1,1} 
	can_organization[p2scene2][10] = {1,1,1,1}
	can_organization[p2scene2][11] = {1,1,1,1}
	can_organization[p2scene2][12] = {1,1,0,0}	
	can_organization[p2scene2][13] = {1,1,1,1}
	can_organization[p2scene2][14] = {0,0,1,1}
	can_organization[p2scene2][15] = {0,1,0,1}
	can_organization[p2scene2][16] = {1,1,1,1}	
	can_organization[p2scene2][17] = {1,1,1,1}
	can_organization[p2scene2][18] = {1,1,1,1}
	can_organization[p2scene2][19] = {1,0,0,1}
	can_organization[p2scene2][20] = {1,1,1,1}	

	return can_organization
end
