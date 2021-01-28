-- Commands for the HUD Script for MMBN 3, enjoy.

local ram = require("BN3/RAM");

local controls = {};

local command_index = 1;

local commands = {};
local options = {};

--[[

function controls.next()
    command_index = (command_index % table.getn(commands)) + 1;
    local command = commands[command_index];
    print(command.text);
    gui.addmessage(command.text);
end

function controls.previous()
    command_index = command_index - 1;
    if command_index == 0 then
        command_index = table.getn(commands);
    end
    local command = commands[command_index];
    print(command.text);
    gui.addmessage(command.text);
end

function controls.option_down()
    local command = commands[command_index];
    command.selection = (command.selection % table.getn(command.options)) + 1;
    local option = command.options[command.selection];
    print("Selected: " .. option.text);
    gui.addmessage("Selected: " .. option.text);
end

function controls.option_up()
  local command = commands[command_index];
  command.selection = command.selection - 1;
  if command.selection == 0 then
      command.selection = table.getn(command.options);
  end
  local option = command.options[command.selection];
  print("Selected: " .. option.text);
  gui.addmessage("Selected: " .. option.text);
end

function controls.doit()
    local command = commands[command_index];
    local option = command.options[command.selection];
    print(option.text);
    gui.addmessage(option.text);
    command.doit(option.value);
end

function controls.display_options()
    local command = commands[command_index];
    local option = command.options[command.selection];
    local options = command.text;
    for key, value in pairs(options) do
        print("["..key.."]", " -- ", value);
    end
    for i=1,table.getn(command.options) do
        print("["..i.."]" .. options[i]);
    end
    local command = commands[command_index];
    local option = command.options[command.selection].
    print(option.text);
    options = options .. "\n[1] Increase Main RNG by 100"
    options = options .. "\n[2] Increase Main RNG by  10"
    options = options .. "\n[3] Increase Main RNG by   1"
    options = options .. "\n[4] Decrease Main RNG by   1 <--"
    options = options .. "\n[5] Decrease Main RNG by  10"
    options = options .. "\n[6] Decrease Main RNG by 100"
    return options;
end

------------------------------------------------------------------------------------------------------------------------

options = {};
table.insert(options, {value = 100; text = "Increase Main RNG by 100"});
table.insert(options, {value =  10; text = "Increase Main RNG by  10"});
table.insert(options, {value =   1; text = "Increase Main RNG by   1"});
table.insert(options, {value =   1; text = "Decrease Main RNG by   1"});
table.insert(options, {value =  10; text = "Decrease Main RNG by  10"});
table.insert(options, {value = 100; text = "Decrease Main RNG by 100"});
options.selection = 3; -- default option
options.text = "Modify Main RNG";
options.doit = function(value) ram.rng.adjust_main_RNG(value); end;
table.insert(commands, options);

table.insert(commands.options, {
      up_text = "Do nothing!",
      up_func = function() commands.message = ""; end,
    down_text = "Do nothing!",
    down_func = function() commands.message = ""; end,
    text_func = function() commands.message = "Settings Menu"; return "Welcome to the Settings Menu!"; end
});

table.insert(commands.options, {
      up_text = "Advance Main RNG by 1",
      up_func = function() commands.message = "Advanced Main RNG by 1"; ram.rng.adjust_main_RNG(1); end,
    down_text = "Reverse Main RNG by 1",
    down_func = function() commands.message = "Reversed Main RNG by 1"; ram.rng.adjust_main_RNG(-1); end,
    text_func = function() commands.message = "Modifying Main RNG by 1";
        return string.format("Modify Main RNG: %4s: %08X", (ram.rng.get_main_RNG_index() or "????"), ram.rng.get_main_RNG_value()); end
});

table.insert(commands.options, {
      up_text = "Advance Main RNG by 10",
      up_func = function() commands.message = "Advanced Main RNG by 10"; ram.rng.adjust_main_RNG(10); end,
    down_text = "Reverse Main RNG by 10",
    down_func = function() commands.message = "Reversed Main RNG by 10"; ram.rng.adjust_main_RNG(-10); end,
    text_func = function() commands.message = "Modifying Main RNG by 10";
        return string.format("Modify Main RNG: %4s: %08X", (ram.rng.get_main_RNG_index() or "????"), ram.rng.get_main_RNG_value()); end
});

table.insert(commands.options, {
      up_text = "Advance Sub RNG by 1",
      up_func = function() commands.message = "Advanced Sub RNG by 1"; ram.rng.adjust_sub_RNG(1); end,
    down_text = "Reverse Sub RNG by 1",
    down_func = function() commands.message = "Reversed Sub RNG by 1"; ram.rng.adjust_sub_RNG(-1); end,
    text_func = function() commands.message = "Modifying Sub RNG by 1";
        return string.format("Modify Sub RNG: %4s: %08X", (ram.rng.get_sub_RNG_index() or "????"), ram.rng.get_sub_RNG_value()); end
});

table.insert(commands.options, {
      up_text = "Advance Sub RNG by 10",
      up_func = function() commands.message = "Advanced Sub RNG by 10"; ram.rng.adjust_sub_RNG(10); end,
    down_text = "Reverse Sub RNG by 10",
    down_func = function() commands.message = "Reversed Sub RNG by 10"; ram.rng.adjust_sub_RNG(-10); end,
    text_func = function() commands.message = "Modifying Sub RNG by 10";
        return string.format("Modify Sub RNG: %4s: %08X", (ram.rng.get_sub_RNG_index() or "????"), ram.rng.get_sub_RNG_value()); end
});

table.insert(commands.options, {
      up_text = "Increase Steps by 2",
      up_func = function() commands.message = "Increased Steps by 2"; ram.add_steps(2); end,
    down_text = "Reduce   Steps by 2",
    down_func = function() commands.message = "Reduced   Steps by 2"; ram.add_steps(-2); end,
    text_func = function() commands.message = "Modifying Steps by 2"; return "Modify Steps: " .. ram.get_steps(); end
});

table.insert(commands.options, {
  up_text = "Increase Steps by 64",
  up_func = function() commands.message = "Increased Steps by 64"; ram.add_steps(64); end,
down_text = "Reduce   Steps by 64",
down_func = function() commands.message = "Reduced   Steps by 64"; ram.add_steps(-64); end,
text_func = function() commands.message = "Modifying Steps by 64"; return "Modify Steps: " .. ram.get_steps(); end
});

table.insert(commands.options, {
      up_text = "Add    100 Zenny",
      up_func = function() commands.message = "Added   100 Zenny"; ram.add_zenny(100); end,
    down_text = "Remove 100 Zenny",
    down_func = function() commands.message = "Removed 100 Zenny"; ram.add_zenny(-100); end,
    text_func = function() commands.message = "Modifying Zenny by 100"; return "Modify Zenny: " .. ram.get_zenny(); end
});

table.insert(commands.options, {
      up_text = "Add    1000 Zenny",
      up_func = function() commands.message = "Added   1000 Zenny"; ram.add_zenny(1000); end,
    down_text = "Remove 1000 Zenny",
    down_func = function() commands.message = "Removed 1000 Zenny"; ram.add_zenny(-1000); end,
    text_func = function() commands.message = "Modifying Zenny by 1000"; return "Modify Zenny: " .. ram.get_zenny(); end
});

table.insert(commands.options, {
      up_text = "Add    1 Bug Frag",
      up_func = function() commands.message = "Added   1 Bug Frag"; ram.add_bug_frags(1); end,
    down_text = "Remove 1 Bug Frag",
    down_func = function() commands.message = "Removed 1 Bug Frag"; ram.add_bug_frags(-1); end,
    text_func = function() commands.message = "Modifying Bug Frags by 1"; return "Modify Bug Frags: " .. ram.get_bug_frags(); end
});

table.insert(commands.options, {
      up_text = "Add    10 Bug Frag",
      up_func = function() commands.message = "Added   10 Bug Frag"; ram.add_bug_frags(10); end,
    down_text = "Remove 10 Bug Frag",
    down_func = function() commands.message = "Removed 10 Bug Frag"; ram.add_bug_frags(-10); end,
    text_func = function() commands.message = "Modifying Bug Frags by 10"; return "Modify Bug Frags: " .. ram.get_bug_frags(); end
});

table.insert(commands.options, {
      up_text = "Enable  Encounter Skip",
      up_func = function() commands.message = "Encounter Skip Enabled" ; ram.skip_encounters =  true; end,
    down_text = "Disable Encounter Skip",
    down_func = function() commands.message = "Encounter Skip Disabled"; ram.skip_encounters = false; end,
    text_func = function() commands.message = "Toggling Encounter Skip"; return "Toggle Random Encounter Skip: " .. tostring(ram.skip_encounters); end
});

--]]

return controls;

