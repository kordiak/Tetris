-----------------------------------------------------------------------------------------
-- EVENT: Left, Right, fastDown
--
--
-----------------------------------------------------------------------------------------
display.setStatusBar(display.HiddenStatusBar)
-- Your code here
local composer=require("composer");
composer.gotoScene("menuScene")
--composer.gotoScene("highScoresScene")
--composer.gotoScene("gameScene")
--composer.gotoScene("optionsScene")
print("------------------------------------------------->>>>>>>>>");
--[[
local figureCreator = require("figureCreator");
local clairvoyantCreator = require("clairvoyantCreator");
local topBarCreate=require("TopBarCreator");
local bonusCreator=require("bonusCreator");
local scoresEditorCreator=require("scoresEditorCreator");

local zmianna=10;
local heightN = 22;
local widthN = 10;
local planedUpperGap = 5






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
    print("TODO!")
elseif percentUpper < 0 then
    print("TODO!")
end

local fieldSize = width / widthN;
--- DRAW MAIN FIELD

local mainfield = display.newRect(display.screenOriginX + width / 2, display.actualContentHeight + display.screenOriginY - height / 2, width, height);
mainfield:setFillColor(0.32, 0.26, 0.26)
local bottomRect = display.newRect(display.screenOriginX + width / 2, display.actualContentHeight + display.screenOriginY - fieldSize, fieldSize * widthN, fieldSize * 2);
bottomRect:setFillColor(1, 1, 1, 0);
bottomRect.isHitTestable = true;




--todo: REMOVE!

gapUpper = display.actualContentHeight - height;

percentUpper = gapUpper * 100 / display.viewableContentHeight;
local gapRight = display.actualContentWidth - width;
--- print(gapRight);

--print("UPPER GAP: ", percentUpper, height);

--- REMOVE


local clairvoyant = clairvoyantCreator.new(gapRight, gapUpper);
clairvoyant.show();
--- MAIN TABLE
local fields = {}

local startPositionY = display.actualContentHeight + display.screenOriginY + fieldSize / 2;
local startPositionX = display.screenOriginX - fieldSize / 2;

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

local type = math.random(4, 4);

local randomField = math.random(1, widthN - 3);
local randomRotation = math.random(0, 3);

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
local manageMovements;
local lastPosition = 0;
local tenOfWidth = display.actualContentWidth / 15;
local manageMovements = function(event)
    if (event.target ~= bottomRect) then
        if (event.phase == "began") then


            lastPosition = event.xStart;



        elseif (event.phase == "moved") then
            local movementLength=lastPosition-event.x;
            if(math.abs(movementLength)>tenOfWidth and movementLength>0) then Runtime:dispatchEvent({ name = "Left" }); lastPosition=event.x
            elseif (math.abs(movementLength)>tenOfWidth and movementLength<0) then Runtime:dispatchEvent({name="Right"}); lastPosition=event.x
            end


        elseif (event.phase == "ended" or event.phase == "cancelled") then
        end
    elseif (event.phase == "began") then

        Runtime:dispatchEvent({ name = "fastDown" })
    end
    return true;
end
local createRandom = function(x, y)

    local figure;

    if (type == 4) then
        if (randomRotation == 1 or randomRotation == 3) then y = y - 3 end;

        figure = figureCreator.new("line", fieldSize, fields, randomField, y, width,bottomRect,manageMovements);
        figure.show();
        for i = 1, randomRotation do figure.turn(); end

    elseif (type == 1) then
        y = y - 1;

        if (randomRotation == 1 or randomRotation == 3) then y = y - 1 end;
        figure = figureCreator.new("line|_", fieldSize, fields, randomField, y, width,bottomRect,manageMovements);
        figure.show();

        for i = 1, randomRotation do figure.turn(); end

    elseif (type == 3) then
        y = y;
        figure = figureCreator.new("halfCross", fieldSize, fields, randomField, y, width,bottomRect,manageMovements);
        figure.show();
        for i = 1, randomRotation do figure.turn(); end
    elseif (type == 2) then

        if (randomRotation == 1 or randomRotation == 3) then y = y - 1 end;
        figure = figureCreator.new("line_|", fieldSize, fields, randomField, y, width,bottomRect,manageMovements);
        figure.show();
        for i = 1, randomRotation do figure.turn(); end
    end

    return figure;
end
local figureGenerator;


local label;
local figures = {}
--local isBlocked = false;
--local timeOfLastMove = 0;
local figureGenerator = function()



    table.insert(figures, createRandom(widthN / 2, heightN));

    figures[#figures].move(1, 0);


    randomNumber();
end






Runtime:addEventListener("touch", manageMovements)
Runtime:addEventListener("elementStopped", figureGenerator)
bottomRect:addEventListener("touch", manageMovements);



figureGenerator();
local bonus=bonusCreator.new(fields,bottomRect,manageMovements);
bonus.show();

local scoresEditor=scoresEditorCreator.new("scores.json");
--scoresEditor.read();
--scoresEditor.encode();


local topBar=topBarCreate.new(gapUpper,bonus.pointListener,scoresEditor.refresh);
topBar.show();



--timer.performWithDelay(2000,function() topBar.removeMe() end,1)
local label = display.newText("", display.screenOriginX+100, display.screenOriginY + 20, GROBOLD, 25)
label.anchorX = 0
function texto()


    --print(system.getTimer()- figures[#figures].timeOfLastMove)
    if (figures ~= nil and #figures ~= 0) then
        if (system.getTimer() - figures[#figures].timeOfLastMove > 5000) then
            topBar.removeMe();
            print("KONIEC")
            Runtime:removeEventListener("touch", manageMovements)
            Runtime:removeEventListener("elementStopped", figureGenerator);
            clairvoyant.clearField();
            for i = 1, #figures, -1 do

                figures[i].first:removeSelf();
                figures[i].second:removeSelf();
                figures[i].third:removeSelf();
                figures[i].fourth:removeSelf();

                figures[i].removeMe();
                figures[i] = nil;
            end
            figures = nil;
            for i = 1, widthN do
                for j = 1, heightN do
                    if fields[i][j].isFree ~= true and fields[i][j].element ~= nil then
                        fields[i][j].element:removeSelf();
                        fields[i][j].element = nil;
                        fields[i][j].isFree = true;
                    end
                end
            end
            --Runtime:removeEventListener("enterFrame",texto);
        else
            table.remove(figures, #figures);
        end
    end

    collectgarbage()
    label.text = "Memory: " .. (math.round(collectgarbage("count") * 1000)) / 1000 .. "  Texture: " .. (math.round(system.getInfo("textureMemoryUsed") / 1000) * 1000) / 1000
end

Runtime:addEventListener("enterFrame", texto)

--]]
