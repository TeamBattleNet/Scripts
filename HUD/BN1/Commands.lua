-- Commands for the HUD Script for MMBN 1, enjoy.

local ram = require("BN1/RAM");

local controls = {};
local commands = {};
local command_index = 1;

local function show_text(message)
    print(message);
    gui.addmessage(message);
end

function controls.next()
    command_index = (command_index % table.getn(commands)) + 1;
    local command = commands[command_index];
    show_text("Selected: " .. command.description());
end

function controls.previous()
    command_index = command_index - 1;
    if command_index == 0 then
        command_index = table.getn(commands);
    end
    local command = commands[command_index];
    show_text("Selected: " .. command.description());
end

function controls.option_down()
    local command = commands[command_index];
    command.selection = (command.selection % table.getn(command.options)) + 1;
    local option = command.options[command.selection];
    show_text("Selected: " .. option.text);
end

function controls.option_up()
    local command = commands[command_index];
    command.selection = command.selection - 1;
    if command.selection == 0 then
        command.selection = table.getn(command.options);
    end
    local option = command.options[command.selection];
    show_text("Selected: " .. option.text);
end

function controls.doit()
    local command = commands[command_index];
    local option = command.options[command.selection];
    show_text("Executing: " .. command.description());
    show_text("With Option: " .. option.text);
    command.doit(option.value);
end

function controls.display_options()
    local command = commands[command_index];
    local options = command.options;
    local lines = {"         " .. command.description()};
    for i=1,table.getn(options) do
        if i == command.selection then
            table.insert(lines, string.format("--> [%2i] %s", i, options[i].text));
        else
            table.insert(lines, string.format("    [%2i] %s", i, options[i].text));
        end
    end
    return lines;
end

------------------------------------------------------------------------------------------------------------------------

local command_blank = {};
command_blank.options = {
    {value = nil; text = "Press  Up  or  Down to change Options !"};
    {value = nil; text = "Press Left or Right to change Commands!"};
    {value = nil; text = "You can use the controller or keyboard!"};
};
command_blank.selection = 1;
command_blank.description = function() return "Welcome to the Command list!"; end;
command_blank.doit = function() return; end;
table.insert(commands, command_blank);



local command_encounters = {};
command_encounters.options = {
    {value =  true; text = "Block Random Encounters"};
    {value = false; text = "Allow Random Encounters"};
};
command_encounters.selection = 1;
command_encounters.description = function() return "Random Encounters: " .. tostring(not ram.skip_encounters); end
command_encounters.doit = function(value) ram.skip_encounters = value; end;
table.insert(commands, command_encounters);



local command_zenny = {};
command_zenny.options = {
    {value =  100000; text = "Increase by 100000"};
    {value =   10000; text = "Increase by  10000"};
    {value =    1000; text = "Increase by   1000"};
    {value =     100; text = "Increase by    100"};
    {value =    -100; text = "Decrease by    100"};
    {value =   -1000; text = "Decrease by   1000"};
    {value =  -10000; text = "Decrease by  10000"};
    {value = -100000; text = "Decrease by 100000"};
};
command_zenny.selection = 1;
command_zenny.description = function() return string.format("Zenny: %11u", ram.get_zenny()); end;
command_zenny.doit = function(value) ram.add_zenny(value); end;
table.insert(commands, command_zenny);



local command_power = {};
command_power.options = {
    {value =  10; text = "Give 10"};
    {value =   1; text = "Give  1"};
    {value =  -1; text = "Take  1"};
    {value = -10; text = "Take 10"};
};
command_power.selection = 1;
command_power.description = function() return "PowerUPs: " .. ram.get_powerups_available(); end
command_power.doit = function(value) ram.add_powerups_available(value); end;
table.insert(commands, command_power);



local command_ice_block = {};
command_ice_block.options = {
    {value =  53; text = "Give 53"};
    {value =   1; text = "Give  1"};
    {value =  -1; text = "Take  1"};
    {value = -53; text = "Take 53"};
};
command_ice_block.selection = 1;
command_ice_block.description = function() return "IceBlocks: " .. ram.get_IceBlock_available(); end;
command_ice_block.doit = function(value) ram.add_IceBlock_available(value); end;
table.insert(commands, command_ice_block);



local command_RNG = {};
command_RNG.options = {
    {value =  1000; text = "Increase by 1000"};
    {value =   100; text = "Increase by  100"};
    {value =    10; text = "Increase by   10"};
    {value =     1; text = "Increase by    1"};
    {value =    -1; text = "Decrease by    1"};
    {value =   -10; text = "Decrease by   10"};
    {value =  -100; text = "Decrease by  100"};
    {value = -1000; text = "Decrease by 1000"};
};
command_RNG.selection = 1;
command_RNG.description = function() return string.format("RNG Index: %5s", (ram.rng.get_RNG_index() or "????")); end;
command_RNG.doit = function(value) ram.rng.adjust_RNG(value); end;
table.insert(commands, command_RNG);


