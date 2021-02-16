-- Commands for BCC scripting, enjoy.

local commands = {}; -- Menu, Flags, Battle, Items, RNG

commands.commands = {}; -- the final group for use in Controls.lua

commands.game = require("BCC/Game");

---------------------------------------- Menu ----------------------------------------

local settings = require("All/Settings");

local command_menu = {};
command_menu.selection = 1;
command_menu.description = function() return "Welcome to the Command list!"; end;
command_menu.options = {
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
};
command_menu.doit = function(value) value(); end;
table.insert(commands.commands, command_fun_flags);

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
    table.insert( command_fun_flags.options, fun_flag_helper("randomize_colors", "Randomize Color Palette") );
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
    { value = function() commands.game.kill_enemy(); end; text = "Delete Enemy"; };
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
        table.insert( command_items.options, { value = 1; text = "Zenny"; } );
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

local command_routing = {};
command_routing.sub_selection = 1;
function command_routing.update_options(option_value)
    command_routing.options = {};
    command_routing.FUNction = nil;
    
    if not option_value then
        command_routing.selection = command_routing.sub_selection;
        command_routing.description = function() return "Wanna see some RNG manip?"; end;
        table.insert( command_routing.options, { value = 1; text = "Main RNG Index"; } );
        table.insert( command_routing.options, { value = 2; text = "Flag Flipper"  ; } );
    else
        command_routing.sub_selection = command_routing.selection;
        command_routing.selection = 1;
        table.insert( command_routing.options, { value = nil; text = "Previous Menu"; } );
        if option_value == 1 then
            command_routing.description = function() return string.format("RNG Index: %5s", (commands.game.get_main_RNG_index() or "?????")); end;
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
            command_routing.description = function() return "Bits, Nibbles, Bytes, and Words."; end;
            table.insert( command_routing.options, { value = commands.game.reset_main_RNG; text = "Restart Main RNG"; } );
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

return commands.commands;

