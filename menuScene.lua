--
-- Created by IntelliJ IDEA.
-- User: szymon
-- Date: 28/08/14
-- Time: 15:56
-- To change this template use File | Settings | File Templates.
--


local composer = require("composer")
local menuTextHeight = display.actualContentHeight / 10;
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


-- "scene:create()"
function scene:create(event)

    local sceneGroup = self.view
end


-- "scene:show()"
function scene:show(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif (phase == "did") then
        --sceneGroup.menuLabel = display.newText("MENU", display.actualContentWidth / 2, display.screenOriginY + menuTextHeight * 2, "Arial", menuTextHeight)
        sceneGroup.newGameLabel = display.newText("NEW GAME", display.actualContentWidth / 2+display.screenOriginX, display.screenOriginY + menuTextHeight * 4, "Arial", menuTextHeight / 2);
        sceneGroup.optionsLabel = display.newText("OPTIONS", display.actualContentWidth / 2+display.screenOriginX, display.screenOriginY + menuTextHeight * 5, "Arial", menuTextHeight / 2);
        sceneGroup.highScoresLabel = display.newText("HIGH SCORES", display.actualContentWidth / 2+display.screenOriginX, display.actualContentHeight - menuTextHeight*1.5 , "Arial", menuTextHeight / 4);

        --sceneGroup.menuLabel:setFillColor(2 / 1, 1 / 1, 0.5 / 1)
        sceneGroup.newGameLabel:setFillColor(1 / 2, 1 / 1, 0.5 / 1);
        sceneGroup.optionsLabel:setFillColor(0.25 / 1, 0.5 / 1, 0.5 / 1);
        sceneGroup.highScoresLabel:setFillColor(0.6 / 1, 0.5 / 1, 0.5 / 1);

       -- sceneGroup:insert(sceneGroup.menuLabel);
        sceneGroup:insert(sceneGroup.newGameLabel);
        sceneGroup:insert(sceneGroup.optionsLabel);
        sceneGroup:insert(sceneGroup.highScoresLabel);

        sceneGroup.touchManager = function(event)


            if (event.phase == "began") then
                local options={effect="fade",time=500};
                if (event.target == sceneGroup.newGameLabel) then

                    composer.gotoScene("gameScene",options);

                 elseif(event.target==sceneGroup.highScoresLabel)then
                    composer.gotoScene("highScoresScene");
                elseif(event.target==sceneGroup.optionsLabel)then
                    composer.gotoScene("optionsScene");
                end

                sceneGroup.newGameLabel:removeEventListener("touch", sceneGroup.touchManager);
                sceneGroup.highScoresLabel:removeEventListener("touch", sceneGroup.touchManager);
            end
        end
        sceneGroup.newGameLabel:addEventListener("touch", sceneGroup.touchManager);
        sceneGroup.highScoresLabel:addEventListener("touch", sceneGroup.touchManager);
        sceneGroup.optionsLabel:addEventListener("touch", sceneGroup.touchManager);


    end
end


-- "scene:hide()"
function scene:hide(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif (phase == "did") then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy(event)

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

-- -------------------------------------------------------------------------------

return scene

