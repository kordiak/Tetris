--
-- Created by IntelliJ IDEA.
-- User: szymon
-- Date: 29/08/14
-- Time: 11:48
-- To change this template use File | Settings | File Templates.
--
local scoresEditorCreator = require("scoresEditorCreator")


local soundCreator = {};


soundCreator.new = function(fileName)

    local sound = {};
    local isSoundOn = true;
    sound.settings = nil;
    sound.isSoundOn = true;
    local fileReader = nil;
    sound.readSettings = function()
        fileReader = scoresEditorCreator.new(fileName);
        fileReader.read();
        fileReader.decode();
        sound.settings = fileReader.string;
        --fileReader.removeMe();

        if (sound.settings ~= nil) then

            sound.isSoundOn = sound.settings.isSoundOn;
            sound.settings = nil;
        end
    end
    sound.readSettings();


    sound.idTick = media.newEventSound("tick.mp3"); --sound.idTick = media.newEventSound("tick.mp3",system.DocumentsDirectory);
    sound.idBang = media.newEventSound("bang.mp3")--, system.DocumentsDirectory);

    sound.saveSettings = function(isSoundOn)
        local data={}
        data.isSoundOn=isSoundOn;
        fileReader.string=data;
        fileReader.encode();
        fileReader.write();

    end
    sound.playSound = function(number)
        if (sound.isSoundOn) then

            local id = 0;
            if number == 1 then id = sound.idTick;
            else
                id = sound.idBang;
            end

            media.playEventSound(id)
        end
    end
    sound.removeMe = function()
        fileReader.removeMe();
        sound.idTick = nil;
        sound.idBang = nil;
        sound = nil
    end



    return sound;
end


return soundCreator;