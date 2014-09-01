--
-- Created by IntelliJ IDEA.
-- User: szymon
-- Date: 28/08/14
-- Time: 15:42
-- To change this template use File | Settings | File Templates.
--


local composer = require("composer")
local figureCreator = require("figureCreator");
local clairvoyantCreator = require("clairvoyantCreator");
local topBarCreate = require("TopBarCreator");
local bonusCreator = require("bonusCreator");
local scoresEditorCreator = require("scoresEditorCreator");
local soundCreator = require("soundCreator");

local heightN = 22;
local widthN = 10;
local planedUpperGap = 5



local scene = composer.newScene()

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
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif (phase == "did") then


        --- POSITIONING MAIN FRAME
        local width = (display.viewableContentWidth + display.screenOriginX);
        local height = width


        local gapUpper = display.actualContentHeight - height;
        local percentUpper = gapUpper * 100 / display.actualContentHeight;

        --- SET UPPER GAP OF 5 PERCENT
        if (percentUpper > planedUpperGap) then
            local difference = percentUpper - planedUpperGap;
            height = height + (difference * display.actualContentHeight / 100);
            width = (height / heightN) * widthN;

        elseif percentUpper < planedUpperGap and percentUpper > 0 then

        elseif percentUpper < 0 then
        end

        local fieldSize = width / widthN;
        --- DRAW MAIN FIELD

        local mainfield = display.newRect(display.screenOriginX + width / 2, display.actualContentHeight + display.screenOriginY - height / 2, width, height);
        mainfield:setFillColor(0.32, 0.26, 0.26)
        local bottomRect = display.newRect(display.screenOriginX + width / 2, display.actualContentHeight + display.screenOriginY - fieldSize, fieldSize * widthN, fieldSize * 2);
        bottomRect:setFillColor(1, 1, 1, 0);
        bottomRect.isHitTestable = true;
        gapUpper = display.actualContentHeight - height;
        percentUpper = gapUpper * 100 / display.viewableContentHeight;
        local gapRight = display.actualContentWidth - width;
        local tenOfWidth = display.actualContentWidth / 15;

        local startPositionY = display.actualContentHeight + display.screenOriginY + fieldSize / 2;
        local startPositionX = display.screenOriginX - fieldSize / 2;


        local type = math.random(4, 4);

        local randomField = math.random(1, widthN - 3);
        local randomRotation = math.random(0, 3);



        local clairvoyant;
        local fields = {};
        local topBar;
        local scoresEditor;
        local bonus;
        local manageMovements;
        local label;
        local figures = {};
        local sound;
        local destructor;
        local texto;
        local label;
        for x = 1, widthN do
            fields[x] = {}
            for y = 1, heightN do
                fields[x][y] = { x = 0, y = 0, isFree = true };
                fields[x][y].x = startPositionX + ((fields[x][y].x + fieldSize) * x);

                fields[x][y].y = startPositionY - ((fields[x][y].y + fieldSize) * y);
                --- -DON'T DELETE
                -- display.newText(x,fields[x][y].x,fields[x][y].y,"Arial",25)
                --- -DON'T DELETE
            end
        end

        clairvoyant = clairvoyantCreator.new(gapRight, gapUpper);
        clairvoyant.show();
        local randomNumber = function()

            local y = 0;

            type = math.random(4, 4);
            randomField = math.random(1, widthN - 3);
            randomRotation = math.random(0, 3);

            if (clairvoyant.figure ~= nil) then
                clairvoyant.clearField();
            end

            if (type == 4) then
                if (randomRotation == 1 or randomRotation == 3) then y = y - 3 end;

                clairvoyant.drawNew("line", randomField, y);
                for i = 1, randomRotation do clairvoyant.figure.turn(); end
            elseif (type == 1) then
                y = y - 1
                if (randomRotation == 1 or randomRotation == 3) then y = y - 1 end;
                clairvoyant.drawNew("line|_", randomField, y);
                for i = 1, randomRotation do clairvoyant.figure.turn(); end

            elseif (type == 3) then
                clairvoyant.drawNew("halfCross", randomField, y);
                for i = 1, randomRotation do clairvoyant.figure.turn(); end
            elseif (type == 2) then
                if (randomRotation == 1 or randomRotation == 3) then y = y - 1 end;
                clairvoyant.drawNew("line_|", randomField, y);
                for i = 1, randomRotation do clairvoyant.figure.turn(); end
            end
        end

        local lastPosition = 0;

        local manageMovements = function(event)
            if (event.target ~= bottomRect) then
                if (event.phase == "began") then


                    lastPosition = event.xStart;

                    --[[
                        if event.x < width / 2 then
                            Runtime:dispatchEvent({ name = "Left" });
                        else
                            Runtime:dispatchEvent({ name = "Right" });
                        end
                     --]]

                elseif (event.phase == "moved") then
                    local movementLength = lastPosition - event.x;
                    if (math.abs(movementLength) > tenOfWidth and movementLength > 0) then Runtime:dispatchEvent({ name = "Left" }); lastPosition = event.x
                    elseif (math.abs(movementLength) > tenOfWidth and movementLength < 0) then Runtime:dispatchEvent({ name = "Right" }); lastPosition = event.x
                    end


                elseif (event.phase == "ended" or event.phase == "cancelled") then
                end
            elseif (event.phase == "began") then

                Runtime:dispatchEvent({ name = "fastDown" })
            end
            return true;
        end
        sound = soundCreator.new("settings.json")
        local finish = false;
        local createRandom = function(x, y)

            local figure;

            if (type == 4) then
                if (randomRotation == 1 or randomRotation == 3) then y = y - 3 end;

                figure = figureCreator.new("line", fieldSize, fields, randomField, y, width, bottomRect, manageMovements, sound.playSound);
                figure.show();
                for i = 1, randomRotation do figure.turn(); end

            elseif (type == 1) then
                y = y - 1;

                if (randomRotation == 1 or randomRotation == 3) then y = y - 1 end;
                figure = figureCreator.new("line|_", fieldSize, fields, randomField, y, width, bottomRect, manageMovements, sound.playSound);
                figure.show();

                for i = 1, randomRotation do figure.turn(); end

            elseif (type == 3) then
                y = y;
                figure = figureCreator.new("halfCross", fieldSize, fields, randomField, y, width, bottomRect, manageMovements, sound.playSound);
                figure.show();
                for i = 1, randomRotation do figure.turn(); end
            elseif (type == 2) then

                if (randomRotation == 1 or randomRotation == 3) then y = y - 1 end;
                figure = figureCreator.new("line_|", fieldSize, fields, randomField, y, width, bottomRect, manageMovements, sound.playSound);
                figure.show();
                for i = 1, randomRotation do figure.turn(); end
            end



            figure.shadow.refreshPosition(figure.lb, figure.rb);

            if (fields[figure.first.field.x][figure.first.field.y].isFree == false or
                    fields[figure.second.field.x][figure.second.field.y].isFree == false or
                    fields[figure.third.field.x][figure.third.field.y].isFree == false or
                    fields[figure.fourth.field.x][figure.fourth.field.y].isFree == false
                    or (figure.first.field.x == figure.shadow.first.field.x and figure.first.field.y == figure.shadow.first.field.y))


            then
                display.remove(figure.first);
                display.remove(figure.second);
                display.remove(figure.third);
                display.remove(figure.fourth);




                bottomRect:removeEventListener("touch", manageMovements);


                print("CANT'T CREATE");
                finish = true;


            else
            end




            return figure;
        end
        local figureGenerator;
        local figureGenerator = function()


            table.insert(figures, createRandom(widthN / 2, heightN));
            local figure = figures[#figures];

            if (finish == false) then
                figures[#figures].move(1, 0);


                randomNumber();
            else
                figures[#figures].shadow.removeMe();
                destructor();
            end
        end


        figureGenerator();
        --- BONUS-----------------------
        bonus = bonusCreator.new(fields, bottomRect, manageMovements, sound.playSound);
        bonus.show();
        --- TOPBAR----------------------
        scoresEditor = scoresEditorCreator.new("scores.json");
        topBar = topBarCreate.new(gapUpper, bonus.pointListener, scoresEditor.refresh);
        topBar.show();


        Runtime:addEventListener("touch", manageMovements);
        bottomRect:addEventListener("touch", manageMovements);
        Runtime:addEventListener("elementStopped", bonus.newFigureListener)
        Runtime:addEventListener("newFigure", figureGenerator)

        texto = function()
            collectgarbage()
            label.text = "Memory: " .. (math.round(collectgarbage("count") * 1000)) / 1000 .. "  Texture: " .. (math.round(system.getInfo("textureMemoryUsed") / 1000) * 1000) / 1000
            return true;
        end
        label = display.newText("", display.screenOriginX + 100, display.screenOriginY + 20, native.systemFontBold, 25)
        label.anchorX = 0


        Runtime:addEventListener("enterFrame", texto)

        destructor = function()

            Runtime:removeEventListener("enterFrame", texto);
            Runtime:removeEventListener("touch", manageMovements);
            Runtime:removeEventListener("elementStopped", bonus.newFigureListener);
            Runtime:removeEventListener("newFigure", figureGenerator);
            bottomRect:removeEventListener("touch", manageMovements);
            transition.cancel();

            finish = true;
            local destroyAfterPeroidOfTime = function()
                topBar.removeMe();
                print("KONIEC")
                clairvoyant.clearField();
                if (figures ~= nil and #figures ~= 0) then

                    for i = 1, #figures, -1 do

                        display.remove(figures[i].first);
                        display.remove(figures[i].second);
                        display.remove(figures[i].third);
                        display.remove(figures[i].fourth);



                        if (figures[i] ~= nil) then
                            figures[i].removeMe();
                            figures[i] = nil;
                        end
                    end
                end


                figures = nil;
                for i = 1, widthN do
                    for j = 1, heightN do
                        if fields[i][j].isFree ~= true and fields[i][j].element ~= nil then
                            display.remove(fields[i][j].element);
                            --fields[i][j].element:removeSelf();
                            fields[i][j].element = nil;
                            fields[i][j].isFree = true;
                        end
                    end
                end

                sound.removeMe();
                clairvoyant.removeMe();
                display.remove(mainfield);

                bonus.removeMe();

                randomNumber = nil;
                figureGenerator = nil;
                createRandom = nil;

                texto = nil;
                finish = nil;
                local scores = topBar.score;


                composer.gotoScene("endScene", { effect = "fade", time = 1000, params = { score = scores } });
            end

            timer.performWithDelay(2000, destroyAfterPeroidOfTime, 1);
        end

        sceneGroup:insert(label);
        sceneGroup:insert(mainfield);
    end
end







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




