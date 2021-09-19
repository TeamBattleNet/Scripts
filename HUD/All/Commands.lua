-- Commands for MMBN scripting, enjoy.

local commands = {};

local settings = require("All/Settings");

commands.game = {}; -- overridden later
commands.setup_groups = {}; -- overridden later

commands.commands = {}; -- the final group for use in Controls.lua
commands.general = {}; -- temporary storage to allow for reordering commands per game

-- Global Defaults to prevent crashing
commands.game.fun_flags = {};
commands.game.fun_flags.test_level = 14;
commands.game.fun_flags.encounter_threshold = 0x1C;

---------------------------------------- Menu ----------------------------------------

commands.general.command_menu = {};
commands.general.command_menu.selection = 1;
commands.general.command_menu.description = function() return "Welcome to the Command list!"; end;
commands.general.command_menu.options = {
    { value = function() return; end; text = "Use Up or Down to change Options!"; };
    { value = function() return; end; text = "Right or Left to change Commands!"; };
    { value = function() return; end; text = "Use the controller or a keyboard!"; };
    { value = function() settings.set_display_text("gui");   end; text = "Font Text: gui.text"   ; };
    { value = function() settings.set_display_text("gens");  end; text = "Font Text: Pixel gens" ; };
    { value = function() settings.set_display_text("fceux"); end; text = "Font Text: Pixel fceux"; };
    { value = function() settings.set_text_background(0x00000000); end; text = "Font Background: None" ; };
    { value = function() settings.set_text_background(0x40000000); end; text = "Font Background: Light"; };
    { value = function() settings.set_text_background(0x80000000); end; text = "Font Background: Half" ; };
    { value = function() settings.set_text_background(0xC0000000); end; text = "Font Background: Dark" ; };
    { value = function() settings.set_text_background(0xFF000000); end; text = "Font Background: Solid"; };
    { value = function() print("\n" .. commands.game.get_folder_text(1)); end; text = "Log Folder 1"; };
    { value = function() print("\n" ..
            commands.game.get_draw_slots_text_one_line()); end; text = "Log Draw Slots"; };
    { value = function() print("\n" ..
            commands.game.get_draw_slots_text_multi_line()); end; text = "Log Draw Slots Multi"; };
    { value = function() client.SetSoundOn(not client.GetSoundOn()); end; text = "Toggle Emulator Sound"; };
};
commands.general.command_menu.doit = function(value) value(); end;

---------------------------------------- Progress ----------------------------------------

commands.general.command_progress = {};
commands.general.command_progress.sub_selection = 1;
function commands.general.command_progress.update_options(option_value)
    commands.general.command_progress.options = {};
    commands.general.command_progress.scenario = nil;
    
    if not option_value then
        commands.general.command_progress.selection = commands.general.command_progress.sub_selection;
        commands.general.command_progress.description = function() return "Select a Scenario:"; end;
        for i,scenario in pairs(commands.game.progress.scenarios) do
            table.insert( commands.general.command_progress.options, { value = scenario.value; text = string.format("0x%02X %s", scenario.value, scenario.description); } );
        end
    else
        commands.general.command_progress.sub_selection = commands.general.command_progress.selection;
        commands.general.command_progress.selection = 1;
        commands.general.command_progress.scenario = option_value;
        commands.general.command_progress.description = function() return "Select a Progress value:"; end;
        table.insert( commands.general.command_progress.options, { value = nil; text = "Previous Menu"; } );
        for i=option_value,option_value+0xF do
            if commands.game.is_progress_valid(i) then
                table.insert( commands.general.command_progress.options, { value = i; text = string.format("0x%02X: %s", i, commands.game.get_progress_name(i)); } );
            end
        end
    end
end
--commands.general.command_progress.update_options();
function commands.general.command_progress.doit(value)
    if commands.general.command_progress.scenario and value then
        commands.game.set_progress(value);
    else
        commands.general.command_progress.update_options(value);
    end
end

---------------------------------------- Real Areas ----------------------------------------

