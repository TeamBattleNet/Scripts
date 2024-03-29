-- Commands for MMBN 3 scripting, enjoy.

local commands = require("All/Commands"); -- Menu, Flags, Battle, Items, RNG, Progress, Real, Digital, Setups

commands.game = require("BN3/Game");
commands.setup_groups = require("BN3/Setups");

for i,command in pairs(commands.general) do
    if command.update_options then
        command.update_options();
    end
end

table.insert(commands.commands, commands.general.command_menu);

---------------------------------------- Flags ----------------------------------------

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
    table.insert( command_fun_flags.options, fun_flag_helper("always_fullcust"    , "Always Fullcust"           ) );
    table.insert( command_fun_flags.options, fun_flag_helper("delete_time_zero"   , "Set Delete Time to 0"      ) );
    table.insert( command_fun_flags.options, fun_flag_helper("chip_selection_one" , "Always Choose  1 Chip"     ) );
    table.insert( command_fun_flags.options, fun_flag_helper("chip_selection_max" , "Always Choose 10 Chips"    ) );
    table.insert( command_fun_flags.options, fun_flag_helper("no_encounters"      , "Lock RNG to No  Encounters") );
    table.insert( command_fun_flags.options, fun_flag_helper("maybe_encounters"   , "Lock RNG to ??? Encounters") );
    table.insert( command_fun_flags.options, fun_flag_helper("yes_encounters"     , "Lock RNG to Yes Encounters") );
    table.insert( command_fun_flags.options, fun_flag_helper("is_routing"         , "Display Routing Messages"  ) );
    table.insert( command_fun_flags.options, fun_flag_helper("randomize_colors"   , "Randomize Color Palette"   ) );
end
command_fun_flags.update_options();
function command_fun_flags.doit(value)
    commands.game.fun_flags[value] = not commands.game.fun_flags[value];
    command_fun_flags.update_options();
end
table.insert(commands.commands, command_fun_flags);

---------------------------------------- Battle ----------------------------------------

local command_battle = {};
command_battle.selection = 1;
command_battle.description = function() return "Battle Options:"; end;
command_battle.options = {
    { value = function() commands.game.kill_enemy(0);       end; text = "Delete Everything"     ; };
    { value = function() commands.game.kill_enemy(1);       end; text = "Delete Enemy 1"        ; };
    { value = function() commands.game.kill_enemy(2);       end; text = "Delete Enemy 2"        ; };
    { value = function() commands.game.kill_enemy(3);       end; text = "Delete Enemy 3"        ; };
    { value = function() commands.game.draw_in_order();     end; text = "Draw Slots: In Order"  ; };
    { value = function() commands.game.draw_in_random();    end; text = "Draw Slots: Reshuffle" ; };
    { value = function() commands.game.draw_only_slot(0);   end; text = "Draw Slots: All Slot 1"; };
    { value = function() commands.game.set_reg_capacity(0); end; text = " 0 Reg MB"             ; };
    { value = function() commands.game.max_reg_capacity();  end; text = "99 Reg MB"             ; };
};
command_battle.doit = function(value) value(); end;
table.insert(commands.commands, command_battle);

---------------------------------------- Items ----------------------------------------

