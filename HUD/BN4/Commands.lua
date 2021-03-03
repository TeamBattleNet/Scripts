-- Commands for MMBN scripting, enjoy.

local commands = require("All/Commands");

commands.game = require("BN4/Game");

for i,command in pairs(commands.general) do
    if command.update_options then
        command.update_options();
    end
end

table.insert(commands.commands, commands.general.command_menu);

local function fun_flag_helper(fun_flag, fun_text)
    if commands.game.fun_flags[fun_flag] then
        fun_text = "[ ON] " .. fun_text;
    else
        fun_text = "[off] " .. fun_text;
    end
    return { value = fun_flag; text = fun_text; };
end

local command_fun_flags = {};
command_fun_flags.selection = 1;
command_fun_flags.description = function() return "These Fun Flags Are:"; end;
function command_fun_flags.update_options(option_value)
    command_fun_flags.options = {};
    table.insert( command_fun_flags.options, fun_flag_helper("modulate_steps"     , "Step Modulation"           ) );
    --table.insert( command_fun_flags.options, fun_flag_helper("always_fullcust"    , "Always Full cust"          ) );
    --table.insert( command_fun_flags.options, fun_flag_helper("always_emptycust"   , "Always Empty cust"         ) );
    --table.insert( command_fun_flags.options, fun_flag_helper("delete_time_zero"   , "Set Delete Time to 0"      ) );
    --table.insert( command_fun_flags.options, fun_flag_helper("chip_selection_one" , "Always Choose  1 Chip"     ) );
    --table.insert( command_fun_flags.options, fun_flag_helper("chip_selection_max" , "Always Choose 10 Chips"    ) );
    table.insert( command_fun_flags.options, fun_flag_helper("no_encounters"      , "Lock RNG to No  Encounters") );
    table.insert( command_fun_flags.options, fun_flag_helper("yes_encounters"     , "Lock RNG to Yes Encounters") );
    --table.insert( command_fun_flags.options, fun_flag_helper("is_routing"         , "Display Routing Messages"  ) );
    --table.insert( command_fun_flags.options, fun_flag_helper("randomize_colors"   , "Randomize Color Palette"   ) );
end
command_fun_flags.update_options();
function command_fun_flags.doit(value)
    commands.game.fun_flags[value] = not commands.game.fun_flags[value];
    command_fun_flags.update_options();
end
table.insert(commands.commands, command_fun_flags);

table.insert(commands.commands, commands.general.command_progress);
table.insert(commands.commands, commands.general.teleport_real_world);
table.insert(commands.commands, commands.general.teleport_digital_world);
table.insert(commands.commands, commands.general.command_setups);

return commands.commands;

