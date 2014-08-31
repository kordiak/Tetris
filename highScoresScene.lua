--
-- Created by IntelliJ IDEA.
-- User: szymon
-- Date: 28/08/14
-- Time: 16:35
-- To change this template use File | Settings | File Templates.
--


local composer = require("composer");
local scoresEditorCreator = require("scoresEditorCreator");

local scene = composer.newScene();
local tenPercent = display.actualContentHeight / 10;
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


-- "scene:create()"

local backListener = function(event)
    if (event.phase == "began") then
        composer.gotoScene("menuScene");
    end
end
function scene:create(event)

    local sceneGroup = self.view

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        local scoresEditor = scoresEditorCreator.new("scores.json");

        if (scoresEditor.read()) then scoresEditor.decode(); end

        sceneGroup.decodedContent = scoresEditor.string;
        scoresEditor.removeMe()





    elseif (phase == "did") then
        sceneGroup.highScoresLabel = display.newText("HIGH SCORES", display.actualContentWidth / 2 + display.screenOriginX, display.screenOriginY + tenPercent, "Arial", tenPercent / 2);
        sceneGroup.highScoresLabel:setFillColor(0.6, 0.5, 0.5,0.7);
        sceneGroup.backLabel = display.newText("BACK", 0, 0, "Arial", tenPercent / 5)
        sceneGroup.backLabel.x = display.screenOriginX + sceneGroup.backLabel.width;
        sceneGroup.backLabel.y = display.screenOriginY + sceneGroup.backLabel.height;
        sceneGroup.backLabel:setFillColor(0.8, 0.5, 0.5);
        sceneGroup.backLabel:addEventListener("touch", backListener)


        local startPosition=sceneGroup.highScoresLabel.y*2;
        local height = tenPercent /1.5


        sceneGroup.number = {};


        for i = 1, 10  do
            sceneGroup.number[i] = display.newText(i .. ".",0,startPosition+height*i, native.systemFontBold, height);
            if (sceneGroup.decodedContent ~= nil) then
                if (sceneGroup.decodedContent.scores[i] ~= nil) then
                    sceneGroup.number[i].text = sceneGroup.number[i].text .. "  " .. sceneGroup.decodedContent.scores[i];

                end
            end

            sceneGroup.number[i].x = display.screenOriginX+display.actualContentWidth/2

            if i>1 then
                local leftFirst=sceneGroup.number[1].x-sceneGroup.number[1].width/2;
                local leftPresent=sceneGroup.number[i].x-sceneGroup.number[i].width/2;

                local draw=leftPresent-leftFirst;



                sceneGroup.number[i].x=sceneGroup.number[i].x-draw;

            end
            print(sceneGroup.number[i].width , sceneGroup.number[i].x);

           if (i == 10) then
                local text=sceneGroup.number[i].text..'.'
                local len=string.len(text);
                local first=(sceneGroup.number[i].width)/len;
                local oneLen=(sceneGroup.number[i].width+first*3.5)/len;


                sceneGroup.number[i].x = sceneGroup.number[i].x - oneLen;

            end

            sceneGroup.number[i]:setFillColor(0.6/i*3, 0.5/i*3, 0.5);



            sceneGroup:insert(sceneGroup.number[i]);

        end






        sceneGroup:insert(sceneGroup.highScoresLabel)
        sceneGroup:insert(sceneGroup.backLabel);
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

        composer.removeScene("highScoresScene");
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