local command_items = {};
command_items.sub_selection = 1;
function command_items.update_options(option_value)
    command_items.options = {};
    command_items.FUNction = nil;
    
    if not option_value then
        command_items.selection = command_items.sub_selection;
        command_items.description = function() return "What will U buy?"; end;
        table.insert( command_items.options, { value = 1; text = "Zenny"    ; } );
        table.insert( command_items.options, { value = 2; text = "BugFrags" ; } );
        table.insert( command_items.options, { value = 3; text = "NaviCust" ; } );
        table.insert( command_items.options, { value = 4; text = "HPMemory" ; } );
        table.insert( command_items.options, { value = 5; text = "Equipment"; } );
        table.insert( command_items.options, { value = 6; text = "Folders"  ; } );
		table.insert( command_items.options, { value = 7; text = "Style Element"  ; } );
		table.insert( command_items.options, { value = 8; text = "Style Type"  ; } );
    else
        command_items.sub_selection = command_items.selection;
        command_items.selection = 1;
        table.insert( command_items.options, { value = nil; text = "Previous Menu"; } );
        if option_value == 1 then
            command_items.description = function() return string.format("Zenny: %11u", commands.game.get_zenny()); end;
            table.insert( command_items.options, { value =  100000; text = "Increase by 100000"; } );
            table.insert( command_items.options, { value =   10000; text = "Increase by  10000"; } );
            table.insert( command_items.options, { value =    1000; text = "Increase by   1000"; } );
            table.insert( command_items.options, { value =     100; text = "Increase by    100"; } );
            table.insert( command_items.options, { value =    -100; text = "Decrease by    100"; } );
            table.insert( command_items.options, { value =   -1000; text = "Decrease by   1000"; } );
            table.insert( command_items.options, { value =  -10000; text = "Decrease by  10000"; } );
            table.insert( command_items.options, { value = -100000; text = "Decrease by 100000"; } );
            command_items.FUNction = function(value) commands.game.add_zenny(value); end;
        elseif option_value == 2 then
            command_items.description = function() return string.format("BugFrags: %3u", commands.game.get_bug_frags()); end;
            table.insert( command_items.options, { value =  1000; text = "Give 1000"; } );
            table.insert( command_items.options, { value =   100; text = "Give  100"; } );
            table.insert( command_items.options, { value =    10; text = "Give   10"; } );
            table.insert( command_items.options, { value =     1; text = "Give    1"; } );
            table.insert( command_items.options, { value =    -1; text = "Take    1"; } );
            table.insert( command_items.options, { value =   -10; text = "Take   10"; } );
            table.insert( command_items.options, { value =  -100; text = "Take  100"; } );
            table.insert( command_items.options, { value = -1000; text = "Take 1000"; } );
            command_items.FUNction = function(value) commands.game.add_bug_frags(value); end;
        elseif option_value == 3 then
            command_items.description = function() return "Soon(TM)"; end;
            table.insert( command_items.options, { value = nil; text = "Apologies... That is sold out..."; } );
        elseif option_value == 4 then
            command_items.description = function() return string.format("HPMemory: %2u", commands.game.get_HPMemory_count()); end;
            table.insert( command_items.options, { value = nil; text = "Apologies... That is sold out..."; } );
        elseif option_value == 5 then
            command_items.description = function() return string.format("Power Level: %4u", commands.game.calculate_mega_level()); end;
            table.insert( command_items.options, { value = nil; text = "Apologies... That is sold out..."; } );
        elseif option_value == 6 then
            command_items.description = function() return "Sponsored by TeamBN"; end;
            table.insert( command_items.options, { value = function() commands.game.fill_library_standard(         ); end; text = "Library: Fill Standard"        ; } );
            table.insert( command_items.options, { value = function() commands.game.fill_library_mega(             ); end; text = "Library: Fill Mega"            ; } );
            table.insert( command_items.options, { value = function() commands.game.fill_library_mist_bowl(        ); end; text = "Library: Fill Mist/Bowl"       ; } );
            table.insert( command_items.options, { value = function() commands.game.set_all_folder_code_to(1,     0); end; text = "Folder: Monocode A Folder"     ; } );
            table.insert( command_items.options, { value = function() commands.game.randomize_folder_codes(1       ); end; text = "Folder: Randomize Folder Codes"; } );
            table.insert( command_items.options, { value = function() commands.game.overwrite_folder_press_a(      ); end; text = "Folder: Just PressA"           ; } );
            table.insert( command_items.options, { value = function() commands.game.overwrite_folder_manip(        ); end; text = "Folder: Any% Manip"           ; } );
            table.insert( command_items.options, { value = function() commands.game.randomize_folder_IDs_standard(1); end; text = "Folder: Randomize Folder IDs"  ; } );
            --table.insert( command_items.options, { value = function() commands.game.randomize_folder_IDs_anything(1); end; text = "Folder: Super Randomize IDs"   ; } );
            command_items.FUNction = function(value) value(); end;
		elseif option_value == 7 then
            command_items.description = function() return "Overrides Current Saved Element"; end;
            table.insert( command_items.options, { value = function() commands.game.set_style_element(0            ); end; text = "Normal Element"     ; } );
			table.insert( command_items.options, { value = function() commands.game.set_style_element(1            ); end; text = "Elec Element"       ; } );
			table.insert( command_items.options, { value = function() commands.game.set_style_element(2            ); end; text = "Heat Element"       ; } );
			table.insert( command_items.options, { value = function() commands.game.set_style_element(3            ); end; text = "Aqua Element"       ; } );
			table.insert( command_items.options, { value = function() commands.game.set_style_element(4            ); end; text = "Wood Element"       ; } );
            command_items.FUNction = function(value) value(); end;
		elseif option_value == 8 then
            command_items.description = function() return "Overrides Current Saved Style"; end;
			table.insert( command_items.options, { value = function() commands.game.set_style(0                    ); end; text = "Normal Style"       ; } );
			table.insert( command_items.options, { value = function() commands.game.set_style(1                    ); end; text = "Guts Style"         ; } );
			table.insert( command_items.options, { value = function() commands.game.set_style(2                    ); end; text = "Custom Style"       ; } );
			table.insert( command_items.options, { value = function() commands.game.set_style(3                    ); end; text = "Team Style"         ; } );
			table.insert( command_items.options, { value = function() commands.game.set_style(4                    ); end; text = "Shield Style"       ; } );
			table.insert( command_items.options, { value = function() commands.game.set_style(5                    ); end; text = "Ground Style"       ; } );
			table.insert( command_items.options, { value = function() commands.game.set_style(6                    ); end; text = "Shadow Style"       ; } );
			table.insert( command_items.options, { value = function() commands.game.set_style(7                    ); end; text = "Bug Style"          ; } );
            command_items.FUNction = function(value) value(); end;
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
table.insert(commands.commands, command_items);

---------------------------------------- Routing ----------------------------------------

commands.game.fun_flags.test_level = 14; -- I hit that 6% every. single. time. - BN 3 runners
commands.game.fun_flags.encounter_threshold = 0x1C; -- highest possible threshold

