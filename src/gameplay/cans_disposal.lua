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

function prepare_cans_disposition(  )

	local cans_disposal = {}
	cans_disposal[1] = {} --player1
	cans_disposal[2] = {} --player2
	cans_disposal[3] = {} --player1
	cans_disposal[4] = {} --player2

	cans_disposal[1][ 1] = {1,0,1,0}
	cans_disposal[1][ 2] = {0,1,1,0} 
	cans_disposal[1][ 3] = {1,0,0,1} 
	cans_disposal[1][ 4] = {1,1,0,0}	
	cans_disposal[1][ 5] = {0,0,1,0} 
	cans_disposal[1][ 6] = {1,0,1,0}
	cans_disposal[1][ 7] = {1,0,0,1}
	cans_disposal[1][ 8] = {1,0,0,0}	
	cans_disposal[1][ 9] = {0,1,1,0} 
	cans_disposal[1][10] = {0,1,1,0}
	cans_disposal[1][11] = {0,1,0,1}
	cans_disposal[1][12] = {0,1,0,0}	
	cans_disposal[1][13] = {0,0,1,1}
	cans_disposal[1][14] = {0,0,1,0}
	cans_disposal[1][15] = {0,0,0,1}
	cans_disposal[1][16] = {1,1,0,0}	
	cans_disposal[1][17] = {1,0,1,0}
	cans_disposal[1][18] = {1,0,0,1}
	cans_disposal[1][19] = {0,0,0,1}
	cans_disposal[1][20] = {0,1,0,1}	

	cans_disposal[2][ 1] = {1,1,1,1}
	cans_disposal[2][ 2] = {1,1,1,1} 
	cans_disposal[2][ 3] = {1,1,1,1} 
	cans_disposal[2][ 4] = {1,1,1,1}	
	cans_disposal[2][ 5] = {0,1,1,0} 
	cans_disposal[2][ 6] = {1,1,1,1}
	cans_disposal[2][ 7] = {1,1,1,1}
	cans_disposal[2][ 8] = {1,1,0,0}	
	cans_disposal[2][ 9] = {1,1,1,1} 
	cans_disposal[2][10] = {1,1,1,1}
	cans_disposal[2][11] = {1,1,1,1}
	cans_disposal[2][12] = {1,1,0,0}	
	cans_disposal[2][13] = {1,1,1,1}
	cans_disposal[2][14] = {0,0,1,1}
	cans_disposal[2][15] = {0,1,0,1}
	cans_disposal[2][16] = {1,1,1,1}	
	cans_disposal[2][17] = {1,1,1,1}
	cans_disposal[2][18] = {1,1,1,1}
	cans_disposal[2][19] = {1,0,0,1}
	cans_disposal[2][20] = {1,1,1,1}		

	cans_disposal[3][ 1] = {1,0,1,0}
	cans_disposal[3][ 2] = {0,1,1,0} 
	cans_disposal[3][ 3] = {1,0,0,1} 
	cans_disposal[3][ 4] = {1,1,0,0}	
	cans_disposal[3][ 5] = {0,0,1,0} 
	cans_disposal[3][ 6] = {1,0,1,0}
	cans_disposal[3][ 7] = {1,0,0,1}
	cans_disposal[3][ 8] = {1,0,0,0}	
	cans_disposal[3][ 9] = {0,1,1,0} 
	cans_disposal[3][10] = {0,1,1,0}
	cans_disposal[3][11] = {0,1,0,1}
	cans_disposal[3][12] = {0,1,0,0}	
	cans_disposal[3][13] = {0,0,1,1}
	cans_disposal[3][14] = {0,0,1,0}
	cans_disposal[3][15] = {0,0,0,1}
	cans_disposal[3][16] = {1,1,0,0}	
	cans_disposal[3][17] = {1,0,1,0}
	cans_disposal[3][18] = {1,0,0,1}
	cans_disposal[3][19] = {0,0,0,1}
	cans_disposal[3][20] = {0,1,0,1}	

	cans_disposal[4][ 1] = {1,1,1,1}
	cans_disposal[4][ 2] = {1,1,1,1} 
	cans_disposal[4][ 3] = {1,1,1,1} 
	cans_disposal[4][ 4] = {1,1,1,1}	
	cans_disposal[4][ 5] = {0,1,1,0} 
	cans_disposal[4][ 6] = {1,1,1,1}
	cans_disposal[4][ 7] = {1,1,1,1}
	cans_disposal[4][ 8] = {1,1,0,0}	
	cans_disposal[4][ 9] = {1,1,1,1} 
	cans_disposal[4][10] = {1,1,1,1}
	cans_disposal[4][11] = {1,1,1,1}
	cans_disposal[4][12] = {1,1,0,0}	
	cans_disposal[4][13] = {1,1,1,1}
	cans_disposal[4][14] = {0,0,1,1}
	cans_disposal[4][15] = {0,1,0,1}
	cans_disposal[4][16] = {1,1,1,1}	
	cans_disposal[4][17] = {1,1,1,1}
	cans_disposal[4][18] = {1,1,1,1}
	cans_disposal[4][19] = {1,0,0,1}
	cans_disposal[4][20] = {1,1,1,1}	

	return cans_disposal
end
