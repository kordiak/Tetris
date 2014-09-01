--
-- Created by IntelliJ IDEA.
-- User: szymon
-- Date: 28/08/14
-- Time: 13:32
-- To change this template use File | Settings | File Templates.
--
local json = require("json");



local scoresEditorCreator = {}

scoresEditorCreator.new = function(fileName)

    local path = system.pathForFile(fileName, system.DocumentsDirectory);
    local scoresEditor = {}

    scoresEditor.string = nil;
    scoresEditor.read = function()

        local fHandler = io.open(path, "r");

        if (fHandler ~= nil) then
            scoresEditor.string = fHandler:read("*a");

            io.close(fHandler);
            fHandler = nil;
            return true
        end
        return false
    end
    scoresEditor.write = function()

        if scoresEditor.string ~= nil then
            local fHandler = io.open(path, "w+");
            fHandler:write(scoresEditor.string);
            io.close(fHandler);
            fHandler = nil;
        end
    end
    scoresEditor.encode = function()

        if scoresEditor.string ~= nil then
            local frame = { scores = { 12, 323, 312, 12, 2323, 23132 } }
            scoresEditor.string = json.encode(scoresEditor.string);
        end
    end
    scoresEditor.decode = function()

        if scoresEditor.string ~= nil then
            --  local frame = { scores = { 12, 323, 312, 12, 2323, 23132 } };
            scoresEditor.string = json.decode(scoresEditor.string);
        end
    end
    scoresEditor.refresh = function(points)
        scoresEditor.read();
        if scoresEditor.string == nil then

            scoresEditor.string = { scores = { points } };

            --print("WORKING");

        else
            scoresEditor.decode();
            table.insert(scoresEditor.string.scores, points);
            local comparer = function(a, b)
                return a > b;
            end
            table.sort(scoresEditor.string.scores, comparer);
            if #scoresEditor.string.scores > 10 then
                table.remove(scoresEditor.string.scores, 11);
            end
        end
    end
    scoresEditor.encode();
    scoresEditor.write();



    scoresEditor.removeMe = function()
        scoresEditor.string = nil;
        scoresEditor = nil;
    end











    return scoresEditor;
end
return scoresEditorCreator;