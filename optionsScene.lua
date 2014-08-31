--
-- Created by IntelliJ IDEA.
-- User: szymon
-- Date: 29/08/14
-- Time: 13:05
-- To change this template use File | Settings | File Templates.
--


local composer = require("composer");
local widget = require("widget");
local soundCreator = require("soundCreator");
local menuTextHeight = display.actualContentHeight / 10;
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local backListener;
backListener = function(event)
    if (event.phase == "began") then
        event.target:removeEventListener("touch", backListener)
        composer.gotoScene("menuScene");
    end
end

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

        sceneGroup.sound = soundCreator.new("settings.json");

        sceneGroup.soundState = sceneGroup.sound.isSoundOn;



    elseif (phase == "did") then


        sceneGroup.optionsLabel = display.newText("OPTIONS", display.actualContentWidth / 2 + display.screenOriginX, display.screenOriginY + menuTextHeight * 2, "Arial", menuTextHeight / 2);
        sceneGroup.optionsLabel:setFillColor(0.25 / 1, 0.5 / 1, 0.6 / 1);
        sceneGroup.soundLabel= display.newText("Sounds",0 ,0, "Arial", menuTextHeight / 3);
        sceneGroup.backLabel = display.newText("BACK", 0, 0, "Arial", menuTextHeight / 5)
        sceneGroup.backLabel.x = display.screenOriginX + sceneGroup.backLabel.width;
        sceneGroup.backLabel.y = display.screenOriginY + sceneGroup.backLabel.height;
        sceneGroup.backLabel:setFillColor(0.8, 0.5, 0.5);
        sceneGroup.backLabel:addEventListener("touch", backListener)
        local writeSettings = function(event)


            if (sceneGroup.soundState ~= event.target.isOn) then
                sceneGroup.sound.saveSettings(event.target.isOn);
                sceneGroup.soundState=event.target.isOn;
            end
        end


        local options=
        {
            frames=
            {
                { x=0, y=0, width=160, height=44 },
                { x=0, y=45, width=42, height=42 },
                { x=44, y=45, width=42, height=42 },
                { x=88, y=44, width=96, height=44 }

            },

            sheetContentWidth=184,
            sheetContentHeight=88

        };
        --sceneGroup.imageSheet=graphics.newImageSheet("image.png",options);

        sceneGroup.widget = widget.newSwitch
            {
                left = sceneGroup.optionsLabel.x + sceneGroup.optionsLabel.width / 2,
                top = sceneGroup.optionsLabel.y + menuTextHeight,
                style="onOff",
                id="onOffSwitch";
                initialSwitchState = sceneGroup.soundState, onPress = writeSettings,
               --[[
                -- sheet = sceneGroup.imageSheet;
                onOffBackgroundFrame = 1,
                onOffBackgroundWidth = 160,
                onOffBackgroundHeight = 44,
                onOffMask = "mask.png",

                onOffHandleDefaultFrame = 2,
                onOffHandleOverFrame = 3,

                onOffOverlayFrame = 4,
                onOffOverlayWidth = 96,
                onOffOverlayHeight = 44
                --]]

            };
        sceneGroup.soundLabel.x=sceneGroup.optionsLabel.x-sceneGroup.optionsLabel.width/2;
        sceneGroup.soundLabel.y=sceneGroup.widget.y;
        sceneGroup.soundLabel:setFillColor(0.25 / 1, 0.5 / 1, 0.6 / 1);


        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.


        sceneGroup:insert(sceneGroup.backLabel);
        sceneGroup:insert(sceneGroup.optionsLabel);
        sceneGroup:insert(sceneGroup.widget);
        sceneGroup:insert(sceneGroup.soundLabel);
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



