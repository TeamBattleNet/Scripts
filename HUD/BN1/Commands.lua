-- Commands for MMBN 1 scripting, enjoy.

local controls = {};

local game = require("BN1/Game");

local commands = {};
local command_index = 1;

local function show_text(message)
    print(message);
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
    { value = nil; text = "Press  Up  or  Down to change Options !"; };
    { value = nil; text = "Press Left or Right to change Commands!"; };
    { value = nil; text = "You can use the controller or keyboard!"; };
};
command_blank.selection = 1;
command_blank.description = function() return "Welcome to the Command list!"; end;
command_blank.doit = function() return; end;
table.insert(commands, command_blank);



local command_encounters = {};
command_encounters.options = {
    { value =  true; text = "Block Random Encounters"; };
    { value = false; text = "Allow Random Encounters"; };
};
command_encounters.selection = 1;
command_encounters.description = function() return "Random Encounters: " .. tostring(not game.skip_encounters); end
command_encounters.doit = function(value) game.skip_encounters = value; end;
table.insert(commands, command_encounters);



local command_zenny = {};
command_zenny.options = {
    { value =  100000; text = "Increase by 100000"; };
    { value =   10000; text = "Increase by  10000"; };
    { value =    1000; text = "Increase by   1000"; };
    { value =     100; text = "Increase by    100"; };
    { value =    -100; text = "Decrease by    100"; };
    { value =   -1000; text = "Decrease by   1000"; };
    { value =  -10000; text = "Decrease by  10000"; };
    { value = -100000; text = "Decrease by 100000"; };
};
command_zenny.selection = 1;
command_zenny.description = function() return string.format("Zenny: %11u", game.get_zenny()); end;
command_zenny.doit = function(value) game.add_zenny(value); end;
table.insert(commands, command_zenny);



local command_power = {};
command_power.options = {
    { value =  10; text = "Give 10"; };
    { value =   1; text = "Give  1"; };
    { value =  -1; text = "Take  1"; };
    { value = -10; text = "Take 10"; };
};
command_power.selection = 1;
command_power.description = function() return "PowerUPs: " .. game.get_PowerUPs(); end
command_power.doit = function(value) game.add_PowerUPs(value); end;
table.insert(commands, command_power);



local command_ice_block = {};
command_ice_block.options = {
    { value =  53; text = "Give 53"; };
    { value =   1; text = "Give  1"; };
    { value =  -1; text = "Take  1"; };
    { value = -53; text = "Take 53"; };
};
command_ice_block.selection = 1;
command_ice_block.description = function() return "IceBlocks: " .. game.get_IceBlocks(); end;
command_ice_block.doit = function(value) game.add_IceBlocks(value); end;
table.insert(commands, command_ice_block);



local command_RNG = {};
command_RNG.options = {
    { value =  1000; text = "Increase by 1000"; };
    { value =   100; text = "Increase by  100"; };
    { value =    10; text = "Increase by   10"; };
    { value =     1; text = "Increase by    1"; };
    { value =    -1; text = "Decrease by    1"; };
    { value =   -10; text = "Decrease by   10"; };
    { value =  -100; text = "Decrease by  100"; };
    { value = -1000; text = "Decrease by 1000"; };
};
command_RNG.selection = 1;
command_RNG.description = function() return string.format("RNG Index: %5s", (game.ram.get.RNG_index() or "?????")); end;
command_RNG.doit = function(value) game.ram.adjust_RNG(value); end;
table.insert(commands, command_RNG);



local command_RNG = {};
command_RNG.options = {
    { value =  9999; text = "Increase by 9999"; };
    { value =    64; text = "Increase by   64"; };
    { value =     2; text = "Increase by    2"; };
    { value =     1; text = "Increase by    1"; };
    { value =    -1; text = "Decrease by    1"; };
    { value =    -2; text = "Decrease by    2"; };
    { value =   -64; text = "Decrease by   64"; };
    { value = -9999; text = "Decrease by 9999"; };
};
command_RNG.selection = 1;
command_RNG.description = function() return "Modify Steps: " .. game.get_steps(); end;
command_RNG.doit = function(value) game.add_steps(value); end;
table.insert(commands, command_RNG);



