-- HUD Script for Mega Man Battle Network 3 Scripting by Tterraj42, enjoy.

-- To use: Hold L and R, then press:
-- Select to toggle display mode
-- Left/Right/Up/Down to navigate commands

-- https://docs.google.com/spreadsheets/d/1MILb--rcdUO4iVRPpAM9B4qUvD0XDJodoHaqWnozXeM/pubhtml Did you check the notes?

local hud = {};

local ram = require("BN3/RAM");
local commands = require("BN3/Commands");

commands.display_mode = 4

local x = 2; -- puts text one pixel from edge
local y = 0; -- puts text one pixel from edge

-- font is positioned as if 10 pixels by 13 pixels
-- letters can be as wide as 14, or as tall as 17

local function to_screen(text, anchor, color)
    anchor = anchor or "topleft";
    color = color or 0xFFFFFFFF;
    gui.text(x, y, text, color, anchor);
    y = y + 15;
end

local function display_nothing()
    x = 2;
    y = 0;
end

local function display_commands()
    x = 2;
    y = 20;
    to_screen("Press  Up  to: " .. commands.options[commands.index].up_text);
    x = 2;
    y = 40;
    to_screen("Press Down to: " .. commands.options[commands.index].down_text);
    x = 2;
    y = 70;
    to_screen(commands.options[commands.index].text_func());
end

local function display_RNG()
    to_screen("M RNG: "   .. string.format("%08X", ram.rng.get_main_RNG_value()));
    to_screen("M Index: " .. (ram.rng.get_main_RNG_index() or "?"));
    to_screen("M Delta: " .. (ram.rng.get_main_RNG_delta() or "?"));
    to_screen("S RNG: "   .. string.format("%08X", ram.rng.get_sub_RNG_value()));
    to_screen("S Index: " .. (ram.rng.get_sub_RNG_index() or "?"));
    to_screen("S Delta: " .. (ram.rng.get_sub_RNG_delta() or "?"));
end

local function display_steps()
    to_screen("Steps: " .. ram.get_steps());
    if ram.is_mega() then
        to_screen("Check: " .. ram.get_check());
        to_screen("Next : " .. (64 - (ram.get_steps() - ram.get_check())));
    end
    to_screen("X: " .. ram.get_x());
    to_screen("Y: " .. ram.get_y());
end

local function display_auto()
    x = 2;
    y = 0;
    display_RNG();
    display_steps();
end

local function display_battle()
    x = 2;
    y = 0;
    to_screen("TODO: Battle HUD");
end

local function display_full()
    x = 2;
    y = 0;
    to_screen("TODO: Full HUD");
end

function hud.initialize()
    print("Initializing HUD for MMBN 3...");
    ram.initialize();
    print("HUD for MMBN 3 Initialized.");
end

function hud.update()
    ram.update_pre();
    
    local keys = joypad.get();
    
    if keys.L and keys.R then
        if commands.changed then
            if keys.Select or keys.Right or keys.Left or keys.Up or keys.Down then
                -- wait for keys to be released
            else
                commands.changed = false;
            end
        elseif keys.Select then
            commands.changed = true;
            commands.display_mode = (commands.display_mode + 1) % 5;
        elseif commands.display_mode == 0 then
            -- ignore other inputs while HUD is off
        elseif keys.Right or keys.Left or keys.Up or keys.Down then
            commands.changed = true;
            if     keys.Right then
                commands.next();
            elseif keys.Left then
                commands.previous();
            elseif keys.Up then
                commands.options[commands.index].up_func();
            elseif keys.Down then
                commands.options[commands.index].down_func();
            end
            print(commands.message);
            gui.addmessage(commands.message);
        end
    end
    
    if     commands.display_mode == 0 then
        display_nothing();
    elseif commands.display_mode == 1 then
        display_auto();
    elseif commands.display_mode == 2 then
        display_battle();
    elseif commands.display_mode == 3 then
        display_full();
    elseif commands.display_mode == 4 then
        display_commands();
    end
    
    ram.encounter_check(commands.skip_encounters);
    
    ram.update_post();
end

return hud;

