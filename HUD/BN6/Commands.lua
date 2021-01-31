-- Commands for the HUD Script for MMBN 3, enjoy.

local ram = require("BN6/RAM");
local resetter = require("BN6/Resetter");

local controls = {};

local command_index = 1;
local commands = {};
local options = {};

local first_command_option = nil;
local display_sub_option = false;

local function show_text(message)
    print(message);
    gui.addmessage(message);
end

function controls.next()
    command_index = (command_index % table.getn(commands)) + 1;
    local command = commands[command_index];
    show_text(command.description());
	display_sub_option = false;
end

function controls.previous()
    command_index = command_index - 1;
    if command_index == 0 then
        command_index = table.getn(commands);
    end
    local command = commands[command_index];
    show_text(command.description());
	display_sub_option = false;
end

function controls.option_down()
    local options = commands[command_index];
	if not display_sub_option then
		options.selection = (options.selection % table.getn(options)) + 1;
		local option = options[options.selection];
		show_text("Selected: " .. option.text);
	else
		options.sub_options.selection = (options.sub_options.selection % table.getn(options.sub_options)) + 1;
		local sub_option = options.sub_options[options.sub_options.selection];
		show_text("Selected: " .. sub_option.text);
	end
end

function controls.option_up()
    local options = commands[command_index];
	if not display_sub_option then
		options.selection = options.selection - 1;
		if options.selection == 0 then
			options.selection = table.getn(options);
		end
		local option = options[options.selection];
		show_text("Selected: " .. option.text);
	else
		options.sub_options.selection = options.sub_options.selection - 1;
		if options.sub_options.selection == 0 then
			options.sub_options.selection = table.getn(options.sub_options);
		end
		local sub_option = options.sub_options[options.sub_options.selection];
		show_text("Selected: " .. sub_option.text);
	end
end

function controls.doit()
    local command = commands[command_index];
    local option = command[command.selection];
    show_text("Executed: " .. option.text);
	if command.sub_options ~= nil then
		show_text("Command has sub_option");
		if not display_sub_option then
			show_text("Showing sub_options");
			display_sub_option = true;
			first_command_option = option;
		else
			local sub_option = command.sub_options[command.sub_options.selection];
			show_text("Executing sub_options: " .. first_command_option.value .. " " .. sub_option.value);
			command.doit(first_command_option.value, sub_option.value);
			display_sub_option = false;
		end
	else
		show_text("TEST");
		command.doit(option.value);
	end
end

function controls.display_options()
    local options = commands[command_index];
	local sub_options = commands[command_index].sub_options;
    local lines = {};
	if not display_sub_option then
		table.insert(lines, options.description());
		for i=1,table.getn(options) do
			line = string.format("[%2i] %s", i, options[i].text);
			if i == options.selection then
				line = line .. " <--";
			end
			table.insert(lines, line);
		end
	else
		table.insert(lines, sub_options.description());
		for i=1,table.getn(sub_options) do
			line = string.format("[%2i] %s", i, sub_options[i].text);
			if i == sub_options.selection then
				line = line .. " <--";
			end
			table.insert(lines, line);
		end
	end
    return lines;
end

------------------------------------------------------------------------------------------------------------------------

options = {};
table.insert(options, {value = 0; text = "Press  Up  or  Down to change Options "});
table.insert(options, {value = 0; text = "Press Left or Right to change Commands"});
options.selection = 1; -- default option
options.description = function() return "Settings Menu"; end;
options.doit = function(value) return; end;
table.insert(commands, options);

options = {};
table.insert(options, {value = false; text = "Allow Random Encounters"});
table.insert(options, {value =  true; text = "Block Random Encounters"});
options.selection = 1; -- default option
options.description = function() return "Random Encounters: " .. tostring(not ram.skip_encounters); end;
options.doit = function(value) ram.skip_encounters = value; end;
table.insert(commands, options);

