--
-- Created by IntelliJ IDEA.
-- User: szymon
-- Date: 01/09/14
-- Time: 08:53
-- To change this template use File | Settings | File Templates.
--

local composer = require("composer");
local scoresEditorCreator = require("scoresEditorCreator");
local scene = composer.newScene();

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


-- "scene:create()"
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



        sceneGroup.scoresEditor = scoresEditorCreator.new("scores.json")
        sceneGroup.scoresEditor.read();
        sceneGroup.scoresEditor.decode();
        sceneGroup.highScores = sceneGroup.scoresEditor.string;
        sceneGroup.position = 0;

        if (sceneGroup.highScores == nil) then
            sceneGroup.scoresEditor.refresh(event.params.score);
            sceneGroup.scoresEditor.encode();
            sceneGroup.scoresEditor.write();
            sceneGroup.position = 1;

        else
            local position = 0;
            for i = 1, #sceneGroup.highScores.scores do
                if (sceneGroup.highScores.scores[i] < event.params.score) then
                    position=i
                    break;
                end
            end

            if (position == 0 and #sceneGroup.highScores.scores < 10) then

                position = #sceneGroup.highScores.scores + 1;
            end
            sceneGroup.position=position;

            sceneGroup.scoresEditor.refresh(event.params.score);

            sceneGroup.scoresEditor.encode();
            sceneGroup.scoresEditor.write();
        end



            sceneGroup.scoresEditor.removeMe();






        -- Called when the scene is still off screen (but is about to come on screen).
    elseif (phase == "did") then

        local centralX=display.actualContentWidth/2+display.screenOriginX;
        local centralY=display.actualContentHeight/2+display.screenOriginY;
        local textH=display.actualContentHeight/20;
        composer.removeHidden();
        print(sceneGroup.position);


        sceneGroup.label=nil;

        if(sceneGroup.position==0)then
        sceneGroup.label=display.newText("YOU LOST",centralX,centralY,"Arial",textH);

        else
            sceneGroup.label=display.newText("HIGH SCORE!",centralX,centralY,"Arial",textH);
            sceneGroup.label:setFillColor(0.7,0.7,0);
            local mark;
            local color;
            if sceneGroup.position==1 then mark="st";
                color={0.99,0.99,0};
                elseif(sceneGroup.position==2) then mark="nd";
                color={0.7,0.7,0.7}
                elseif(sceneGroup.position==3) then mark="rd";
                color={0.8,0.6,0.5}
                else mark="th";
                color={0.4,0.4,0.4}


            end

            sceneGroup.label2=display.newText(sceneGroup.position..mark.." place!",centralX,centralY+textH,"Arial",textH);
            sceneGroup.label2:setFillColor(unpack(color));
            sceneGroup:insert(sceneGroup.label2);

        end


        sceneGroup:insert(sceneGroup.label);
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