-- Commands for MMBN scripting, enjoy.

local commands = require("All/Commands");

commands.game = require("BN6/Game");

for i,command in pairs(commands.general) do
    if command.update_options then
        command.update_options();
    end
end

table.insert(commands.commands, commands.general.command_menu);

return commands;

