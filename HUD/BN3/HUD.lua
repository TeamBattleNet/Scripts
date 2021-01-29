-- HUD Script for Mega Man Battle Network 3, enjoy.

-- To use: Hold L and R, then press:
-- Select to toggle display mode
-- Left/Right/Up/Down to navigate commands

-- https://docs.google.com/spreadsheets/d/1MILb--rcdUO4iVRPpAM9B4qUvD0XDJodoHaqWnozXeM/pubhtml Did you check the notes?

local hud = {};

local HUD_version = "0.1.1.0";

local ram = require("BN3/RAM");
local commands = require("BN3/Commands");

local x = 0;
local y = 0;

-- font is positioned as if 10 pixels by 13 pixels
-- letters can be as wide as 14, or as tall as 17

local function to_screen(text, anchor, color)
    anchor = anchor or "topleft";
    color = color or 0xFFFFFFFF;
    gui.text(x, y, text, color, anchor);
    y = y + 16;
end

local function position_top_left()
    if ram.in_world() then
        if ram.in_digital_world() then -- align with HP
            x =  8;
            y = 69;
        else -- if ram.in_real_world() then -- aligned with PET
            x = 16;
            y = 83;
        end
    elseif ram.in_battle() then -- align with HP
        x =  8;
        y = 69;
    else -- align with corner
        x = 3; -- puts text one pixel from edge
        y = 0; -- puts text one pixel from edge
    end
end

local function position_bottom_right()
    x = 2;
    y = 3;
end

local function display_ramdom_bytes(ram_addr, count, jump)
    for i=1,count do
        to_screen(string.format("%08X: %02X", ram_addr, memory.read_u8(ram_addr)));
        ram_addr = ram_addr + jump;
    end
end

local function display_ramdom_words(ram_addr, count, jump)
    for i=1,count do
        to_screen(string.format("%08X: %08X", ram_addr, memory.read_u32_le(ram_addr)));
        ram_addr = ram_addr + jump;
    end
end

local function display_RNG()
    to_screen("M RNG: "   .. string.format("%08X", ram.rng.get_main_RNG_value()));
    to_screen("M Index: " .. (ram.rng.get_main_RNG_index() or "?"));
    to_screen("M Delta: " .. (ram.rng.get_main_RNG_delta() or "?"));
    to_screen("L RNG: "   .. string.format("%08X", ram.rng.get_lazy_RNG_value()));
    to_screen("L Index: " .. (ram.rng.get_lazy_RNG_index() or "?"));
    to_screen("L Delta: " .. (ram.rng.get_lazy_RNG_delta() or "?"));
end

local function display_steps()
    to_screen("Steps: " .. ram.get_steps());
    if ram.in_digital_world() then
        to_screen("Check: " .. ram.get_check());
        to_screen("Checks: " .. ram.get_encounter_checks());
        to_screen("Next :  " .. (64 - (ram.get_steps() - ram.get_check())));
    end
    to_screen("X: " .. ram.get_x());
    to_screen("Y: " .. ram.get_y());
end

local function display_draws(how_many, start_at)
    start_at = start_at or 1;
    for i=1,how_many do
        to_screen(string.format("%2i: %2i", i+start_at-1, ram.get_draw_slot(i+start_at-1)));
    end
end

local function display_game_info()
    to_screen("Version: " .. ram.get_version());
    to_screen(string.format("Progress: 0x%02X", ram.get_progress()));
    to_screen("Area: " .. ram.get_area_name());
    to_screen("Zenny: " .. ram.get_zenny());
    to_screen("Bug Frags: " .. ram.get_bug_frags());
    to_screen("Current Style: " .. ram.get_style_name());
    to_screen("Next Element: " .. ram.get_next_element_name());
    -- library
end

local function HUD_nothing()
    position_top_left();
end

local function HUD_auto()
    position_top_left();
    if     ram.in_title() then
        display_game_info();
        display_RNG();
    elseif ram.in_world() then
        display_RNG();
        display_steps();
        position_bottom_right();
        to_screen(ram.get_area_name(), "bottomright");
    elseif ram.in_battle() then
        x = x - 12;
        display_draws(7);
        position_top_left();
        x = x + 71;
        display_RNG();
        to_screen("Checks: " .. ram.get_encounter_checks());
        position_bottom_right();
        to_screen(ram.get_enemy_name(1), "bottomright");
        to_screen(ram.get_enemy_name(2), "bottomright");
        to_screen(ram.get_enemy_name(3), "bottomright");
    elseif ram.in_transition() then
        to_screen("HUD Version: " .. HUD_version);
        position_bottom_right();
        to_screen("t r o u t", "bottomright", 0x10000000);
    elseif ram.in_splash() then
        display_game_info();
    elseif ram.in_menu() then
        display_RNG();
    else
        display_RNG();
    end
end

local function HUD_full()
    position_top_left();
    if     ram.in_title() then
        display_game_info();
        display_RNG();
    elseif ram.in_world() then
        display_RNG();
        display_steps();
        position_bottom_right();
        to_screen(ram.get_area_name(), "bottomright");
    elseif ram.in_battle() then
        position_top_left();
        display_RNG();
        to_screen("Checks: " .. ram.get_encounter_checks());
        x = 191;
        y = 16;
        display_draws(15,  1);
        x = x + 83;
        y = 16;
        display_draws(15, 16);
        position_bottom_right();
        to_screen(ram.get_enemy_name(1), "bottomright");
        to_screen(ram.get_enemy_name(2), "bottomright");
        to_screen(ram.get_enemy_name(3), "bottomright");
    elseif ram.in_transition() then
        to_screen("HUD Version: " .. HUD_version);
        position_bottom_right();
        to_screen("t r o u t", "bottomright", 0x10000000);
    elseif ram.in_splash() then
        display_game_info();
    elseif ram.in_menu() then
        display_RNG();
    else -- unknown game_state?
        display_RNG();
    end
end

local function HUD_commands()
    position_top_left();
    to_screen(commands.display_options());
    -- TODO: Disable game inputs while in settings mode
end

------------------------------------------------------------------------------------------------------------------------

function hud.initialize()
    print("Initializing HUD for MMBN 3...");
    ram.initialize({
        max_RNG_index = 10 * 60 * 60; -- 10 minutes of frames
    });
    print("HUD for MMBN 3 Initialized.");
end

local display_mode = 2;
local display_modes = {};
table.insert(display_modes, function() HUD_nothing();  end);
table.insert(display_modes, function() HUD_auto();     end); -- default 2
--table.insert(display_modes, function() HUD_full();     end);
table.insert(display_modes, function() HUD_commands(); end);

local setting_changed = false;

function hud.update()
    ram.update_pre();
    
    local keys = joypad.get();
    
    if keys.L and keys.R then
        if setting_changed then
            if keys.Select or keys.Right or keys.Left or keys.Up or keys.Down or keys.A then
                -- wait for buttons to be released
            else
                setting_changed = false;
            end
        elseif keys.Select then
            setting_changed = true;
            display_mode = (display_mode % table.getn(display_modes)) + 1;
        elseif display_mode == 1 then
            -- disable commands while HUD is off
        elseif keys.Right then
            setting_changed = true;
            commands.next();
        elseif keys.Left then
            setting_changed = true;
            commands.previous();
        elseif keys.Up then
            setting_changed = true;
            commands.option_up();
        elseif keys.Down then
            setting_changed = true;
            commands.option_down();
        elseif keys.A then
            setting_changed = true;
            commands.doit();
        end
    end
    
    display_modes[display_mode]();
    
    ram.update_post();
end

return hud;

