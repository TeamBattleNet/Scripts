-- Commands for the HUD Script for MMBN 3, enjoy.

local ram = require("BN3/RAM");

local controls = {};

local command_index = 1;
local commands = {};
local options = {};

function controls.next()
    command_index = (command_index % table.getn(commands)) + 1;
    local command = commands[command_index];
    print(command.description());
    gui.addmessage(command.description());
end

function controls.previous()
    command_index = command_index - 1;
    if command_index == 0 then
        command_index = table.getn(commands);
    end
    local command = commands[command_index];
    print(command.description());
    gui.addmessage(command.description());
end

function controls.option_down()
    local options = commands[command_index];
    options.selection = (options.selection % table.getn(options)) + 1;
    local option = options[options.selection];
    print("Selected: " .. option.text);
    gui.addmessage("Selected: " .. option.text);
end

function controls.option_up()
    local options = commands[command_index];
    options.selection = options.selection - 1;
    if options.selection == 0 then
        options.selection = table.getn(options);
    end
    local option = options[options.selection];
    print("Selected: " .. option.text);
    gui.addmessage("Selected: " .. option.text);
end

function controls.doit()
    local command = commands[command_index];
    local option = command[command.selection];
    print(option.text);
    gui.addmessage(option.text);
    command.doit(option.value);
end

function controls.display_options()
    local options = commands[command_index];
    
    local text = options.description() .. "\n";
    for i=1,table.getn(options) do
        text = text .. "\n["..i.."] " .. options[i].text;
        if i == options.selection then
            text = text .. " <--";
        end
    end
    return text;
end

------------------------------------------------------------------------------------------------------------------------

options = {};
table.insert(options, {value = 0; text = "Press Left or Right to change Commands"});
options.selection = 1; -- default option
options.description = function() return "Settings Menu"; end;
options.doit = function(value) return; end;
table.insert(commands, options);

options = {};
table.insert(options, {value =  100; text = "Increase Main RNG by 100"});
table.insert(options, {value =   10; text = "Increase Main RNG by  10"});
table.insert(options, {value =    1; text = "Increase Main RNG by   1"});
table.insert(options, {value =   -1; text = "Decrease Main RNG by   1"});
table.insert(options, {value =  -10; text = "Decrease Main RNG by  10"});
table.insert(options, {value = -100; text = "Decrease Main RNG by 100"});
options.selection = 3; -- default option
options.description = function() return string.format("Modify Main RNG: %4s: %08X", (ram.rng.get_main_RNG_index() or "????"), ram.rng.get_main_RNG_value()); end;
options.doit = function(value) ram.rng.adjust_main_RNG(value); end;
table.insert(commands, options);

options = {};
table.insert(options, {value =  100; text = "Increase Lazy RNG by 100"});
table.insert(options, {value =   10; text = "Increase Lazy RNG by  10"});
table.insert(options, {value =    1; text = "Increase Lazy RNG by   1"});
table.insert(options, {value =   -1; text = "Decrease Lazy RNG by   1"});
table.insert(options, {value =  -10; text = "Decrease Lazy RNG by  10"});
table.insert(options, {value = -100; text = "Decrease Lazy RNG by 100"});
options.selection = 3; -- default option
options.description = function() return string.format("Modify Lazy RNG: %4s: %08X", (ram.rng.get_lazy_RNG_index() or "????"), ram.rng.get_lazy_RNG_value()); end;
options.doit = function(value) ram.rng.adjust_lazy_RNG(value); end;
table.insert(commands, options);

options = {};
table.insert(options, {value =  100000; text = "Increase Zenny by 100000"});
table.insert(options, {value =   10000; text = "Increase Zenny by  10000"});
table.insert(options, {value =    1000; text = "Increase Zenny by   1000"});
table.insert(options, {value =     100; text = "Increase Zenny by    100"});
table.insert(options, {value =    -100; text = "Decrease Zenny by    100"});
table.insert(options, {value =   -1000; text = "Decrease Zenny by   1000"});
table.insert(options, {value =  -10000; text = "Decrease Zenny by  10000"});
table.insert(options, {value = -100000; text = "Decrease Zenny by 100000"});
options.selection = 4; -- default option
options.description = function() return string.format("Modify Zenny: %u", ram.get_zenny()); end;
options.doit = function(value) ram.add_zenny(value); end;
table.insert(commands, options);

options = {};
table.insert(options, {value =  1000; text = "Increase Bug Frags by 1000"});
table.insert(options, {value =   100; text = "Increase Bug Frags by  100"});
table.insert(options, {value =    10; text = "Increase Bug Frags by   10"});
table.insert(options, {value =     1; text = "Increase Bug Frags by    1"});
table.insert(options, {value =    -1; text = "Decrease Bug Frags by    1"});
table.insert(options, {value =   -10; text = "Decrease Bug Frags by   10"});
table.insert(options, {value =  -100; text = "Decrease Bug Frags by  100"});
table.insert(options, {value = -1000; text = "Decrease Bug Frags by 1000"});
options.selection = 4; -- default option
options.description = function() return string.format("Modify Bug Frags: %u", ram.get_bug_frags()); end;
options.doit = function(value) ram.add_bug_frags(value); end;
table.insert(commands, options);

options = {};
table.insert(options, {value =  9999; text = "Increase Steps by 9999"});
table.insert(options, {value =    64; text = "Increase Steps by   64"});
table.insert(options, {value =     2; text = "Increase Steps by    2"});
table.insert(options, {value =     1; text = "Increase Steps by    1"});
table.insert(options, {value =    -1; text = "Decrease Steps by    1"});
table.insert(options, {value =    -2; text = "Decrease Steps by    2"});
table.insert(options, {value =   -64; text = "Decrease Steps by   64"});
table.insert(options, {value = -9999; text = "Decrease Steps by 9999"});
options.selection = 4; -- default option
options.description = function() return string.format("Modify Steps: %u", ram.get_steps()); end;
options.doit = function(value) ram.add_steps(value); end;
table.insert(commands, options);

options = {};
table.insert(options, {value = false; text = "Allow Random Encounters"});
table.insert(options, {value =  true; text = "Block Random Encounters"});
options.selection = 1; -- default option
options.description = function() return "Toggle Encounter Skip: " .. tostring(ram.skip_encounters); end;
options.doit = function(value) ram.skip_encounters = value; end;
table.insert(commands, options);

return controls;