commands.general.teleport_real_world = {};
commands.general.teleport_real_world.sub_selection = 1;
function commands.general.teleport_real_world.update_options(option_value)
    commands.general.teleport_real_world.options = {};
    commands.general.teleport_real_world.main_area = nil;
    
    if not option_value then
        commands.general.teleport_real_world.selection = commands.general.teleport_real_world.sub_selection;
        commands.general.teleport_real_world.description = function() return "TELEPORT: Real Areas"; end;
        for i,group in pairs(commands.game.get_area_groups_real()) do
            table.insert( commands.general.teleport_real_world.options, { value = group; text = commands.game.get_area_group_name(group); } );
        end
    else
        commands.general.teleport_real_world.sub_selection = commands.general.teleport_real_world.selection;
        commands.general.teleport_real_world.selection = 1;
        commands.general.teleport_real_world.main_area = option_value;
        commands.general.teleport_real_world.description = function() return "Select an area:"; end;
        table.insert( commands.general.teleport_real_world.options, { value = nil; text = "Previous Menu"; } );
        for i=0,0xF do
            if commands.game.does_area_exist(option_value, i) then
                table.insert( commands.general.teleport_real_world.options, { value = i; text = commands.game.get_area_name(option_value, i); } );
            end
        end
    end
end
--commands.general.teleport_real_world.update_options();
function commands.general.teleport_real_world.doit(value)
    if commands.general.teleport_real_world.main_area and value then
        commands.game.teleport(commands.general.teleport_real_world.main_area, value);
        return true; -- exit command mode
    else
        commands.general.teleport_real_world.update_options(value);
    end
end

---------------------------------------- Digital Areas ----------------------------------------

commands.general.teleport_digital_world = {};
commands.general.teleport_digital_world.sub_selection = 1;
function commands.general.teleport_digital_world.update_options(option_value)
    commands.general.teleport_digital_world.options = {};
    commands.general.teleport_digital_world.main_area = nil;
    
    if not option_value then
        commands.general.teleport_digital_world.selection = commands.general.teleport_digital_world.sub_selection;
        commands.general.teleport_digital_world.description = function() return "TELEPORT: Digital Areas"; end;
        for i,group in pairs(commands.game.get_area_groups_digital()) do
            table.insert( commands.general.teleport_digital_world.options, { value = group; text = commands.game.get_area_group_name(group); } );
        end
    else
        commands.general.teleport_digital_world.sub_selection = commands.general.teleport_digital_world.selection;
        commands.general.teleport_digital_world.selection = 1;
        commands.general.teleport_digital_world.main_area = option_value;
        commands.general.teleport_digital_world.description = function() return "Select an area:"; end;
        table.insert( commands.general.teleport_digital_world.options, { value = nil; text = "Previous Menu"; } );
        for i=0,0xF do
            if commands.game.does_area_exist(option_value, i) then
                table.insert( commands.general.teleport_digital_world.options, { value = i; text = commands.game.get_area_name(option_value, i); } );
            end
        end
    end
end
--commands.general.teleport_digital_world.update_options();
function commands.general.teleport_digital_world.doit(value)
    if commands.general.teleport_digital_world.main_area and value then
        commands.game.teleport(commands.general.teleport_digital_world.main_area, value);
        return true; -- exit command mode
    else
        commands.general.teleport_digital_world.update_options(value);
    end
end

---------------------------------------- Setups ----------------------------------------

commands.general.command_setups = {};
commands.general.command_setups.sub_selection = 1;
function commands.general.command_setups.update_options(option_value)
    commands.general.command_setups.options = {};
    commands.general.command_setups.FUNction = nil;
    
    if not option_value then
        commands.general.command_setups.selection = commands.general.command_setups.sub_selection;
    commands.general.command_setups.description = function() return "What Kind Of Button Pressing?"; end;
        for i,setup_group in pairs(commands.setup_groups) do
            table.insert( commands.general.command_setups.options, { value = i; text = setup_group.description; } );
        end
    else
        commands.general.command_setups.sub_selection = commands.general.command_setups.selection;
        commands.general.command_setups.selection = 1;
        table.insert( commands.general.command_setups.options, { value = nil; text = "Previous Menu"; } );
        commands.general.command_setups.description = function() return commands.setup_groups[option_value].description; end;
        for i,setup in pairs(commands.setup_groups[option_value].setups) do
            table.insert( commands.general.command_setups.options, { value = setup.doit; text = setup.description; } );
        end
        commands.general.command_setups.FUNction = function(value) value(); end;
    end
end
--commands.general.command_setups.update_options();
function commands.general.command_setups.doit(value)
    if commands.general.command_setups.FUNction and value then
        commands.general.command_setups.FUNction(value);
        return true; -- exit command mode
    else
        commands.general.command_setups.update_options(value);
    end
end

---------------------------------------- Module ----------------------------------------

return commands;

