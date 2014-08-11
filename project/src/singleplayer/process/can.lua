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

local configuration = require( "src.gameplay.configuration" )

function prepare_can_organization(  )

	local can_organization = {}
	can_organization[1] = {} --player1
	can_organization[2] = {} --player2
	can_organization[3] = {} --player1
	can_organization[4] = {} --player2

	can_organization[1][ 1] = {1,0,1,0}
	can_organization[1][ 2] = {0,1,1,0} 
	can_organization[1][ 3] = {1,0,0,1} 
	can_organization[1][ 4] = {1,1,0,0}	
	can_organization[1][ 5] = {0,0,1,0} 
	can_organization[1][ 6] = {1,0,1,0}
	can_organization[1][ 7] = {1,0,0,1}
	can_organization[1][ 8] = {1,0,0,0}	
	can_organization[1][ 9] = {0,1,1,0} 
	can_organization[1][10] = {0,1,1,0}
	can_organization[1][11] = {0,1,0,1}
	can_organization[1][12] = {0,1,0,0}	
	can_organization[1][13] = {0,0,1,1}
	can_organization[1][14] = {0,0,1,0}
	can_organization[1][15] = {0,0,0,1}
	can_organization[1][16] = {1,1,0,0}	
	can_organization[1][17] = {1,0,1,0}
	can_organization[1][18] = {1,0,0,1}
	can_organization[1][19] = {0,0,0,1}
	can_organization[1][20] = {0,1,0,1}	

	can_organization[2][ 1] = {1,1,1,1}
	can_organization[2][ 2] = {1,1,1,1} 
	can_organization[2][ 3] = {1,1,1,1} 
	can_organization[2][ 4] = {1,1,1,1}	
	can_organization[2][ 5] = {0,1,1,0} 
	can_organization[2][ 6] = {1,1,1,1}
	can_organization[2][ 7] = {1,1,1,1}
	can_organization[2][ 8] = {1,1,0,0}	
	can_organization[2][ 9] = {1,1,1,1} 
	can_organization[2][10] = {1,1,1,1}
	can_organization[2][11] = {1,1,1,1}
	can_organization[2][12] = {1,1,0,0}	
	can_organization[2][13] = {1,1,1,1}
	can_organization[2][14] = {0,0,1,1}
	can_organization[2][15] = {0,1,0,1}
	can_organization[2][16] = {1,1,1,1}	
	can_organization[2][17] = {1,1,1,1}
	can_organization[2][18] = {1,1,1,1}
	can_organization[2][19] = {1,0,0,1}
	can_organization[2][20] = {1,1,1,1}		

	can_organization[3][ 1] = {1,0,1,0}
	can_organization[3][ 2] = {0,1,1,0} 
	can_organization[3][ 3] = {1,0,0,1} 
	can_organization[3][ 4] = {1,1,0,0}	
	can_organization[3][ 5] = {0,0,1,0} 
	can_organization[3][ 6] = {1,0,1,0}
	can_organization[3][ 7] = {1,0,0,1}
	can_organization[3][ 8] = {1,0,0,0}	
	can_organization[3][ 9] = {0,1,1,0} 
	can_organization[3][10] = {0,1,1,0}
	can_organization[3][11] = {0,1,0,1}
	can_organization[3][12] = {0,1,0,0}	
	can_organization[3][13] = {0,0,1,1}
	can_organization[3][14] = {0,0,1,0}
	can_organization[3][15] = {0,0,0,1}
	can_organization[3][16] = {1,1,0,0}	
	can_organization[3][17] = {1,0,1,0}
	can_organization[3][18] = {1,0,0,1}
	can_organization[3][19] = {0,0,0,1}
	can_organization[3][20] = {0,1,0,1}	

	can_organization[4][ 1] = {1,1,1,1}
	can_organization[4][ 2] = {1,1,1,1} 
	can_organization[4][ 3] = {1,1,1,1} 
	can_organization[4][ 4] = {1,1,1,1}	
	can_organization[4][ 5] = {0,1,1,0} 
	can_organization[4][ 6] = {1,1,1,1}
	can_organization[4][ 7] = {1,1,1,1}
	can_organization[4][ 8] = {1,1,0,0}	
	can_organization[4][ 9] = {1,1,1,1} 
	can_organization[4][10] = {1,1,1,1}
	can_organization[4][11] = {1,1,1,1}
	can_organization[4][12] = {1,1,0,0}	
	can_organization[4][13] = {1,1,1,1}
	can_organization[4][14] = {0,0,1,1}
	can_organization[4][15] = {0,1,0,1}
	can_organization[4][16] = {1,1,1,1}	
	can_organization[4][17] = {1,1,1,1}
	can_organization[4][18] = {1,1,1,1}
	can_organization[4][19] = {1,0,0,1}
	can_organization[4][20] = {1,1,1,1}	

	return can_organization
end
