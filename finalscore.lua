-- -------------------------------------------
-- -- LIBs
-- -------------------------------------------

-- require( "includeall" )

-- local scene = storyboard.newScene()

-- local player1ColorLabel, player2ColorLabel, player1ScoreLabel, player2ScoreLabel, player1ScoreText, player2ScoreText

-- local labels = display.newGroup()

-- -----------------------------------------
-- -- Prototype Functions
-- -----------------------------------------

-- local criaTudo, removeTudo

-- removeTudo = function()
--   abstractmenugui.removeMenuTitleImage()   
--   abstractmenugui.removeMenuBodyTextStringBoxLabel() 
--   abstractmenugui.removeMenuBackButton()
--   abstractmenugui.removeMuteSoundButton()
-- end

-- local function finalScore() 
--   local colortemp = nil
--   if player1_slingshot_color == 0 then 
--     colortemp = "yellow"; 
--   else 
--     colortemp = "green"; 
--   end

--   if player2_slingshot_color == 0 then 
--     colortemp = "yellow"; 
--   else 
--     colortemp = "green"; 
--   end

--   local final1 = nil
--   local final2 = nil

--   if     player1_slingshot_color == 1 and player2_slingshot_color == 1 then
--     final1 = player2_score * 2
--     final2 = player1_score * 2

--   elseif player1_slingshot_color == 1 and player2_slingshot_color == 0 then
--     final1 = 0
--     final2 = player1_score * 2 + player2_score

--   elseif player1_slingshot_color == 0 and player2_slingshot_color == 1 then
--     final1 = player2_score * 2 + player1_score
--     final2 = 0

--   elseif player1_slingshot_color == 0 and player2_slingshot_color == 0 then
--     final1 = player1_score
--     final2 = player2_score
--   end

--   local temp1, temp2

--   if player1_slingshot_color == 0 then
--     temp1 = "Keep 1x"..player1_score.."\n"
--   elseif player1_slingshot_color == 1 then
--     temp1 = "2x"..player2_score.." -> player2\n"
--   else
--     temp1 = "error\n"
--   end

--   if player2_slingshot_color == 0 then
--     temp2 = "Keep 1x"..player1_score.."\n"
--   elseif player2_slingshot_color == 1 then
--     temp2 = "2x"..player2_score.." -> player1\n"
--   else
--     temp2 = "error"
--   end

--   local result = "FINAL SCORE\n"..
--     "Player 1".." | ".."Player 2\n"..
--     "Color: "..colortemp.." | ".."Color:"..colortemp.."\n"..
--     "15x"..(player1_score/15).."="..player1_score.." | ".."15x"..(player2_score/15).."="..player2_score.."\n"
--     temp1..final1.." | "..temp2..final2.."\n"

--   return result

-- end

-- criaTudo = function() 

--   local s = display.getCurrentStage()

--   local x = s.contentWidth/2
  
--   abstractmenugui.createMenuTitleImage(x,40)  
--   abstractmenugui.createMenuBodyTextStringBoxLabel(x,230,finalScore()) 
--   abstractmenugui.createMenuBackButton( -150,440,"menu")
--   abstractmenugui.createMuteSoundButton(x + 200,440)
-- end

-- function scene:createScene( event ) 
--   local group = self.view
--   -- Load the background image
--   --local bg = display.newImage( templateBackgroundFile, 160, 160, true )
--   --group:insert( bg )  
--   --criaTudo()  
-- end

-- function scene:enterScene( event )
--   criaTudo()
-- end

-- function scene:exitScene( event )
--   removeTudo()
-- end

-- function scene:destroyScene( event )
--   removeTudo()
-- end

-- ---------------------------------------------------------------------------------
-- -- END OF YOUR IMPLEMENTATION
-- ---------------------------------------------------------------------------------

-- scene:addEventListener( "createScene", scene )
-- scene:addEventListener( "enterScene", scene )
-- scene:addEventListener( "exitScene", scene )
-- scene:addEventListener( "destroyScene", scene )

-- ---------------------------------------------------------------------------------

-- return scene