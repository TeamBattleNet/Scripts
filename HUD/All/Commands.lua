-- Commands for MMBN scripting, enjoy.

local commands = {};

---------------------------------------- Menu ----------------------------------------

local command_menu = {};
command_menu.selection = 1;
command_menu.description = function() return "Welcome to the Command list!"; end;
command_menu.options = {
    { value = function() return; end; text = "Use Up or Down to change Options!"; };
    { value = function() return; end; text = "Right or Left to change Commands!"; };
    { value = function() return; end; text = "Use the controller or a keyboard!"; };
    { value = function() return; end; text = "Use B or Tab to change font size!"; };
    { value = function() return; end; text = "TODO: Set font to gui.text"; };
    { value = function() return; end; text = "TODO: Set font to pixel gens"; };
    { value = function() return; end; text = "TODO: Set font to pixel fceux"; };
};
command_menu.doit = function(value) value(); end;
table.insert(commands, command_menu);

---------------------------------------- Module ----------------------------------------

return commands;

