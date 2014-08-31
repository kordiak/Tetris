---
--
--
--
--
--
---




local shadowCreator = {}

--- Rectangles                  ARRAY   size    minimalXY  maximalXY
shadowCreator.new = function(figure, fields, widthOfOneField, lb, rb)

    local shadow = {}

    local firstX = fields[figure.first.field.x][figure.first.field.y].x;
    local firstY = fields[figure.first.field.x][figure.first.field.y].y;

    local secondX = fields[figure.second.field.x][figure.second.field.y].x;
    local secondY = fields[figure.second.field.x][figure.second.field.y].y;

    local thirdX = fields[figure.third.field.x][figure.third.field.y].x;
    local thirdY = fields[figure.third.field.x][figure.third.field.y].y;

    local fourthX = fields[figure.fourth.field.x][figure.fourth.field.y].x;
    local fourthY = fields[figure.fourth.field.x][figure.fourth.field.y].y;


    local findTop = function(lb, rb) --- The higteest element of  the field, under figure


        local maxY = 0;
        local positionX = figure.first.field.x;
        if (lb.x > 0 and lb.x < 10 and rb.x > 0 and rb.x < 10) then


            for x = lb.x, rb.x do

                for y = 1, figure.first.field.y do

                    if (fields[x][y].isFree == false and maxY < y) then
                        maxY = y;
                        positionX = x;
                    end
                end
            end
            --print(maxY, positionX);

            --[[
             if(maxY>0)then
             shadow.first.x=fields[figure.first.field.x][maxY+1].x;
             shadow.first.y=fields[figure.first.field.x][maxY+1].y;
             else
             shadow.first.x=fields[figure.first.field.x][1].x;
             shadow.first.y=fields[figure.first.field.x][1].y;
             end

             --]]
            return maxY, positionX;
        end
    end
    local findBottom = function(maxY, positionX) --- Which one element of figure is  the lowest

        local verticalArray = {};


        if (figure.first.field.x == positionX) then table.insert(verticalArray, figure.first) end
        if (figure.second.field.x == positionX) then table.insert(verticalArray, figure.second) end
        if (figure.third.field.x == positionX) then table.insert(verticalArray, figure.third) end
        if (figure.fourth.field.x == positionX) then table.insert(verticalArray, figure.fourth) end


        local miniY = 1000;
        local field = 0;
        for i = 1, #verticalArray do
            if verticalArray[i].field.y < miniY then
                miniY = verticalArray[i].field.y;
                field = verticalArray[i];
            end
        end




        if(maxY~=0 and positionX~=0)then

        if (field == figure.first) then

           -- local second_X=figure.first.x-figure.second.x;
          --  lcoal second_Y=figure.first.y-figure.



            shadow.first.y=fields[figure.first.field.x][maxY+1].y;
            shadow.first.x=fields[figure.first.field.x][maxY+1].x;
        end
        end

    end
    shadow.move=function()
    
        local down=1;
        local tabOfY = {}

        table.insert(tabOfY, shadow.first.field);
        table.insert(tabOfY, shadow.second.field);
        table.insert(tabOfY, shadow.third.field);
        table.insert(tabOfY, shadow.fourth.field);

        local number = 22 + 1;
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

            shadow.first.field.y = shadow.first.field.y - down;
            shadow.second.field.y = shadow.second.field.y - down;
            shadow.third.field.y = shadow.third.field.y - down;
            shadow.fourth.field.y = shadow.fourth.field.y - down;

            shadow.first.y=fields[shadow.first.field.x][shadow.first.field.y].y;
            shadow.second.y=fields[shadow.second.field.x][shadow.second.field.y].y;
            shadow.third.y=fields[shadow.third.field.x][shadow.third.field.y].y;
            shadow.fourth.y=fields[shadow.fourth.field.x][shadow.fourth.field.y].y;
            shadow.move();





                     

            


            end
       
    end

    shadow.show = function()
        shadow.first = display.newRect(firstX, firstY, widthOfOneField, widthOfOneField);
        shadow.first:setFillColor(0, 1, 0.2, 0.25);

        shadow.first.field={}
        shadow.first.field.x=figure.first.field.x;
        shadow.first.field.y=figure.first.field.y;


        shadow.second = display.newRect(secondX, secondY, widthOfOneField, widthOfOneField);
        shadow.second:setFillColor(0, 1, 0.2, 0.25);
        shadow.second.field={}
        shadow.second.field.x=figure.second.field.x;
        shadow.second.field.y=figure.second.field.y;



        shadow.third = display.newRect(thirdX, thirdY, widthOfOneField, widthOfOneField);
        shadow.third:setFillColor(0, 1, 0.2, 0.25);
        shadow.third.field={}
        shadow.third.field.x=figure.third.field.x;
        shadow.third.field.y=figure.third.field.y;


        shadow.fourth = display.newRect(fourthX, fourthY, widthOfOneField, widthOfOneField);
        shadow.fourth:setFillColor(0, 1, 0.2, 0.25);
        shadow.fourth.field={};
        shadow.fourth.field.x=figure.fourth.field.x;
        shadow.fourth.field.y=figure.fourth.field.y;

    end
    shadow.refreshPosition = function(lb, rb)


        firstX = fields[figure.first.field.x][figure.first.field.y].x;
        firstY = fields[figure.first.field.x][figure.first.field.y].y;
        shadow.first.field.x=figure.first.field.x;
        shadow.first.field.y=figure.first.field.y;


        secondX = fields[figure.second.field.x][figure.second.field.y].x;
        secondY = fields[figure.second.field.x][figure.second.field.y].y;
        shadow.second.field.x=figure.second.field.x;
        shadow.second.field.y=figure.second.field.y;



        thirdX = fields[figure.third.field.x][figure.third.field.y].x;
        thirdY = fields[figure.third.field.x][figure.third.field.y].y;
        shadow.third.field.x=figure.third.field.x;
        shadow.third.field.y=figure.third.field.y;


        fourthX = fields[figure.fourth.field.x][figure.fourth.field.y].x;
        fourthY = fields[figure.fourth.field.x][figure.fourth.field.y].y;
        shadow.fourth.field.x=figure.fourth.field.x;
        shadow.fourth.field.y=figure.fourth.field.y;

        shadow.redraw();
        shadow.move();

    end
    shadow.redraw = function()

        shadow.first.x = firstX;
        shadow.first.y = firstY;

        shadow.second.x = secondX;
        shadow.second.y = secondY;

        shadow.third.x = thirdX;
        shadow.third.y = thirdY;

        shadow.fourth.x = fourthX;
        shadow.fourth.y = fourthY;
    end


    shadow.removeMe = function()

        display.remove(shadow.first);
        display.remove(shadow.second);
        display.remove(shadow.third);
        display.remove(shadow.fourth);
    end


    return shadow;
end
return shadowCreator;

