--
-- Created by IntelliJ IDEA.
-- User: szymon
-- Date: 27/08/14
-- Time: 10:52
-- To change this template use File | Settings | File Templates.
--


local TopBarCreator = {}


TopBarCreator.new = function(upperGap,listener,writeToFile)

    local TopBar = display.newGroup();
    local width = 0;
    TopBar.y = 0 + display.screenOriginY;
    TopBar.x = 0 + display.screenOriginX;
    TopBar.show = function()


        TopBar.scoreText = display.newText("0", 0, 0, "Arial", upperGap / 2);
        TopBar:insert(TopBar.scoreText);
        width = TopBar.scoreText.width;
        TopBar.setPosition();


        Runtime:addEventListener("addPoint", TopBar.pointListener);
    end
    TopBar.setPosition = function()

        TopBar.x = display.screenOriginX + TopBar.scoreText.width / 2 + width;
        TopBar.y = display.screenOriginY + TopBar.scoreText.height / 2 + width / 2;
    end
    TopBar.pointListener = function(event)


        if (event.value == 100) then TopBar.addPoints(event.value);
        elseif (event.value == 200) then TopBar.addPoints(event.value + 100);
        elseif (event.value == 300) then TopBar.addPoints(event.value * 2);
        elseif (event.value >= 400) then TopBar.addPoints(event.value + 600);
        listener({value=400});

        end

       --return true;
    end
    TopBar.addPoints = function(points)

        TopBar.score = TopBar.score + points;

        TopBar.scoreText.text = TopBar.score;
        TopBar.setPosition();
    end
    TopBar.score = 0;
    TopBar.removeMe = function()

    writeToFile(TopBar.score);
    Runtime:removeEventListener("addPoint",TopBar.pointListener);
    TopBar:remove(1);
    display.remove(TopBar.scoreText);
    TopBar.scoreText=nil;

    TopBar:removeSelf();
    TopBar=nil;


    end


    return TopBar;
end



return TopBarCreator;