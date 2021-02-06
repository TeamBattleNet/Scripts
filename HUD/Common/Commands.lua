-- Commands for MMBN scripting, enjoy.

local commands = {};
commands.game = {};

local command_blank = {};
command_blank.options = {
    { value = nil; text = "Use Up or Down to change Options!"; };
    { value = nil; text = "Left or Right to change Commands!"; };
    { value = nil; text = "Use the controller or a keyboard!"; };
};
command_blank.selection = 1;
command_blank.description = function() return "Welcome to the Command list!"; end;
command_blank.doit = function() return; end;


local command_encounters = {};
command_encounters.options = {
    { value =  true; text = "Block Random Encounters"; };
    { value = false; text = "Allow Random Encounters"; };
};
command_encounters.selection = 1;
command_encounters.description = function() return "Random Encounters: " .. tostring(not commands.game.skip_encounters); end
command_encounters.doit = function(value) commands.game.skip_encounters = value; end;


local command_items = {};
function command_items.update_options(option_value)
    command_items.options = {};
    command_items.selection = 1;
    command_items.FUNction = nil;

    if not option_value then
        command_items.description = function() return "What will U buy?"; end;
        table.insert( command_items.options, { value = 1; text = "Zenny"   ; } );
        table.insert( command_items.options, { value = 2; text = "BugFrag"; } );
        table.insert( command_items.options, { value = 3; text = "HPMemory"; } );
    else
        command_items.description = function() return "Bzzt! (something broke)"; end;
        table.insert( command_items.options, { value = nil; text = "Previous Menu"; } );
        if option_value == 1 then
            command_items.description = function() return string.format("Zenny: %11u", commands.game.get_zenny()); end;
            table.insert( command_items.options, { value =    nil; text = "Note: Command does not work as expected."; } );
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
            command_items.description = function() return string.format("BugFrags: %2u", commands.game.get_bugfrags()); end;
            table.insert( command_items.options, { value =    nil; text = "Note: Command does not work as expected."; } );
            table.insert( command_items.options, { value =    1000; text = "Increase by 1000"; } );
            table.insert( command_items.options, { value =     100; text = "Increase by  100"; } );
            table.insert( command_items.options, { value =      10; text = "Increase by   10"; } );
            table.insert( command_items.options, { value =       1; text = "Increase by    1"; } );
            table.insert( command_items.options, { value =      -1; text = "Decrease by    1"; } );
            table.insert( command_items.options, { value =     -10; text = "Decrease by   10"; } );
            table.insert( command_items.options, { value =    -100; text = "Decrease by  100"; } );
            table.insert( command_items.options, { value =   -1000; text = "Decrease by 1000"; } );
            command_items.FUNction = function(value) commands.game.add_bugfrags(value); end;
        elseif option_value == 3 then
            command_items.description = function() return string.format("HPMemory: %2u", commands.game.get_HPMemory_count()); end;
            table.insert( command_items.options, { value = nil; text = "Apologies... That is sold out..."; } );
            command_items.FUNction = function(value) commands.game.add_zenny(value); end;
        end
    end
end

function command_items.doit(value)
    if command_items.FUNction and value then
        command_items.FUNction(value);
    else
        command_items.update_options(value);
    end
end


local command_progress = {};
function command_progress.update_options(option_value)
    command_progress.options = {};
    command_progress.selection = 1;
    command_progress.scenario = nil;

    if not option_value then
        command_progress.description = function() return "Select a Progress scenario:"; end;
        table.insert( command_progress.options, { value = nil; text = "Command currently WIP"; } );
    else
        command_progress.description = function() return "Select a Progress value:"; end;
        command_progress.scenario = option_value;
        table.insert( command_progress.options, { value = nil; text = "Previous Menu"; } );
        for i=option_value,option_value+0xF do
            if commands.game.get_progress_name(i) then
                table.insert( command_progress.options, { value = i; text = string.format("0x%02X: %s", i, commands.game.get_progress_name(i)); } );
            end
        end
    end
end

function command_progress.doit(value)
    if command_progress.scenario and value then
        commands.game.set_progress(value);
    else
        command_progress.update_options(value);
    end
