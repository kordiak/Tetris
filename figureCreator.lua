--
-- Created by IntelliJ IDEA.
-- User: szymon
-- Date: 12/08/14
-- Time: 11:23
-- To change this template use File | Settings | File Templates.
--

--- EVENT: elementStopped  , addPoint

local shadowCreator = require("shadowCreator");

local figureCreator = {}


figureCreator.new = function(kindOfFigure, size, fields, x, y, width, bottomRect, buttonFunction, playSound)








    local figure = display.newGroup();
    figure.fieldWidth = #fields;
    figure.fieldHeight = #fields[1];
    figure.timeOfMove = 100;
    figure.timeOfPause = 650;
    figure.howManyLines = 0
    figure.element = nil;
    figure.array = {};

    figure.show = function(withOutListeners)
        if (withOutListeners == true) then

            figure.movements = { leftRight = 0, turn = 0 };
            local sizeOfStroke = size - size * 0.2;
            figure.firstRect = display.newRect(0, 0, size, size);
            figure.firstStroke = display.newRect(0, 0, sizeOfStroke, sizeOfStroke);

            figure.first = display.newGroup();
            figure.first:insert(figure.firstRect);
            figure.first:insert(figure.firstStroke);

            figure.bigRect = display.newRect(0, 0, size * 5, size * 5);
            figure.bigRect.isHitTestable = true;
            figure.bigRect:setFillColor(0, 0, 0, 0);

            figure.secondRect = display.newRect(0, 0, size, size);
            figure.secondStroke = display.newRect(0, 0, sizeOfStroke, sizeOfStroke);

            figure.second = display.newGroup();
            figure.second:insert(figure.bigRect)
            figure.second:insert(figure.secondRect);
            figure.second:insert(figure.secondStroke);


            figure.thirdRect = display.newRect(0, 0, size, size);
            figure.thirdStroke = display.newRect(0, 0, sizeOfStroke, sizeOfStroke);

            figure.third = display.newGroup();
            figure.third:insert(figure.thirdRect);
            figure.third:insert(figure.thirdStroke);

            figure.fourthRect = display.newRect(0, 0, size, size);
            figure.fourthStroke = display.newRect(0, 0, sizeOfStroke, sizeOfStroke);

            figure.fourth = display.newGroup();
            figure.fourth:insert(figure.fourthRect);
            figure.fourth:insert(figure.fourthStroke);


            figure.array = {
                { figure.firstRect, figure.firstStroke },
                { figure.secondRect, figure.secondStroke },
                { figure.thirdRect, figure.thirdStroke },
                { figure.fourthRect, figure.fourthStroke }
            };



            for i = 1, 4 do
                figure.array[i][1]:setFillColor(2 / i, 1 / i, 0.5 / i);
                figure.array[i][2]:setFillColor(1, 1, 1, 0);
                figure.array[i][2].strokeWidth = 4;
                figure.array[i][2]:setStrokeColor(1, 1, 1, 0);
            end

        else
            figure.movements = { leftRight = 0, turn = 0 };
            local sizeOfStroke = size - size * 0.2;
            figure.firstRect = display.newRect(0, 0, size, size);
            figure.firstStroke = display.newRect(0, 0, sizeOfStroke, sizeOfStroke);

            figure.first = display.newGroup();
            figure.first:insert(figure.firstRect);
            figure.first:insert(figure.firstStroke);

            figure.bigRect = display.newRect(0, 0, size * 5, size * 5);
            figure.bigRect.isHitTestable = true;
            figure.bigRect:setFillColor(0, 0, 0, 0);

            figure.secondRect = display.newRect(0, 0, size, size);
            figure.secondStroke = display.newRect(0, 0, sizeOfStroke, sizeOfStroke);

            figure.second = display.newGroup();
            figure.second:insert(figure.bigRect)
            figure.second:insert(figure.secondRect);
            figure.second:insert(figure.secondStroke);


            figure.thirdRect = display.newRect(0, 0, size, size);
            figure.thirdStroke = display.newRect(0, 0, sizeOfStroke, sizeOfStroke);

            figure.third = display.newGroup();
            figure.third:insert(figure.thirdRect);
            figure.third:insert(figure.thirdStroke);

            figure.fourthRect = display.newRect(0, 0, size, size);
            figure.fourthStroke = display.newRect(0, 0, sizeOfStroke, sizeOfStroke);

            figure.fourth = display.newGroup();
            figure.fourth:insert(figure.fourthRect);
            figure.fourth:insert(figure.fourthStroke);

            figure.array = {
                { figure.firstRect, figure.firstStroke },
                { figure.secondRect, figure.secondStroke },
                { figure.thirdRect, figure.thirdStroke },
                { figure.fourthRect, figure.fourthStroke }
            };

            for i = 1, 4 do
                figure.array[i][1]:setFillColor(i / 4, 0.5, 0.5);
                figure.array[i][2]:setFillColor(1, 1, 1, 0);
                figure.array[i][2].strokeWidth = 4;
                figure.array[i][2]:setStrokeColor(1, 1, 1, 1);
            end
        end


        if (kindOfFigure == "line") then

            --- 0000


            --todo: check if field is free
            figure.first.x = fields[x][y].x;
            figure.first.y = fields[x][y].y;
            figure.first.field = { x = x, y = y }

            figure.second.x = fields[x + 1][y].x;
            figure.second.y = fields[x + 1][y].y;
            figure.second.field = { x = x + 1, y = y }

            figure.third.x = fields[x + 2][y].x;
            figure.third.y = fields[x + 2][y].y;
            figure.third.field = { x = x + 2, y = y }


            figure.fourth.x = fields[x + 3][y].x;
            figure.fourth.y = fields[x + 3][y].y;
            figure.fourth.field = { x = x + 3, y = y }




            figure.lb = { x = x, y = y };
            figure.rb = { x = x + 3, y = y };


        elseif (kindOfFigure == "halfCross") then


            --- 0
            -- 00
            -- 0


            figure.first.x = fields[x][y].x;
            figure.first.y = fields[x][y].y;
            figure.first.field = { x = x, y = y }

            figure.second.x = fields[x][y - 1].x;
            figure.second.y = fields[x][y - 1].y;
            figure.second.field = { x = x, y = y - 1 }

            figure.third.x = fields[x][y - 2].x;
            figure.third.y = fields[x][y - 2].y;
            figure.third.field = { x = x, y = y - 2 }


            figure.fourth.x = fields[x + 1][y - 1].x;
            figure.fourth.y = fields[x + 1][y - 1].y;
            figure.fourth.field = { x = x + 1, y = y - 1 }




            figure.lb = { x = x, y = y - 2 };
            figure.rb = { x = x + 1, y = y - 1 };


        elseif (kindOfFigure == "line|_") then


            figure.first.x = fields[x][y + 1].x;
            figure.first.y = fields[x][y + 1].y;
            figure.first.field = { x = x, y = y + 1 }

            figure.second.x = fields[x][y].x;
            figure.second.y = fields[x][y].y;
            figure.second.field = { x = x, y = y }

            figure.third.x = fields[x + 1][y].x;
            figure.third.y = fields[x + 1][y].y;
            figure.third.field = { x = x + 1, y = y }


            figure.fourth.x = fields[x + 2][y].x;
            figure.fourth.y = fields[x + 2][y].y;
            figure.fourth.field = { x = x + 2, y = y }




            figure.lb = { x = x, y = y };
            figure.rb = { x = x + 2, y = y };



        elseif (kindOfFigure == "line_|") then

            figure.first.x = fields[x][y - 1].x;
            figure.first.y = fields[x][y - 1].y;
            figure.first.field = { x = x, y = y - 1 }

            figure.second.x = fields[x + 1][y - 1].x;
            figure.second.y = fields[x + 1][y - 1].y;
            figure.second.field = { x = x + 1, y = y - 1 }

            figure.third.x = fields[x + 2][y - 1].x;
            figure.third.y = fields[x + 2][y - 1].y;
            figure.third.field = { x = x + 2, y = y - 1 }


            figure.fourth.x = fields[x + 2][y].x;
            figure.fourth.y = fields[x + 2][y].y;
            figure.fourth.field = { x = x + 2, y = y }




            figure.lb = { x = x, y = y - 1 };
            figure.rb = { x = x + 2, y = y - 1 };
        end
        if (withOutListeners == nil) then
            Runtime:addEventListener("Left", figure.leftRightListener);
            Runtime:addEventListener("Right", figure.leftRightListener);
            Runtime:addEventListener("fastDown", figure.leftRightListener);
            figure.bigRect:addEventListener("touch", figure.leftRightListener);

            figure.shadow = shadowCreator.new(figure, fields, size, figure.lb, figure.rb);
            figure.shadow.show();
        end


    end
    figure.postponement = 0;

    --ROTATION
    figure.state = 0

    --ABILITY TO
    figure.freeze = false;
    figure.timeOfLastMove = system.getTimer(); --- Let's enterframe listener to know that all figures was stopped for longer time
    figure.turn = function(direction)





        if (kindOfFigure == "halfCross") then


            local firstx = figure.first.field.x
            local firsty = figure.first.field.y

            local secondx = figure.second.field.x;
            local secondy = figure.second.field.y;


            local thirdx = figure.third.field.x;
            local thirdy = figure.third.field.y;

            local fourthx = figure.fourth.field.x;
            local fourthy = figure.fourth.field.y;

            if (figure.state == 0) then

                firstx = fourthx;
                firsty = fourthy;

                fourthx = secondx;
                fourthy = thirdy;

                thirdx = thirdx - 1;
                thirdy = secondy;


                figure.state = figure.state + 1;

            elseif (figure.state == 1) then

                firstx = fourthx;
                firsty = fourthy;

                fourthx = thirdx;
                fourthy = thirdy;

                thirdx = thirdx + 1;
                thirdy = secondy + 1;


                figure.state = figure.state + 1;

            elseif figure.state == 2 then


                firstx = fourthx;
                firsty = fourthy;

                fourthx = thirdx;
                fourthy = thirdy;

                thirdx = thirdx + 1;
                thirdy = secondy;




                figure.state = figure.state + 1;
            elseif figure.state == 3 then

                firstx = fourthx;
                firsty = fourthy;

                fourthx = thirdx;
                fourthy = thirdy;

                thirdx = secondx;
                thirdy = secondy - 1;



                figure.state = 0;
            end


            local newX = { firstx, secondx, thirdx, fourthx };
            local newY = { firsty, secondy, thirdy, fourthy };

            local rightCounter = 0;
            for i = 1, 4 do
                if (newX[i] > 0 and newX[i] <= figure.fieldWidth) then
                    if (newY[i] > 0 and newY[i] <= figure.fieldHeight) then
                        if (fields[newX[i]][newY[i]].isFree) then
                            rightCounter = rightCounter + 1;
                        else
                            break;
                        end
                    else
                        break;
                    end
                else
                    break;
                end
            end



            if (rightCounter ~= 4 or figure.freeze) then


                firstx = figure.first.field.x
                firsty = figure.first.field.y

                secondx = figure.second.field.x;
                secondy = figure.second.field.y;


                thirdx = figure.third.field.x;
                thirdy = figure.third.field.y;

                fourthx = figure.fourth.field.x;
                fourthy = figure.fourth.field.y;


                if (figure.state == 0) then
                    figure.state = 3;
                else
                    figure.state = figure.state - 1;
                end
            end


            figure.first.y = fields[firstx][firsty].y;
            figure.first.x = fields[firstx][firsty].x;

            figure.second.y = fields[secondx][secondy].y;
            figure.second.x = fields[secondx][secondy].x;

            figure.third.y = fields[thirdx][thirdy].y;
            figure.third.x = fields[thirdx][thirdy].x;

            figure.fourth.y = fields[fourthx][fourthy].y;
            figure.fourth.x = fields[fourthx][fourthy].x;

            figure.first.field.y = firsty;
            figure.first.field.x = firstx;

            figure.second.field.y = secondy;
            figure.second.field.x = secondx;

            figure.third.field.y = thirdy;
            figure.third.field.x = thirdx;

            figure.fourth.field.y = fourthy;
            figure.fourth.field.x = fourthx;

            local minimalX = firstx;
            local minimalY = firsty;

            local maximalX = firstx;
            local maximalY = firsty;

            for i = 1, 4 do
                if (newX[i] < minimalX) then
                    minimalX = newX[i];
                    minimalY = newY[i];
                elseif (newX[i] > maximalX) then
                    maximalX = newX[i];
                    maximalY = newY[i];
                end
            end





            figure.rb = { x = maximalX, y = maximalY };
            figure.lb = { x = minimalX, y = minimalY };

        elseif (kindOfFigure == "line|_") then



            local firstx = figure.first.field.x
            local firsty = figure.first.field.y

            local secondx = figure.second.field.x;
            local secondy = figure.second.field.y;


            local thirdx = figure.third.field.x;
            local thirdy = figure.third.field.y;

            local fourthx = figure.fourth.field.x;
            local fourthy = figure.fourth.field.y;

            if (figure.state == 0) then

                firstx = thirdx
                firsty = firsty + 1;

                secondy = firsty;

                thirdx = secondx;
                thirdy = secondy - 1;

                fourthx = secondx;


                figure.state = figure.state + 1;

            elseif (figure.state == 1) then

                firsty = fourthy;

                secondx = firstx;
                secondy = firsty + 1;

                fourthx = thirdx - 1;
                fourthy = thirdy;


                figure.state = figure.state + 1;

            elseif figure.state == 2 then


                firstx = thirdx;
                thirdx = secondx;
                secondy = secondy - 1;
                fourthx = secondx;
                fourthy = thirdy + 1;



                figure.state = figure.state + 1;
            elseif figure.state == 3 then

                thirdy = secondy;
                secondx = firstx;
                firsty = firsty + 1;
                fourthy = thirdy;
                fourthx = thirdx + 1;



                figure.state = 0;
            end


            local newX = { firstx, secondx, thirdx, fourthx };
            local newY = { firsty, secondy, thirdy, fourthy };

            local rightCounter = 0;
            for i = 1, 4 do
                if (newX[i] > 0 and newX[i] <= figure.fieldWidth) then
                    if (newY[i] > 0 and newY[i] <= figure.fieldHeight) then
                        if (fields[newX[i]][newY[i]].isFree) then
                            rightCounter = rightCounter + 1;
                        else
                            break;
                        end
                    else
                        break;
                    end
                else
                    break;
                end
            end



            if (rightCounter ~= 4 or figure.freeze) then


                firstx = figure.first.field.x
                firsty = figure.first.field.y

                secondx = figure.second.field.x;
                secondy = figure.second.field.y;


                thirdx = figure.third.field.x;
                thirdy = figure.third.field.y;

                fourthx = figure.fourth.field.x;
                fourthy = figure.fourth.field.y;


                if (figure.state == 0) then
                    figure.state = 3;
                else
                    figure.state = figure.state - 1;
                end
            end


            figure.first.y = fields[firstx][firsty].y;
            figure.first.x = fields[firstx][firsty].x;

            figure.second.y = fields[secondx][secondy].y;
            figure.second.x = fields[secondx][secondy].x;

            figure.third.y = fields[thirdx][thirdy].y;
            figure.third.x = fields[thirdx][thirdy].x;

            figure.fourth.y = fields[fourthx][fourthy].y;
            figure.fourth.x = fields[fourthx][fourthy].x;

            figure.first.field.y = firsty;
            figure.first.field.x = firstx;

            figure.second.field.y = secondy;
            figure.second.field.x = secondx;

            figure.third.field.y = thirdy;
            figure.third.field.x = thirdx;

            figure.fourth.field.y = fourthy;
            figure.fourth.field.x = fourthx;

            local minimalX = firstx;
            local minimalY = firsty;

            local maximalX = firstx;
            local maximalY = firsty;

            for i = 1, 4 do
                if (newX[i] < minimalX) then
                    minimalX = newX[i];
                    minimalY = newY[i];
                elseif (newX[i] > maximalX) then
                    maximalX = newX[i];
                    maximalY = newY[i];
                end
            end





            figure.rb = { x = maximalX, y = maximalY };
            figure.lb = { x = minimalX, y = minimalY };


        elseif (kindOfFigure == "line_|") then






            local firstx = figure.first.field.x
            local firsty = figure.first.field.y

            local secondx = figure.second.field.x;
            local secondy = figure.second.field.y;


            local thirdx = figure.third.field.x;
            local thirdy = figure.third.field.y;

            local fourthx = figure.fourth.field.x;
            local fourthy = figure.fourth.field.y;

            if (figure.state == 0) then


                fourthy = thirdy;
                thirdx = secondx
                secondy = secondy + 1;
                firsty = secondy + 1;
                firstx = secondx;

                figure.state = figure.state + 1;

            elseif (figure.state == 1) then


                fourthx = thirdx;
                thirdy = secondy;
                secondx = secondx + 1;
                firstx = secondx + 1;
                firsty = secondy;

                figure.state = figure.state + 1;

            elseif figure.state == 2 then

                fourthy = thirdy + 1;
                thirdy = fourthy;
                thirdx = fourthx + 1;
                firstx = secondx;
                firsty = secondy - 1;

                figure.state = figure.state + 1;
            elseif figure.state == 3 then

                firstx = fourthx - 1;
                secondx = fourthx;
                secondy = firsty;
                thirdy = secondy;
                fourthx = thirdx;
                fourthy = thirdy + 1;

                figure.state = 0;
            end


            local newX = { firstx, secondx, thirdx, fourthx };
            local newY = { firsty, secondy, thirdy, fourthy };

            local rightCounter = 0;
            for i = 1, 4 do
                if (newX[i] > 0 and newX[i] <= figure.fieldWidth) then
                    if (newY[i] > 0 and newY[i] <= figure.fieldHeight) then
                        if (fields[newX[i]][newY[i]].isFree) then
                            rightCounter = rightCounter + 1;
                        else
                            break;
                        end
                    else
                        break;
                    end
                else
                    break;
                end
            end



            if (rightCounter ~= 4 or figure.freeze) then


                firstx = figure.first.field.x
                firsty = figure.first.field.y

                secondx = figure.second.field.x;
                secondy = figure.second.field.y;


                thirdx = figure.third.field.x;
                thirdy = figure.third.field.y;

                fourthx = figure.fourth.field.x;
                fourthy = figure.fourth.field.y;


                if (figure.state == 0) then
                    figure.state = 3;
                else
                    figure.state = figure.state - 1;
                end
            end


            figure.first.y = fields[firstx][firsty].y;
            figure.first.x = fields[firstx][firsty].x;

            figure.second.y = fields[secondx][secondy].y;
            figure.second.x = fields[secondx][secondy].x;

            figure.third.y = fields[thirdx][thirdy].y;
            figure.third.x = fields[thirdx][thirdy].x;

            figure.fourth.y = fields[fourthx][fourthy].y;
            figure.fourth.x = fields[fourthx][fourthy].x;

            figure.first.field.y = firsty;
            figure.first.field.x = firstx;

            figure.second.field.y = secondy;
            figure.second.field.x = secondx;

            figure.third.field.y = thirdy;
            figure.third.field.x = thirdx;

            figure.fourth.field.y = fourthy;
            figure.fourth.field.x = fourthx;

            local minimalX = firstx;
            local minimalY = firsty;

            local maximalX = firstx;
            local maximalY = firsty;

            for i = 1, 4 do
                if (newX[i] < minimalX) then
                    minimalX = newX[i];
                    minimalY = newY[i];
                elseif (newX[i] > maximalX) then
                    maximalX = newX[i];
                    maximalY = newY[i];
                end
            end





            figure.rb = { x = maximalX, y = maximalY };
            figure.lb = { x = minimalX, y = minimalY };


        elseif (kindOfFigure == "line") then





            local firstx = figure.first.field.x
            local firsty = figure.first.field.y

            local secondx = figure.second.field.x;
            local secondy = figure.second.field.y;


            local thirdx = figure.third.field.x;
            local thirdy = figure.third.field.y;

            local fourthx = figure.fourth.field.x;
            local fourthy = figure.fourth.field.y;

            if (figure.state == 0) then

                fourthx = thirdx;
                secondx = thirdx;
                firstx = thirdx;

                thirdy = thirdy + 1;
                secondy = thirdy + 1;
                firsty = secondy + 1;



                figure.state = figure.state + 1;

            elseif (figure.state == 1) then

                firsty = fourthy;
                secondy = fourthy;
                thirdy = fourthy;

                fourthx = fourthx - 2;
                thirdx = fourthx + 1;
                secondx = thirdx + 1;
                firstx = firstx + 1;


                figure.state = figure.state + 1;

            elseif figure.state == 2 then

                firstx = secondx;
                secondx = secondx;
                thirdx = secondx;
                fourthx = secondx;


                secondy = secondy + 1;
                thirdy = secondy + 1;
                fourthy = thirdy + 1;


                figure.state = figure.state + 1;
            elseif figure.state == 3 then

                fourthy = firsty;
                secondy = firsty;
                thirdy = firsty;

                fourthx = firstx + 1;
                secondx = firstx - 1;
                firstx = secondx - 1;

                figure.state = 0;
            end


            local newX = { firstx, secondx, thirdx, fourthx };
            local newY = { firsty, secondy, thirdy, fourthy };

            local rightCounter = 0;
            for i = 1, 4 do
                if (newX[i] > 0 and newX[i] <= figure.fieldWidth) then
                    if (newY[i] > 0 and newY[i] <= figure.fieldHeight) then
                        if (fields[newX[i]][newY[i]].isFree) then
                            rightCounter = rightCounter + 1;
                        else
                            break;
                        end
                    else
                        break;
                    end
                else
                    break;
                end
            end



            if (rightCounter ~= 4 or figure.freeze) then


                firstx = figure.first.field.x
                firsty = figure.first.field.y

                secondx = figure.second.field.x;
                secondy = figure.second.field.y;


                thirdx = figure.third.field.x;
                thirdy = figure.third.field.y;

                fourthx = figure.fourth.field.x;
                fourthy = figure.fourth.field.y;


                if (figure.state == 0) then
                    figure.state = 3;
                else
                    figure.state = figure.state - 1;
                end
            end


            figure.first.y = fields[firstx][firsty].y;
            figure.first.x = fields[firstx][firsty].x;

            figure.second.y = fields[secondx][secondy].y;
            figure.second.x = fields[secondx][secondy].x;

            figure.third.y = fields[thirdx][thirdy].y;
            figure.third.x = fields[thirdx][thirdy].x;

            figure.fourth.y = fields[fourthx][fourthy].y;
            figure.fourth.x = fields[fourthx][fourthy].x;

            figure.first.field.y = firsty;
            figure.first.field.x = firstx;

            figure.second.field.y = secondy;
            figure.second.field.x = secondx;

            figure.third.field.y = thirdy;
            figure.third.field.x = thirdx;

            figure.fourth.field.y = fourthy;
            figure.fourth.field.x = fourthx;

            local minimalX = firstx;
            local minimalY = firsty;

            local maximalX = firstx;
            local maximalY = firsty;

            for i = 1, 4 do
                if (newX[i] < minimalX) then
                    minimalX = newX[i];
                    minimalY = newY[i];
                elseif (newX[i] > maximalX) then
                    maximalX = newX[i];
                    maximalY = newY[i];
                end
            end

            figure.rb = { x = maximalX, y = maximalY };
            figure.lb = { x = minimalX, y = minimalY };
        end


    end
    figure.moveDown = function(startY)

        for y = startY, figure.fieldHeight - 1 do
            for x = 1, figure.fieldWidth do

                fields[x][y].element = fields[x][y + 1].element;
                fields[x][y].isFree = fields[x][y + 1].isFree;
                if (fields[x][y].isFree and fields[x][y].element ~= nil) then fields[x][y].element:setFillColor(0, 0, 0, 0.5) end
                if (fields[x][y].element ~= nil) then

                    fields[x][y].element.y = fields[x][y].y;
                end
            end
        end
    end --- Bringing down elements from above remove line
    figure.blinkAndRemove = function(fields, y)
        local timeOfBlink = 150;
        local row = {};
        local animatedElements = 0;
        for i = 1, 10 do

            table.insert(row, fields[i][y].element);
        end
        local start;
        local finish;
        local alfaToZero;
        local alfaToOne;
        alfaToZero = function(object)
            local trans;
            trans = transition.to(object, { time = timeOfBlink / 2, alpha = 0, onComplete = function() alfaToOne(object, trans) end });
        end
        alfaToOne = function(object, trans)
            transition.cancel(trans);
            animatedElements = animatedElements + 1;

            if (animatedElements == 20 and row ~= nil) then
                finish(object)
                animatedElements = 0;
            else
                trans = transition.to(object, { time = timeOfBlink / 2, alpha = 1, onComplete = function() transition.cancel(trans); if animatedElements == 10 then start() end end });
            end
        end
        start = function()


            for i = 1, 10 do
                alfaToZero(row[i]);
            end
        end
        finish = function(object, trans)

            local yUsedOnce = 0;

            for i = 1, 10 do



                figure.howManyLines = figure.howManyLines + 1;


                row[i]:removeSelf();
                fields[i][y].element = nil;
                fields[i][y].isFree = true;
            end
            for i = 1, 10 do

                table.remove(row, 11 - i);
            end
            row = nil;

            if row == nil then playSound(2); end
        end





        start();
    end
    figure.move = function(down, horizontal, turn)




    --- Find the lowest element

        local tabOfY = {}
        table.insert(tabOfY, figure.first.field);
        table.insert(tabOfY, figure.second.field);
        table.insert(tabOfY, figure.third.field);
        table.insert(tabOfY, figure.fourth.field);

        local number = figure.fieldHeight + 1;
        local position;
        for i = 1, 4 do
            if tabOfY[i].y < number then
                number = tabOfY[i].y;
                position = i;
            end
        end

        --- Can move vertical?
        local canMoveVertical = 0;

        for i = 1, 4 do
            if (tabOfY[position].y > 1 and fields[tabOfY[i].x][tabOfY[i].y - down].isFree) then
                canMoveVertical = canMoveVertical + 1;
            end
        end

        if (tabOfY[position].y > 1 and canMoveVertical == 4) then --- if the lowest element didn't achived the bottom of main field

            figure.first.field.y = figure.first.field.y - down;
            figure.second.field.y = figure.second.field.y - down;
            figure.third.field.y = figure.third.field.y - down;
            figure.fourth.field.y = figure.fourth.field.y - down;
            figure.lb.y = figure.lb.y + down;
            figure.rb.y = figure.rb.y + down;

            --- Can move horizontal
            if (figure.rb.x + horizontal <= figure.fieldWidth and figure.lb.x + horizontal > 0) then
                local canMoveHorizontal = 0;

                for i = 1, 4 do
                    if (tabOfY[i].x + horizontal < figure.fieldWidth + 1) then
                        if (fields[tabOfY[i].x + horizontal][tabOfY[i].y].isFree) then
                            canMoveHorizontal = canMoveHorizontal + 1;
                        end
                    end
                end

                if (canMoveHorizontal == 4 and figure.flag == nil) then
                    figure.first.field.x = figure.first.field.x + horizontal;
                    figure.second.field.x = figure.second.field.x + horizontal;
                    figure.third.field.x = figure.third.field.x + horizontal;
                    figure.fourth.field.x = figure.fourth.field.x + horizontal;
                    figure.lb.x = figure.lb.x + horizontal;
                    figure.rb.x = figure.rb.x + horizontal;
                end
            end

            local tr1;
            local tr2;
            local tr3;
            local tr4;

            local onComplete = function(trans)
                if (trans ~= nil) then
                    transition.cancel(trans);
                    figure.flag = nil;
                    --figure.turn();
                end
            end

            if (horizontal ~= 0) then

                figure.first.x = fields[figure.first.field.x][figure.first.field.y].x;
                figure.second.x = fields[figure.second.field.x][figure.second.field.y].x;
                figure.third.x = fields[figure.third.field.x][figure.third.field.y].x;
                figure.fourth.x = fields[figure.fourth.field.x][figure.fourth.field.y].x;


            elseif (down == 1) then


                playSound(1);
                figure.flag = true;
                tr1 = transition.to(figure.first, { y = fields[figure.first.field.x][figure.first.field.y].y, time = figure.timeOfMove, onComplete = function() onComplete(tr1) end });
                tr2 = transition.to(figure.second, { y = fields[figure.second.field.x][figure.second.field.y].y, time = figure.timeOfMove, onComplete = function() onComplete(tr2) end });
                tr3 = transition.to(figure.third, { y = fields[figure.third.field.x][figure.third.field.y].y, time = figure.timeOfMove, onComplete = function() onComplete(tr3) end });
                tr4 = transition.to(figure.fourth, { y = fields[figure.fourth.field.x][figure.fourth.field.y].y, time = figure.timeOfMove, onComplete = function() onComplete(tr4); figure.timeOfLastMove = system.getTimer();end });






                figure.timerOfMove = timer.performWithDelay(figure.timeOfPause, function() figure.move(down, horizontal, 0); figure.isTimerOn = false; end, 1);

            elseif (turn ~= 0 and figure.flag == nil) then

                figure.turn();
                turn = 0;
            end

        elseif horizontal == 0 and turn == 0 and figure.isTimerOn == false and figure.first.field.x==figure.shadow.first.field.x and figure.first.field.y==figure.shadow.first.field.y then

            figure.freeze = true; --element stopped

            for i = 1, 4 do
                fields[tabOfY[i].x][tabOfY[i].y].isFree = false;
                if figure.first.field.y == tabOfY[i].y and figure.first.field.x == tabOfY[i].x then fields[tabOfY[i].x][tabOfY[i].y].element = figure.first; end
                if figure.second.field.y == tabOfY[i].y and figure.second.field.x == tabOfY[i].x then fields[tabOfY[i].x][tabOfY[i].y].element = figure.second; end
                if figure.third.field.y == tabOfY[i].y and figure.third.field.x == tabOfY[i].x then fields[tabOfY[i].x][tabOfY[i].y].element = figure.third; end
                if figure.fourth.field.y == tabOfY[i].y and figure.fourth.field.x == tabOfY[i].x then fields[tabOfY[i].x][tabOfY[i].y].element = figure.fourth; end
            end
            -- Runtime:removeEventListener("Left", figure.leftRightListener);
            --  Runtime:removeEventListener("Right", figure.leftRightListener);
            figure.bigRect:removeEventListener("touch", figure.leftRightListener);


            local counter = { 10, 10, 10, 10 };
            local yY = {};
            for i = 1, #tabOfY do



                for j = 1, 10 do
                    if (fields[j][tabOfY[i].y].isFree == false) then
                        counter[i] = counter[i] - 1;
                    end
                end

                if (counter[i] == 0 and table.indexOf(yY, tabOfY[i].y) == nil) then

                    table.insert(yY, tabOfY[i].y)
                else

                    counter[i] = 10;
                end
            end

            local blinked = false;

            local newTabOfY = {};
            if (counter[1] == 0) then
                figure.blinkAndRemove(fields, figure.first.field.y);
                table.insert(newTabOfY, figure.first.field.y);
                blinked = true;
            end
            if (counter[2] == 0) then
                figure.blinkAndRemove(fields, figure.second.field.y);
                table.insert(newTabOfY, figure.second.field.y);
                blinked = true;
            end
            if (counter[3] == 0) then
                figure.blinkAndRemove(fields, figure.third.field.y);
                table.insert(newTabOfY, figure.third.field.y);
                blinked = true;
            end
            if (counter[4] == 0) then
                figure.blinkAndRemove(fields, figure.fourth.field.y);
                table.insert(newTabOfY, figure.fourth.field.y);
                blinked = true;
            end

            local comparer = function(a, b)
                return a > b;
            end

            if (blinked) then
                figure.postponement = figure.postponement + 300;
            end






            blinked = false;




            table.sort(newTabOfY, comparer)
            figure.isTimerOn = true;
            local last = 100;
            for i = 1, #newTabOfY do
                if newTabOfY[i] ~= last then
                    timer.performWithDelay(350, function() figure.moveDown(newTabOfY[i]); figure.isTimerOn = false end, 1);

                    last = newTabOfY[i];
                    blinked = true;
                end
            end

            if (blinked) then
                figure.postponement = figure.postponement + 360;
            end



            bottomRect:removeEventListener("touch", buttonFunction);
            timer.performWithDelay(figure.postponement + 100, function() bottomRect:addEventListener("touch", buttonFunction); figure.removeMe(); end, 1);



            timer.performWithDelay(figure.postponement, function() Runtime:dispatchEvent({ name = "elementStopped" }); end, 1);
        end

        figure.shadow.refreshPosition(figure.lb, figure.rb);





    --figure.shadow.redraw();
    end
    figure.leftRightListener = function(event)

        if event.name == "Left" then
            figure.move(0, -1);


        elseif (event.name == "Right") then

            figure.move(0, 1)
        elseif (event.name == "touch" and event.phase == "began") then
            figure.move(0, 0, 1);
            return true;
        elseif (event.name == "fastDown") then

            figure.timeOfPause = 0;

            figure.timeOfMove = 0

            timer.cancel(figure.timerOfMove);
            figure.timerOfMove = timer.performWithDelay(figure.timeOfPause, function() figure.move(1, 0, 0); figure.isTimerOn = false; end, 1);
            Runtime:removeEventListener("fastDown", figure.leftRightListener);
            Runtime:removeEventListener("Left", figure.leftRightListener);
            Runtime:removeEventListener("Right", figure.leftRightListener);
            Runtime:removeEventListener("touch", figure.leftRightListener);
            figure.bigRect:removeEventListener("touch", figure.leftRightListener);
        end
    end


    figure.removeMe = function()


        Runtime:dispatchEvent({ name = "addPoint", value = figure.howManyLines * 10 });
        Runtime:removeEventListener("Left", figure.leftRightListener);
        Runtime:removeEventListener("Right", figure.leftRightListener);
        Runtime:removeEventListener("fastDown", figure.leftRightListener);

        figure.firstRect = nil;
        figure.firstStroke = nil;
        figure.secondRect = nil
        figure.secondStroke = nil
        figure.thirdRect = nil
        figure.thirdStroke = nil;
        figure.fourthRect = nil
        figure.fourthStroke = nil;
        figure.bigRect = nil;
        for i = 1, #figure.array do
            figure.array = nil;
        end

        if (figure.shadow ~= nil) then
            figure.shadow.removeMe();
            figure.shadow = nil;
        end

        figure:removeSelf();

        figure = nil;
    end







    return figure;
end

return figureCreator;