local command_RNG = {};
command_RNG.options = {
    {value =  9999; text = "Increase by 9999"};
    {value =    64; text = "Increase by   64"};
    {value =     2; text = "Increase by    2"};
    {value =     1; text = "Increase by    1"};
    {value =    -1; text = "Decrease by    1"};
    {value =    -2; text = "Decrease by    2"};
    {value =   -64; text = "Decrease by   64"};
    {value = -9999; text = "Decrease by 9999"};
};
command_RNG.selection = 1;
command_RNG.description = function() return "Modify Steps: " .. ram.get_steps(); end;
command_RNG.doit = function(value) ram.add_steps(value); end;
table.insert(commands, command_RNG);



--[[
options = {};
table.insert(options, {value =  0x10; text = "Add      0x10  to  Progress"});
table.insert(options, {value =  0x01; text = "Add      0x01  to  Progress"});
table.insert(options, {value = -0x01; text = "Subtract 0x01 from Progress"});
table.insert(options, {value = -0x10; text = "Subtract 0x10 from Progress"});
options.selection = 1; -- default option
options.description = function() return string.format("Modify Progress Byte: %02X", ram.get_progress()); end;
options.doit = function(value) ram.add_progress(value); end;
table.insert(commands, options);

options = {};
table.insert(options, {value =  0x00; text = "0x00 New Game          "});
table.insert(options, {value =  0x06; text = "0x06 FireMan Defeated  "});
table.insert(options, {value =  0x20; text = "0x20 NumberMan Defeated"});
table.insert(options, {value =  0x22; text = "0x22 StoneMan Defeated "});
table.insert(options, {value =  0x26; text = "0x26 What Polar Bears? "});
table.insert(options, {value =  0x30; text = "0x30 IceMan Defeated   "});
table.insert(options, {value =  0x40; text = "0x40 ColorMan Defeated "});
table.insert(options, {value =  0x50; text = "0x50 ElecMan Defeated  "});
table.insert(options, {value =  0x52; text = "0x52 BombMan Defeated  "});
table.insert(options, {value =  0x54; text = "0x54 Expired WWW Pass  "});
options.selection = 1; -- default option
options.description = function() return string.format("Set Progress Byte: %02X", ram.get_progress()); end;
options.doit = function(value) ram.set_progress(value); end;
table.insert(commands, options);
--]]



local teleport_real_world = {};
function teleport_real_world.update_options(option_value)
    teleport_real_world.options = {};
    teleport_real_world.selection = 1;
    teleport_real_world.main_area = nil;
    
    if not option_value then
        teleport_real_world.description = function() return "Select a real world group:"; end;
        for i,group in pairs(ram.get_area_groups_real()) do
            table.insert( teleport_real_world.options, { value = group; text = ram.get_area_group_name(group); } );
        end
    else
        teleport_real_world.description = function() return "Select an area:"; end;
        teleport_real_world.main_area = option_value;
        table.insert( teleport_real_world.options, { value = nil; text = "Previous Menu"; } );
        for i=0,0xF do
            if ram.does_area_exist(option_value, i) then
                table.insert( teleport_real_world.options, { value = i; text = ram.get_area_name(option_value, i); } );
            end
        end
    end
end
teleport_real_world.update_options();
function teleport_real_world.doit(value)
    if teleport_real_world.main_area and value then
        ram.teleport(teleport_real_world.main_area, value);
    else
        teleport_real_world.update_options(value);
    end
end
table.insert(commands, teleport_real_world);



local teleport_digital_world = {};
function teleport_digital_world.update_options(option_value)
    teleport_digital_world.options = {};
    teleport_digital_world.selection = 1;
    teleport_digital_world.main_area = nil;
    
    if not option_value then
        teleport_digital_world.description = function() return "Select a digital world group:"; end;
        for i,group in pairs(ram.get_area_groups_digital()) do
            table.insert( teleport_digital_world.options, { value = group; text = ram.get_area_group_name(group); } );
        end
    else
        teleport_digital_world.description = function() return "Select an area:"; end;
        teleport_digital_world.main_area = option_value;
        table.insert( teleport_digital_world.options, { value = nil; text = "Previous Menu"; } );
        for i=0,0xF do
            if ram.does_area_exist(option_value, i) then
                table.insert( teleport_digital_world.options, { value = i; text = ram.get_area_name(option_value, i); } );
            end
        end
    end
end
teleport_digital_world.update_options();
function teleport_digital_world.doit(value)
    if teleport_digital_world.main_area and value then
        ram.teleport(teleport_digital_world.main_area, value);
    else
        teleport_digital_world.update_options(value);
    end
end
table.insert(commands, teleport_digital_world);



local command_kill = {};
command_kill.options = {
    {value = 0; text = "Everything"};
    {value = 1; text = "Enemy 1   "};
    {value = 2; text = "Enemy 2   "};
    {value = 3; text = "Enemy 3   "};
};
command_kill.selection = 1;
command_kill.description = function() return "Kill?"; end;
command_kill.doit = function(value) ram.kill_enemy(value); end;
table.insert(commands, command_kill);



return controls;