options = {};
table.insert(options, {value =  100000; text = "Increase Zenny by 100000"});
table.insert(options, {value =   10000; text = "Increase Zenny by  10000"});
table.insert(options, {value =    1000; text = "Increase Zenny by   1000"});
table.insert(options, {value =     100; text = "Increase Zenny by    100"});
table.insert(options, {value =    -100; text = "Decrease Zenny by    100"});
table.insert(options, {value =   -1000; text = "Decrease Zenny by   1000"});
table.insert(options, {value =  -10000; text = "Decrease Zenny by  10000"});
table.insert(options, {value = -100000; text = "Decrease Zenny by 100000"});
options.selection = 1; -- default option
options.description = function() return string.format("Modify Zenny: %u", ram.get_zenny()); end;
options.doit = function(value) ram.add_zenny(value); end;
table.insert(commands, options);

options = {};
table.insert(options, {value =  1000; text = "Increase Bug Frags by 1000"});
table.insert(options, {value =   100; text = "Increase Bug Frags by  100"});
table.insert(options, {value =    10; text = "Increase Bug Frags by   10"});
table.insert(options, {value =     1; text = "Increase Bug Frags by    1"});
table.insert(options, {value =    -1; text = "Decrease Bug Frags by    1"});
table.insert(options, {value =   -10; text = "Decrease Bug Frags by   10"});
table.insert(options, {value =  -100; text = "Decrease Bug Frags by  100"});
table.insert(options, {value = -1000; text = "Decrease Bug Frags by 1000"});
options.selection = 1; -- default option
options.description = function() return string.format("Modify Bug Frags: %u", ram.get_bug_frags()); end;
options.doit = function(value) ram.add_bug_frags(value); end;
table.insert(commands, options);

options = {};
table.insert(options, {value =  9999; text = "Increase Steps by 9999"});
table.insert(options, {value =    64; text = "Increase Steps by   64"});
table.insert(options, {value =     2; text = "Increase Steps by    2"});
table.insert(options, {value =     1; text = "Increase Steps by    1"});
table.insert(options, {value =    -1; text = "Decrease Steps by    1"});
table.insert(options, {value =    -2; text = "Decrease Steps by    2"});
table.insert(options, {value =   -64; text = "Decrease Steps by   64"});
table.insert(options, {value = -9999; text = "Decrease Steps by 9999"});
options.selection = 1; -- default option
options.description = function() return string.format("Modify Steps: %u", ram.get_steps()); end;
options.doit = function(value) ram.add_steps(value); end;
table.insert(commands, options);

options = {};
table.insert(options, {value =  100; text = "Increase Main RNG by 100"});
table.insert(options, {value =   10; text = "Increase Main RNG by  10"});
table.insert(options, {value =    1; text = "Increase Main RNG by   1"});
table.insert(options, {value =   -1; text = "Decrease Main RNG by   1"});
table.insert(options, {value =  -10; text = "Decrease Main RNG by  10"});
table.insert(options, {value = -100; text = "Decrease Main RNG by 100"});
options.selection = 1; -- default option
options.description = function() return string.format("Modify Main RNG: %4s: %08X", (ram.rng.get_main_RNG_index() or "????"), ram.rng.get_main_RNG_value()); end;
options.doit = function(value) ram.rng.adjust_main_RNG(value); end;
table.insert(commands, options);

options = {};
table.insert(options, {value =  100; text = "Increase Lazy RNG by 100"});
table.insert(options, {value =   10; text = "Increase Lazy RNG by  10"});
table.insert(options, {value =    1; text = "Increase Lazy RNG by   1"});
table.insert(options, {value =   -1; text = "Decrease Lazy RNG by   1"});
table.insert(options, {value =  -10; text = "Decrease Lazy RNG by  10"});
table.insert(options, {value = -100; text = "Decrease Lazy RNG by 100"});
options.selection = 1; -- default option
options.description = function() return string.format("Modify Lazy RNG: %4s: %08X", (ram.rng.get_lazy_RNG_index() or "????"), ram.rng.get_lazy_RNG_value()); end;
options.doit = function(value) ram.rng.adjust_lazy_RNG(value); end;
table.insert(commands, options);

