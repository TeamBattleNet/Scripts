-- Commands for MMBN 2 scripting, enjoy.

local commands = {};

local game = require("BN2/Game");



local command_blank = {};
command_blank.options = {
    { value = nil; text = "Use Up or Down to change Options!"; };
    { value = nil; text = "Left or Right to change Commands!"; };
    { value = nil; text = "Use the controller or a keyboard!"; };
};
command_blank.selection = 1;
command_blank.description = function() return "Welcome to the Command list!"; end;
command_blank.doit = function() return; end;
table.insert(commands, command_blank);



local function fun_flag_helper(fun_flag, fun_text)
    if game.fun_flags[fun_flag] then
        fun_text = "[ ON] " .. fun_text;
    else
        fun_text = "[off] " .. fun_text;
    end
    return { value = fun_flag; text = fun_text; };
end

local command_fun_flags = {};
command_fun_flags.selection = 1;
function command_fun_flags.update_options(option_value)
    command_fun_flags.options = {};
    command_fun_flags.description = function() return "These Fun Flags Are:"; end;
    table.insert( command_fun_flags.options, fun_flag_helper("modulate_steps"     , "Step Modulation") );
    table.insert( command_fun_flags.options, fun_flag_helper("always_fullcust"    , "Always Fullcust") );
    table.insert( command_fun_flags.options, fun_flag_helper("no_chip_cooldown"   , "No Chip Cooldown") );
    table.insert( command_fun_flags.options, fun_flag_helper("delete_time_zero"   , "Set Delete Time to 0") );
    table.insert( command_fun_flags.options, fun_flag_helper("chip_selection_one" , "Always Choose  1 Chip") );
    table.insert( command_fun_flags.options, fun_flag_helper("chip_selection_max" , "Always Choose 15 Chips") );
    table.insert( command_fun_flags.options, fun_flag_helper("no_encounters"      , "Lock RNG to No  Encounters") );
    table.insert( command_fun_flags.options, fun_flag_helper("yes_encounters"     , "Lock RNG to Yes Encounters") );
end
command_fun_flags.update_options();
function command_fun_flags.doit(value)
    game.fun_flags[value] = not game.fun_flags[value];
    command_fun_flags.update_options();
end
table.insert(commands, command_fun_flags);



local command_items = {};
function command_items.update_options(option_value)
    command_items.options = {};
    command_items.selection = 1;
    command_items.FUNction = nil;
    
    if not option_value then
        command_items.description = function() return "What will U buy?"; end;
        table.insert( command_items.options, { value = 1; text = "Zenny"   ; } );
        table.insert( command_items.options, { value = 2; text = "PowerUP" ; } );
        table.insert( command_items.options, { value = 3; text = "HPMemory"; } );
    else
        table.insert( command_items.options, { value = nil; text = "Previous Menu"; } );
        if option_value == 1 then
            command_items.description = function() return string.format("Zenny: %11u", game.get_zenny()); end;
            table.insert( command_items.options, { value =  100000; text = "Increase by 100000"; } );
            table.insert( command_items.options, { value =   10000; text = "Increase by  10000"; } );
            table.insert( command_items.options, { value =    1000; text = "Increase by   1000"; } );
            table.insert( command_items.options, { value =     100; text = "Increase by    100"; } );
            table.insert( command_items.options, { value =    -100; text = "Decrease by    100"; } );
            table.insert( command_items.options, { value =   -1000; text = "Decrease by   1000"; } );
            table.insert( command_items.options, { value =  -10000; text = "Decrease by  10000"; } );
            table.insert( command_items.options, { value = -100000; text = "Decrease by 100000"; } );
            command_items.FUNction = function(value) game.add_zenny(value); end;
        elseif option_value == 2 then
            command_items.description = function() return string.format("PowerUPs: %2u", game.get_PowerUPs()); end;
            table.insert( command_items.options, { value =  10; text = "Give 10"; } );
            table.insert( command_items.options, { value =   1; text = "Give  1"; } );
            table.insert( command_items.options, { value =  -1; text = "Take  1"; } );
            table.insert( command_items.options, { value = -10; text = "Take 10"; } );
            command_items.FUNction = function(value) game.add_PowerUPs(value); end;
        elseif option_value == 3 then
            command_items.description = function() return string.format("HPMemory: %2u", game.get_HPMemory_count()); end;
            table.insert( command_items.options, { value = nil; text = "Apologies... That is sold out..."; } );
            command_items.FUNction = function(value) game.add_zenny(value); end;
        else
            command_items.description = function() return "Bzzt! (something broke)"; end;
        end
    end