local command_progress = {};
function command_progress.update_options(option_value)
    command_progress.options = {};
    command_progress.selection = 1;
    command_progress.scenario = nil;
    
    if not option_value then
        command_progress.description = function() return "Select a Progress scenario:"; end;
        table.insert( command_progress.options, { value = 0x00; text = "0x00 ProbablyAVirus";  } );
        table.insert( command_progress.options, { value = 0x10; text = "0x10 School Takeover"; } );
        table.insert( command_progress.options, { value = 0x20; text = "0x20 Complex Complex"; } );
        table.insert( command_progress.options, { value = 0x30; text = "0x30 City Traffic";    } );
        table.insert( command_progress.options, { value = 0x40; text = "0x40 Power Plant";     } );
        table.insert( command_progress.options, { value = 0x50; text = "0x50 Get the Memos";   } );
    else
        command_progress.description = function() return "Select a Progress value:"; end;
        command_progress.scenario = option_value;
        table.insert( command_progress.options, { value = nil; text = "Previous Menu"; } );
        for i=option_value,option_value+0xF do
            if game.get_progress_name(i) then
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



local command_misc = {};
command_misc.selection = 1;
command_misc.description = function() return "Misc Commands:"; end;
command_misc.options = {
    { value = game.go_mode;               text = "Go Mode";               };
    { value = game.set_star_flag;         text = "Set Star Flag";         };
    { value = game.clear_star_flag;       text = "Clear Star Flag";       };
    { value = game.ignite_oven_fires;     text = "Ignite Oven Fires";     };
    { value = game.extinguish_oven_fires; text = "Extinguish Oven Fires"; };
    { value = game.ignite_WWW_fires;      text = "Ignite WWW Fires";      };
    { value = game.extinguish_WWW_fires;  text = "Extinguish WWW Fires";  };
    { value = game.reset_buster_stats;    text = "Reset Buster Stats";    };
    { value = game.max_buster_stats;      text = "Max Buster Stats";      };
    { value = game.hub_buster_stats;      text = "Hub Buster Stats";      };
    { value = game.op_buster_stats;       text = "OP Buster Stats";       };
    { value = function() game.set_all_folder_to_ID(109); end; text = "Only Draw BstrBomb";     };
    { value = function() game.set_all_folder_to_ID(102); end; text = "Only Draw Invis3";       };
    { value = function() game.set_all_folder_to_ID( 33); end; text = "Only Draw HeroSwrd";     };
    { value = function() game.randomize_folder_IDs(   ); end; text = "Randomize Folder IDs";   };
    { value = function() game.set_all_folder_to_code(0); end; text = "Monocode A Folder";      };
    { value = function() game.randomize_folder_codes( ); end; text = "Randomize Folder Codes"; };
};
command_misc.doit = function(value) value(); end;
table.insert(commands, command_misc);



local command_combat = {};
command_combat.selection = 1;
command_combat.description = function() return "Battle Options:"; end;
command_combat.options = {
    { value = function() game.kill_enemy(0);     end; text = "Delete Everything";     };
    { value = function() game.kill_enemy(1);     end; text = "Delete Enemy 1";        };
    { value = function() game.kill_enemy(2);     end; text = "Delete Enemy 2";        };
    { value = function() game.kill_enemy(3);     end; text = "Delete Enemy 3";        };
    { value = function() game.draw_only_slot(0); end; text = "Draw Only Slot 1";      };
    { value = game.draw_in_order;                     text = "Draw In Order";         };
    { value = game.fill_custom_gauge;                 text = "Fill Custom Gauge";     };
    { value = game.empty_custom_gauge;                text = "Empty Custom Gauge";    };
    { value = game.reset_delete_timer;                text = "Set Delete Time to 0";  };
    { value = game.disable_chip_cooldown;             text = "Disable Chip Cooldown"; };
    { value = game.enable_chip_cooldown;              text = "Enable Chip Cooldown";  };
    { value = game.max_chip_window_count;             text = "15 Selectable Chips";   };
};
command_combat.doit = function(value) value(); end;
table.insert(commands, command_combat);


return controls;