options = {};
table.insert(options, {value = 0x00; text = "ACDC Town    "});
table.insert(options, {value = 0x01; text = "Central Town "});
table.insert(options, {value = 0x02; text = "Cyber Academy"});
table.insert(options, {value = 0x03; text = "Seaside Town "});
table.insert(options, {value = 0x04; text = "Green Town   "});
table.insert(options, {value = 0x05; text = "Sky Town     "});
table.insert(options, {value = 0x06; text = "Expo Site    "});
options.selection = 1; -- default option
options.description = function() return "Pick Real World Main Area: " .. ram.get_area_name(); end;
options.doit = function(firstVal, secondVal) if ram.does_area_exist(firstVal, secondVal) then ram.set_area(firstVal); ram.set_sub_area(secondVal); end end;

sub_options = {};
table.insert(sub_options, {value = 0x00; text = "Sub Area 0x00"});
table.insert(sub_options, {value = 0x01; text = "Sub Area 0x01"});
table.insert(sub_options, {value = 0x02; text = "Sub Area 0x02"});
table.insert(sub_options, {value = 0x03; text = "Sub Area 0x03"});
table.insert(sub_options, {value = 0x04; text = "Sub Area 0x04"});
table.insert(sub_options, {value = 0x05; text = "Sub Area 0x05"});
table.insert(sub_options, {value = 0x06; text = "Sub Area 0x06"});
table.insert(sub_options, {value = 0x07; text = "Sub Area 0x07"});
table.insert(sub_options, {value = 0x08; text = "Sub Area 0x08"});
table.insert(sub_options, {value = 0x09; text = "Sub Area 0x09"});
table.insert(sub_options, {value = 0x0A; text = "Sub Area 0x0A"});
table.insert(sub_options, {value = 0x0B; text = "Sub Area 0x0B"});
table.insert(sub_options, {value = 0x0C; text = "Sub Area 0x0C"});
table.insert(sub_options, {value = 0x0D; text = "Sub Area 0x0E"});
table.insert(sub_options, {value = 0x0E; text = "Sub Area 0x0E"});
table.insert(sub_options, {value = 0x0F; text = "Sub Area 0x0F"});
sub_options.selection = 1; -- default option
sub_options.description = function() return "Pick Sub Area: " .. ram.get_area_name(); end;
options.sub_options = sub_options;
table.insert(commands, options);

options = {};
table.insert(options, {value = 0x80; text = "Robo Control Comps     "});
table.insert(options, {value = 0x81; text = "Aquarium Comps         "});
table.insert(options, {value = 0x82; text = "JudgeTree Comps        "});
table.insert(options, {value = 0x83; text = "Mr. Weather Comps      "});
table.insert(options, {value = 0x85; text = "Pavilion Comps         "});
table.insert(options, {value = 0x88; text = "HomePages              "});
table.insert(options, {value = 0x8C; text = "Small Comps 1          "});
table.insert(options, {value = 0x8D; text = "Small Comps 2          "});
table.insert(options, {value = 0x90; text = "Central Area           "});
table.insert(options, {value = 0x91; text = "Seaside Area           "});
table.insert(options, {value = 0x92; text = "Green Area             "});
table.insert(options, {value = 0x93; text = "Underground Area       "});
table.insert(options, {value = 0x94; text = "Sky/ACDC Area          "});
table.insert(options, {value = 0x95; text = "Undernet               "});
table.insert(options, {value = 0x95; text = "Graveyard/Immortal Area"});
options.selection = 1; -- default option
options.description = function() return "Pick Digital World Main Area: " .. ram.get_area_name(); end;
options.doit = function(value) if ram.does_area_exist(value, ram.get_sub_area()) then ram.set_area(value); end end;
table.insert(commands, options);

return controls;