end
command_items.update_options();
function command_items.doit(value)
    if command_items.FUNction and value then
        command_items.FUNction(value);
    else
        command_items.update_options(value);
    end
end
table.insert(commands, command_items);



local command_battle = {};
function command_battle.update_options(option_value)
    command_battle.options = {};
    command_battle.selection = 1;
    command_battle.FUNction = nil;
    
    if not option_value then
        command_battle.description = function() return "Boost which feature?"; end;
        table.insert( command_battle.options, { value = 1; text = "Buster & Styles"; } );
        table.insert( command_battle.options, { value = 2; text = "Battlechips"; } );
    else
        table.insert( command_battle.options, { value = nil; text = "Previous Menu"; } );
        if option_value == 1 then
            command_battle.description = function() return string.format("Power Level: %4u", game.calculate_mega_level()); end;
            table.insert( command_battle.options, { value = game.reset_buster_stats; text = "Reset Buster Stats"; } );
            table.insert( command_battle.options, { value = game.max_buster_stats;   text = "Max   Buster Stats"; } );
            table.insert( command_battle.options, { value = game.hub_buster_stats;   text = "Hub   Buster Stats"; } );
            table.insert( command_battle.options, { value = game.set_style;          text = "Become AquaCust!"; } );
            table.insert( command_battle.options, { value = game.set_style;          text = "Become HubStyle!"; } );
            command_battle.FUNction = function(value) value(); end;
        elseif option_value == 2 then
            command_battle.description = function() return string.format("Customize or Randomize!"); end;
            table.insert( command_battle.options, { value = function() game.set_all_folder_to_code(0); end; text = "Monocode A Folder";      } );
            table.insert( command_battle.options, { value = function() game.randomize_folder_codes( ); end; text = "Randomize Folder Codes"; } );
            table.insert( command_battle.options, { value = function() game.randomize_folder_IDs(   ); end; text = "Randomize Folder IDs";   } );
            table.insert( command_battle.options, { value = function() game.set_all_folder_to_ID(  1); end; text = "Only Draw Cannon!";     } );
            command_battle.FUNction = function(value) value(); end;
        else
            command_battle.description = function() return "Bzzt! (something broke)"; end;
        end
    end
end
command_battle.update_options();
function command_battle.doit(value)
    if command_battle.FUNction and value then
        command_battle.FUNction(value);
    else
        command_battle.update_options(value);
    end
end
table.insert(commands, command_battle);



local command_combat = {};
command_combat.selection = 1;
command_combat.description = function() return "Battle Options:"; end;
command_combat.options = {
    { value = function() game.kill_enemy(0);     end; text = "Delete Everything";    };
    { value = function() game.kill_enemy(1);     end; text = "Delete Enemy 1";       };
    { value = function() game.kill_enemy(2);     end; text = "Delete Enemy 2";       };
    { value = function() game.kill_enemy(3);     end; text = "Delete Enemy 3";       };
    { value = function() game.draw_only_slot(0); end; text = "All Draws Are Slot 1"; };
    { value = game.draw_in_order;                     text = "Draw In Order";        };
};
command_combat.doit = function(value) value(); end;
table.insert(commands, command_combat);



