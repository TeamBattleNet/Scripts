-- Commands for MMBN scripting, enjoy.

local commands = {};

local settings = require("All/Settings");

---------------------------------------- Menu ----------------------------------------

local command_menu = {};
command_menu.selection = 1;
command_menu.description = function() return "Welcome to the Command list!"; end;
command_menu.options = {
    { value = function() return; end; text = "Use Up or Down to change Options!"; };
    { value = function() return; end; text = "Right or Left to change Commands!"; };
    { value = function() return; end; text = "Use the controller or a keyboard!"; };
    { value = function() settings.set_display_text("gui");   end; text = "Font: Use gui.text"   ; };
    { value = function() settings.set_display_text("gens");  end; text = "Font: Use pixel gens" ; };
    { value = function() settings.set_display_text("fceux"); end; text = "Font: Use pixel fceux"; };
};
command_menu.doit = function(value) value(); end;
table.insert(commands, command_menu);

---------------------------------------- Module ----------------------------------------

return commands;