end


local teleport_real_world = {};
function teleport_real_world.update_options(option_value)
    teleport_real_world.options = {};
    teleport_real_world.selection = 1;
    teleport_real_world.main_area = nil;

    if not option_value then
        teleport_real_world.description = function() return "Select a real world group:"; end;
        for i,group in pairs(commands.game.get_area_groups_real()) do
            table.insert( teleport_real_world.options, { value = group; text = commands.game.get_area_group_name(group); } );
        end
    else
        teleport_real_world.description = function() return "Select an area:"; end;
        teleport_real_world.main_area = option_value;
        table.insert( teleport_real_world.options, { value = nil; text = "Previous Menu"; } );
        for i=0,0xF do
            if commands.game.does_area_exist(option_value, i) then
                table.insert( teleport_real_world.options, { value = i; text = commands.game.get_area_name(option_value, i); } );
            end
        end
    end
end

function teleport_real_world.doit(value)
    if teleport_real_world.main_area and value then
        commands.game.teleport(teleport_real_world.main_area, value);
    else
        teleport_real_world.update_options(value);
    end
end



local teleport_digital_world = {};
function teleport_digital_world.update_options(option_value)
    teleport_digital_world.options = {};
    teleport_digital_world.selection = 1;
    teleport_digital_world.main_area = nil;

    if not option_value then
        teleport_digital_world.description = function() return "Select a digital world group:"; end;
        for i,group in pairs(commands.game.get_area_groups_digital()) do
            table.insert( teleport_digital_world.options, { value = group; text = commands.game.get_area_group_name(group); } );
        end
    else
        teleport_digital_world.description = function() return "Select an area:"; end;
        teleport_digital_world.main_area = option_value;
        table.insert( teleport_digital_world.options, { value = nil; text = "Previous Menu"; } );
        for i=0,0xF do
            if commands.game.does_area_exist(option_value, i) then
                table.insert( teleport_digital_world.options, { value = i; text = commands.game.get_area_name(option_value, i); } );
            end
        end
    end
end

function teleport_digital_world.doit(value)
    if teleport_digital_world.main_area and value then
        commands.game.teleport(teleport_digital_world.main_area, value);
    else
        teleport_digital_world.update_options(value);
    end
end


local command_combat = {};
command_combat.selection = 1;
command_combat.description = function() return "Battle Options:"; end;
command_combat.options = {
    { value = function() commands.game.kill_enemy(0);     end; text = "Delete Everything";     };
    { value = function() commands.game.kill_enemy(1);     end; text = "Delete Enemy 1";        };
    { value = function() commands.game.kill_enemy(2);     end; text = "Delete Enemy 2";        };
    { value = function() commands.game.kill_enemy(3);     end; text = "Delete Enemy 3";        };
    --[[
    { value = function() commands.game.kill_enemy(3);     end; text = "Delete Enemy 3";        };
    { value = function() commands.game.draw_only_slot(0); end; text = "Draw Only Slot 1";      };
    { value = commands.game.draw_in_order;                     text = "Draw In Order";         };
    { value = commands.game.fill_custom_gauge;                 text = "Fill Custom Gauge";     };
    { value = commands.game.empty_custom_gauge;                text = "Empty Custom Gauge";    };
    { value = commands.game.reset_delete_timer;                text = "Set Delete Time to 0";  };
    { value = commands.game.disable_chip_cooldown;             text = "Disable Chip Cooldown"; };
    { value = commands.game.enable_chip_cooldown;              text = "Enable Chip Cooldown";  };
    { value = commands.game.max_chip_window_count;             text = "15 Selectable Chips";   };
    ]]--
};
command_combat.doit = function(value) value(); end;


function commands.init_commands()
    command_items.update_options();
    command_progress.update_options();
    teleport_real_world.update_options();
    teleport_digital_world.update_options();

    table.insert(commands, command_blank);
    table.insert(commands, command_encounters);
    table.insert(commands, command_items);
    table.insert(commands, command_progress);
    table.insert(commands, teleport_real_world);
    table.insert(commands, teleport_digital_world);
    table.insert(commands, command_combat);
end


return commands;