local command_routing = {};
function command_routing.update_options(option_value)
    command_routing.options = {};
    command_routing.selection = 1;
    command_routing.FUNction = nil;
    
    if not option_value then
        command_routing.description = function() return "Wanna see some RNG manip?"; end;
        table.insert( command_routing.options, { value = 1; text = "RNG Index"   ; } );
        table.insert( command_routing.options, { value = 2; text = "Step Counter" ; } );
        table.insert( command_routing.options, { value = 3; text = "Flag Flipper" ; } );
    else
        table.insert( command_routing.options, { value = nil; text = "Previous Menu"; } );
        if option_value == 1 then
            command_routing.description = function() return string.format("RNG Index: %5s", (game.ram.get.RNG_index() or "?????")); end;
            table.insert( command_routing.options, { value =  1000; text = "Increase by 1000"; } );
            table.insert( command_routing.options, { value =   100; text = "Increase by  100"; } );
            table.insert( command_routing.options, { value =    10; text = "Increase by   10"; } );
            table.insert( command_routing.options, { value =     1; text = "Increase by    1"; } );
            table.insert( command_routing.options, { value =    -1; text = "Decrease by    1"; } );
            table.insert( command_routing.options, { value =   -10; text = "Decrease by   10"; } );
            table.insert( command_routing.options, { value =  -100; text = "Decrease by  100"; } );
            table.insert( command_routing.options, { value = -1000; text = "Decrease by 1000"; } );
            command_routing.FUNction = function(value) game.ram.adjust_RNG(value); end;
        elseif option_value == 2 then
            command_routing.description = function() return string.format("Modify Steps: %5s", game.get_steps()); end;
            table.insert( command_routing.options, { value =  1024; text = "Increase by 1024"; } );
            table.insert( command_routing.options, { value =    64; text = "Increase by   64"; } );
            table.insert( command_routing.options, { value =     2; text = "Increase by    2"; } );
            table.insert( command_routing.options, { value =     1; text = "Increase by    1"; } );
            table.insert( command_routing.options, { value =    -1; text = "Decrease by    1"; } );
            table.insert( command_routing.options, { value =    -2; text = "Decrease by    2"; } );
            table.insert( command_routing.options, { value =   -64; text = "Decrease by   64"; } );
            table.insert( command_routing.options, { value = -1024; text = "Decrease by 1024"; } );
            command_routing.FUNction = function(value) game.add_steps(value); end;
        elseif option_value == 3 then
            command_routing.description = function() return "Bits, Nibbles, Bytes, and Words."; end;
            table.insert( command_routing.options, { value = function() game.set_RNG_index(1) end;  text = "Restart RNG";  } );
            command_routing.FUNction = function(value) value(); end;
        else
            command_routing.description = function() return "Bzzt! (something broke)"; end;
        end
    end
end
command_routing.update_options();
function command_routing.doit(value)
    if command_routing.FUNction and value then
        command_routing.FUNction(value);
    else
        command_routing.update_options(value);
    end
end
table.insert(commands, command_routing);



local command_progress = {};
function command_progress.update_options(option_value)
    command_progress.options = {};
    command_progress.selection = 1;
    command_progress.scenario = nil;
    
    if not option_value then
        command_progress.description = function() return "Select a Progress scenario:"; end;
        table.insert( command_progress.options, { value = 0x00; text = "0x00 Scenario 1";  } );
        table.insert( command_progress.options, { value = 0x10; text = "0x10 Scenario 2";  } );
        table.insert( command_progress.options, { value = 0x20; text = "0x20 Scenario 3";  } );
        table.insert( command_progress.options, { value = 0x30; text = "0x30 Scenario 4";  } );
        table.insert( command_progress.options, { value = 0x40; text = "0x40 Scenario 5";  } );
        table.insert( command_progress.options, { value = 0x50; text = "0x50 Scenario 6";  } );
        table.insert( command_progress.options, { value = 0x60; text = "0x60 Scenario 7";  } );
        table.insert( command_progress.options, { value = 0x70; text = "0x70 Scenario 7";  } );
    else
        command_progress.description = function() return "Select a Progress value:"; end;
        command_progress.scenario = option_value;
        table.insert( command_progress.options, { value = nil; text = "Previous Menu"; } );
        for i=option_value,option_value+0xF do
            if game.is_progress_valid(i) then
                table.insert( command_progress.options, { value = i; text = string.format("0x%02X: %s", i, game.get_progress_name(i)); } );
            end
        end
    end
