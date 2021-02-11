-- Controls for MMBN scripting, enjoy.

local controls = {};

local commands = {};
local command_index = 1;

local settings = require("All/Settings");

function controls.next_command()
    command_index = (command_index % table.getn(commands)) + 1;
    local command = commands[command_index];
    print("\nCommand Change: " .. command.description());
end

function controls.previous_command()
    command_index = command_index - 1;
    if command_index <= 0 then
        command_index = table.getn(commands);
    end
    local command = commands[command_index];
    print("\nCommand Change: " .. command.description());
end

function controls.next_option()
    local command = commands[command_index];
    command.selection = (command.selection % table.getn(command.options)) + 1;
    local option = command.options[command.selection];
    print("Option Change: " .. option.text);
end

function controls.previous_option()
    local command = commands[command_index];
    command.selection = command.selection - 1;
    if command.selection <= 0 then
        command.selection = table.getn(command.options);
    end
    local option = command.options[command.selection];
    print("Option Change: " .. option.text);
end

function controls.doit()
    local command = commands[command_index];
    local option = command.options[command.selection];
    print("\nExecuting: " .. command.description());
    print("With Option: " .. option.text);
    settings.command_mode = (not command.doit(option.value));
end

function controls.get_options()
    local command = commands[command_index];
    local options = command.options;
    local lines = {string.format("       %-33s", command.description())};
    -- only 40 characters of fceux will fit on screen
    for i=1,table.getn(options) do
        if i == command.selection then
            table.insert(lines, string.format("-> %2i: %-33s", i, options[i].text));
        else
            table.insert(lines, string.format("   %2i: %-33s", i, options[i].text));
        end
    end
    return lines;
end

function controls.initialize(which_game)
    commands = require("BN" .. which_game .. "/Commands");
end

return controls;

