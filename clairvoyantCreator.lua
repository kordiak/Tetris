---
--
--
--
-- 
---



--NEEDED: WIDTH , UPPER GAP
local figureCreator=require("figureCreator");


local clairvoyantCreator={};

clairvoyantCreator.new=function(width,upperGap)

    local widthN=10;
    local heightN=widthN;
    local clairvoyant=display.newGroup();
    local positionX=display.actualContentWidth-width/2+display.screenOriginX;
    local positionY=display.screenOriginY+upperGap+width/2


    local fieldSize=width/widthN/1.15;
    local startPositionY = positionY+width-fieldSize*1.8;
    local startPositionX = positionX-width/2+fieldSize/4;
    local strokeWidth=10;
    local fields = {}
    local setPositions=function()
    for x = 1, widthN do
        fields[x] = {}
        for y = 1, heightN do
            fields[x][y] = { x = 0, y = 0, isFree = true };
            fields[x][y].x = startPositionX + ((fields[x][y].x + fieldSize) * x);

            fields[x][y].y = startPositionY - ((fields[x][y].y + fieldSize) * y);

            fields[x][y].isFree=true;
          --display.newText(x,fields[x][y].x,fields[x][y].y,"Arial",10);
        end
    end
    end
    setPositions();
    width=width-strokeWidth;

    clairvoyant.show=function()
    clairvoyant.x=positionX;
    clairvoyant.y=positionY;
    clairvoyant.mainField=display.newRect(0,0,width,width);
    clairvoyant:insert(clairvoyant.mainField);
    clairvoyant.mainField:setFillColor(1,1,1,0);
    clairvoyant.mainField.strokeWidth=strokeWidth;
    clairvoyant.mainField:setStrokeColor(0.30,0.25,0.25,1);



    end
    clairvoyant.drawNew=function(whatToDraw,x,yMinus)
        clairvoyant.figure=figureCreator.new(whatToDraw, fieldSize, fields, x, heightN+yMinus, width)
        clairvoyant.figure.freeze=nil;
        clairvoyant.figure.moveDown=nil;
        clairvoyant.figure.blinkAndRemove=nil;
        clairvoyant.figure.move=nil;
        clairvoyant.figure.leftRightListener=nil;
        clairvoyant.figure.show(true);  --TRUE=withoutlisteners


        end
    clairvoyant.clearField=function()
        clairvoyant.figure.removeMe();
        clairvoyant.figure.first:removeSelf();
        clairvoyant.figure.second:removeSelf();
        clairvoyant.figure.third:removeSelf();
        clairvoyant.figure.fourth:removeSelf();
        clairvoyant.figure.state=0;
        clairvoyant.figure=nil;
    end
    clairvoyant.removeMe=function()

    if(clairvoyant.figure~=nil)then

        clairvoyant.clearField();


    end
    clairvoyant:remove(1);
    display.remove(clairvoyant.mainField);
    clairvoyant.mainField=nil;
    clairvoyant:removeSelf();
    clairvoyant=nil;



    end







return clairvoyant;
end
return clairvoyantCreator;