end
command_progress.update_options();
function command_progress.doit(value)
    if command_progress.scenario and value then
        game.set_progress(value);
    else
        command_progress.update_options(value);
    end
end
table.insert(commands, command_progress);



local teleport_real_world = {};
function teleport_real_world.update_options(option_value)
    teleport_real_world.options = {};
    teleport_real_world.selection = 1;
    teleport_real_world.main_area = nil;
    
    if not option_value then
        teleport_real_world.description = function() return "Select a real world group:"; end;
        for i,group in pairs(game.get_area_groups_real()) do
            table.insert( teleport_real_world.options, { value = group; text = game.get_area_group_name(group); } );
        end
    else
        teleport_real_world.description = function() return "Select an area:"; end;
        teleport_real_world.main_area = option_value;
        table.insert( teleport_real_world.options, { value = nil; text = "Previous Menu"; } );
        for i=0,0xF do
            if game.does_area_exist(option_value, i) then
                table.insert( teleport_real_world.options, { value = i; text = game.get_area_name(option_value, i); } );
            end
        end
    end
end
teleport_real_world.update_options();
function teleport_real_world.doit(value)
    if teleport_real_world.main_area and value then
        game.teleport(teleport_real_world.main_area, value);
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
        for i,group in pairs(game.get_area_groups_digital()) do
            table.insert( teleport_digital_world.options, { value = group; text = game.get_area_group_name(group); } );
        end
    else
        teleport_digital_world.description = function() return "Select an area:"; end;
        teleport_digital_world.main_area = option_value;
        table.insert( teleport_digital_world.options, { value = nil; text = "Previous Menu"; } );
        for i=0,0xF do
            if game.does_area_exist(option_value, i) then
                table.insert( teleport_digital_world.options, { value = i; text = game.get_area_name(option_value, i); } );
            end
        end
    end
end
teleport_digital_world.update_options();
function teleport_digital_world.doit(value)
    if teleport_digital_world.main_area and value then
        game.teleport(teleport_digital_world.main_area, value);
    else
        teleport_digital_world.update_options(value);
    end
end
table.insert(commands, teleport_digital_world);



local command_setups = {};
function command_setups.update_options(option_value)
    command_setups.options = {};
    command_setups.selection = 1;
    command_setups.FUNction = nil;
    command_setups.enable_inputs = false;
    
    if not option_value then
        command_setups.description = function() return "What Kind Of Button Pressing?"; end;
        table.insert( command_setups.options, { value = 1; text = "Regular Kind" ; } );
        table.insert( command_setups.options, { value = 2; text = "Folder Edits" ; } );
    else
        command_setups.enable_inputs = true;
        table.insert( command_setups.options, { value = nil; text = "Previous Menu"; } );
        if option_value == 1 then
            command_setups.description = function() return "Automated Button Pressing:"; end;
            for i,setup in pairs(require("BN2/Setups").sequences) do
                table.insert( command_setups.options, { value = setup.doit; text = setup.description; } );
            end
            command_setups.FUNction = function(value) value(); end;
        elseif option_value == 2 then
            command_setups.description = function() return "Automated Folder Edits:"; end;
            for i,setup in pairs(require("BN2/Setups").folder_edits) do
                table.insert( command_setups.options, { value = setup.doit; text = setup.description; } );
            end
            command_setups.FUNction = function(value) value(); end;
        else
            command_setups.description = function() return "Bzzt! (something broke)"; end;
        end
    end
end
command_setups.update_options();
function command_setups.doit(value)
    if command_setups.FUNction and value then
        command_setups.FUNction(value);
    else
        command_setups.update_options(value);
    end
end
table.insert(commands, command_setups);



return controls;