local command_routing = {};
command_routing.sub_selection = 1;
function command_routing.update_options(option_value)
    command_routing.options = {};
    command_routing.FUNction = nil;
    
    if not option_value then
        command_routing.selection = command_routing.sub_selection;
        command_routing.description = function() return "Wanna see some RNG manip?"; end;
        table.insert( command_routing.options, { value = 1; text = "Main RNG Index"   ; } );
        table.insert( command_routing.options, { value = 2; text = "Lazy RNG Index"   ; } );
        table.insert( command_routing.options, { value = 3; text = "Step Counter"     ; } );
        table.insert( command_routing.options, { value = 4; text = "Encounter Checks" ; } );
        table.insert( command_routing.options, { value = 5; text = "Flag Flipper"     ; } );
    else
        command_routing.sub_selection = command_routing.selection;
        command_routing.selection = 1;
        table.insert( command_routing.options, { value = nil; text = "Previous Menu"; } );
        if option_value == 1 then
            command_routing.description = function() return string.format("Main RNG Index: %5s", (commands.game.get_main_RNG_index() or "?????")); end;
            table.insert( command_routing.options, { value =  1000; text = "Increase by 1000"; } );
            table.insert( command_routing.options, { value =   100; text = "Increase by  100"; } );
            table.insert( command_routing.options, { value =    10; text = "Increase by   10"; } );
            table.insert( command_routing.options, { value =     1; text = "Increase by    1"; } );
            table.insert( command_routing.options, { value =    -1; text = "Decrease by    1"; } );
            table.insert( command_routing.options, { value =   -10; text = "Decrease by   10"; } );
            table.insert( command_routing.options, { value =  -100; text = "Decrease by  100"; } );
            table.insert( command_routing.options, { value = -1000; text = "Decrease by 1000"; } );
            command_routing.FUNction = function(value) commands.game.adjust_main_RNG(value); end;
        elseif option_value == 2 then
            command_routing.description = function() return string.format("Lazy RNG Index: %5s", (commands.game.get_lazy_RNG_index() or "?????")); end;
            table.insert( command_routing.options, { value =  1000; text = "Increase by 1000"; } );
            table.insert( command_routing.options, { value =   100; text = "Increase by  100"; } );
            table.insert( command_routing.options, { value =    10; text = "Increase by   10"; } );
            table.insert( command_routing.options, { value =     1; text = "Increase by    1"; } );
            table.insert( command_routing.options, { value =    -1; text = "Decrease by    1"; } );
            table.insert( command_routing.options, { value =   -10; text = "Decrease by   10"; } );
            table.insert( command_routing.options, { value =  -100; text = "Decrease by  100"; } );
            table.insert( command_routing.options, { value = -1000; text = "Decrease by 1000"; } );
            command_routing.FUNction = function(value) commands.game.adjust_lazy_RNG(value); end;
        elseif option_value == 3 then
            command_routing.description = function() return string.format("Modify Steps: %5s", commands.game.get_steps()); end;
            table.insert( command_routing.options, { value =  1024; text = "Increase by 1024"; } );
            table.insert( command_routing.options, { value =    64; text = "Increase by   64"; } );
            table.insert( command_routing.options, { value =     2; text = "Increase by    2"; } );
            table.insert( command_routing.options, { value =     1; text = "Increase by    1"; } );
            table.insert( command_routing.options, { value =    -1; text = "Decrease by    1"; } );
            table.insert( command_routing.options, { value =    -2; text = "Decrease by    2"; } );
            table.insert( command_routing.options, { value =   -64; text = "Decrease by   64"; } );
            table.insert( command_routing.options, { value = -1024; text = "Decrease by 1024"; } );
            command_routing.FUNction = function(value) commands.game.add_steps(value); end;
        elseif option_value == 4 then
            command_routing.description = function() return string.format("Encounter Test Level: %2i", commands.game.fun_flags.test_level); end;
            table.insert( command_routing.options, { value =     1; text = "Increase by    1"; } );
            table.insert( command_routing.options, { value =    -1; text = "Decrease by    1"; } );
            command_routing.FUNction = function(value)
                commands.game.fun_flags.test_level = commands.game.fun_flags.test_level + value;
                commands.game.fun_flags.test_level = math.max(commands.game.fun_flags.test_level,  0);
                commands.game.fun_flags.test_level = math.min(commands.game.fun_flags.test_level, 16);
            end;
        elseif option_value == 5 then
            command_routing.description = function() return "Bits, Nibbles, Bytes, and Words."; end;
            table.insert( command_routing.options, { value = commands.game.reset_main_RNG;        text = "Restart Main RNG"     ; } );
            table.insert( command_routing.options, { value = commands.game.reset_lazy_RNG;        text = "Restart Lazy RNG"     ; } );
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
table.insert(commands.commands, command_routing);

---------------------------------------- Module ----------------------------------------

table.insert(commands.commands, commands.general.command_progress);
table.insert(commands.commands, commands.general.teleport_real_world);
table.insert(commands.commands, commands.general.teleport_digital_world);
table.insert(commands.commands, commands.general.command_setups);

return commands.commands;

