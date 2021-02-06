-- Command Controls for MMBN scripting, enjoy.

local controls = {};

controls.commands = {};

controls.command_index = 1;

local function show_text(message)
    print(message);
end

function controls.next()
    controls.command_index = (controls.command_index % table.getn(controls.commands)) + 1;
    local command = controls.commands[controls.command_index];
    print("");
    show_text("Command Change: " .. command.description());
end

function controls.previous()
    controls.command_index = controls.command_index - 1;
    if controls.command_index == 0 then
        controls.command_index = table.getn(controls.commands);
    end
    local command = controls.commands[controls.command_index];
    print("");
    show_text("Command Change: " .. command.description());
end

function controls.option_down()
    local command = controls.commands[controls.command_index];
    command.selection = (command.selection % table.getn(command.options)) + 1;
    local option = command.options[command.selection];
    show_text("Option Change: " .. option.text);
end

function controls.option_up()
    local command = controls.commands[controls.command_index];
    command.selection = command.selection - 1;
    if command.selection == 0 then
        command.selection = table.getn(command.options);
    end
    local option = command.options[command.selection];
    show_text("Option Change: " .. option.text);
end

function controls.doit()
    local command = controls.commands[controls.command_index];
    local option = command.options[command.selection];
    print("");
    show_text("Executing: " .. command.description());
    show_text("With Option: " .. option.text);
    command.doit(option.value);
end

function controls.display_options()
    local command = controls.commands[controls.command_index];
    local options = command.options;
    local lines = {string.format("       %-30s", command.description())};

    for i=1,table.getn(options) do
        if i == command.selection then
            table.insert(lines, string.format("-> %2i: %-30s", i, options[i].text));
        else
            table.insert(lines, string.format("   %2i: %-30s", i, options[i].text));
        end
    end
    return lines;
end

return controls;