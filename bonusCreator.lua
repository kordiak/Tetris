--
-- Created by IntelliJ IDEA.
-- User: szymon
-- Date: 27/08/14
-- Time: 14:56
-- To change this template use File | Settings | File Templates.
--
--- EVENTS: newFigure



local bonusCreator = {};


bonusCreator.new = function(fields, bootomRect, bottomRectFunction,playSound)

    local height = #fields[1];
    local width = #fields;


    local bonus = {};
    local clearyY = function()
        local howmuch = #bonus.yY;
        for i = howmuch, 1, -1 do
            table.remove(bonus.yY, i)
        end
    end -- //Clear table of rows
    local checkIfExplosionIsPossible = function()


        for y = 1, height do
            for x = 1, width do
                if (fields[x][y].isFree == false) then

                    table.insert(bonus.yY, y);
                    break;
                end
            end
        end

        if #bonus.yY <= 3 and #bonus.yY > 0 then return true;
        else
            return false
        end
    end --// if height is between 1-3.
    local flyMeToTheMoon = function(field)


        local x = math.random(display.screenOriginX - 100, display.actualContentWidth + 100);
        local y = math.random(display.screenOriginY - 100, display.actualContentHeight + 200);
        local onComplete = function(field, trans)


            if (trans ~= nil) then
                transition.cancel(trans);
                bonus.called = bonus.called - 1;
            end

            trans = nil

            if (field.element ~= nil) then
                field.element:remove(1);
                field.element:removeSelf();


                field.element = nil;
                field.isFree = true;
            end

            if (bonus.called == 0) then

                bonus.moveDown(1)
            end
        end
        local trans;
        trans = transition.to(field.element, { time = 400, alpha = 0, x = x, y = y, onComplete = function() onComplete(field, trans) end });
    end
    bonus.working = false;  --//ensure that the figure won't be created
    bonus.counterOfCalling = 0;
    bonus.show = function()

    --Runtime:addEventListener("addPoint", bonus.pointListener)
    end
    bonus.yY = {}
    bonus.called = 0;
    bonus.calledMoveDown = 0;

    bonus.blinkTwice = function(field, value, trans, counter)

        if trans ~= nil then transition.cancel(trans); trans = nil end
        if value == nil then value = 0; counter = 0 end

        local parameters = { time = 75, alpha = value, onComplete = function() if value == 0 then value = 1; else value = 0 end bonus.blinkTwice(field, value, trans, counter) end }
        if (counter == 3) then parameters.onComplete = function() flyMeToTheMoon(field, trans) end; bonus.called = bonus.called + 1; counter = 0; end
        trans = transition.to(field.element, parameters);

        counter = counter + 1;
    end --- //blink and remove onComplete
    bonus.pointListener = function(event)

        bonus.working = true;

        clearyY();

        if (event.value == 400) then


            if checkIfExplosionIsPossible() then
                for x = 1, width do
                    if (fields[x][1].element ~= nil) then

                        bonus.blinkTwice(fields[x][1]);
                    end --- /if
                end --- /for do
            elseif bonus.working == true then
                Runtime:dispatchEvent({ name = "newFigure" });
                timer.performWithDelay(100, function() bonus.working = false; end, 1)
            else
                bonus.working = false;
            end --- /if
            return true;
        end
    end
    bonus.moveDown = function(startY)

        playSound(2);

        for y = startY, height - 1 do
            for x = 1, width do

                fields[x][y].element = fields[x][y + 1].element;
                fields[x][y].isFree = fields[x][y + 1].isFree;
                if (fields[x][y].isFree and fields[x][y].element ~= nil) then fields[x][y].element:setFillColor(0, 0, 0, 0.5) end
                if (fields[x][y].element ~= nil) then

                    fields[x][y].element.y = fields[x][y].y;
                end
            end
        end
        bonus.counterOfCalling = 0;


        bonus.pointListener({ value = 400 });
    end --- Bringing down elements from above remove line
    bonus.newFigureListener = function(event)

        timer.performWithDelay(100, function() if (bonus.working == false) then Runtime:dispatchEvent({ name = "newFigure" }); end end, 1);
    end


    return bonus;
end

return bonusCreator;



