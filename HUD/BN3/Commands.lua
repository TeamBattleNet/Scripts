-- Commands for the HUD Script for Mega Man Battle Network 3 Scripting by Tterraj42, enjoy.

local ram = require("BN3/RAM");

local commands = {};
commands.index = 1;
commands.options = {};
commands.changed = false;
commands.message = "";
commands.funcs = {};

commands.display_mode = 1;
commands.skip_encounters = false;

function commands.next()
    commands.index = (commands.index % table.getn(commands.options)) + 1;
    commands.options[commands.index].text_func();
end

function commands.previous()
    commands.index = commands.index - 1;
    if commands.index == 0 then
        commands.index = table.getn(commands.options);
    end
    commands.options[commands.index].text_func();
end

table.insert(commands.options, {
    text_func = function() commands.message = "Settings Menu"; return "Welcome to the Settings Menu!"; end,
      up_text = "Do nothing!",
      up_func = function() commands.message = ""; end,
    down_text = "Do nothing!",
    down_func = function() commands.message = ""; end
});

table.insert(commands.options, {
    text_func = function() commands.message = "Modifying Zenny by 100"; return "Modify Zenny: " .. ram.get_zenny(); end,
      up_text = "Add    100 Zenny",
      up_func = function() commands.message = "Added   100 Zenny"; ram.add_zenny(100); end,
    down_text = "Remove 100 Zenny",
    down_func = function() commands.message = "Removed 100 Zenny"; ram.add_zenny(-100); end
});

table.insert(commands.options, {
    text_func = function() commands.message = "Modifying Zenny by 1000"; return "Modify Zenny: " .. ram.get_zenny(); end,
      up_text = "Add    1000 Zenny",
      up_func = function() commands.message = "Added   1000 Zenny"; ram.add_zenny(1000); end,
    down_text = "Remove 1000 Zenny",
    down_func = function() commands.message = "Removed 1000 Zenny"; ram.add_zenny(-1000); end
});

table.insert(commands.options, {
    text_func = function() commands.message = "Modifying Bug Frags by 1"; return "Modify Bug Frags: " .. ram.get_frags(); end,
      up_text = "Add    1 Bug Frag",
      up_func = function() commands.message = "Added   1 Bug Frag"; ram.add_frags(1); end,
    down_text = "Remove 1 Bug Frag",
    down_func = function() commands.message = "Removed 1 Bug Frag"; ram.add_frags(-1); end
});

table.insert(commands.options, {
    text_func = function() commands.message = "Modifying Bug Frags by 10"; return "Modify Bug Frags: " .. ram.get_frags(); end,
      up_text = "Add    10 Bug Frag",
      up_func = function() commands.message = "Added   10 Bug Frag"; ram.add_frags(10); end,
    down_text = "Remove 10 Bug Frag",
    down_func = function() commands.message = "Removed 10 Bug Frag"; ram.add_frags(-10); end
});

table.insert(commands.options, {
    text_func = function() commands.message = "Toggling Encounter Skip"; return "Toggle Random Encounter Skip: " .. tostring(commands.skip_encounters); end,
      up_text = "Enable  Encounter Skip",
      up_func = function() commands.message = "Encounter Skip Enabled"; commands.skip_encounters = true; end,
    down_text = "Disable Encounter Skip",
    down_func = function() commands.message = "Encounter Skip Disabled"; commands.skip_encounters = false; end
});

return commands;

