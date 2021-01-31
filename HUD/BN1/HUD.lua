-- HUD Script for Mega Man Battle Network 1, enjoy.

-- To use: Hold L and R, then press:
-- Start to turn HUD on/off
-- Select to Command Mode on/off
-- Left/Right/Up/Down to navigate Commands
-- B to activate the Command Option

-- https://docs.google.com/spreadsheets/d/e/2PACX-1vT5JrlG2InVHk4Rxpz_o3wQ5xbpNj2_n87wY0R99StH9F5P5Cp8AFyjsEQCG6MVEaEMn9dJND-k5M-P/pubhtml Did you check the notes?

local hud = {};
hud.minor_version = "0.0";

local ram = require("BN1/RAM");
local commands = require("BN1/Commands");

local x = 0; -- font is positioned as if 10 pixels by 13 pixels
local y = 0; -- letters can be as wide as 14, or as tall as 17
local anchor = ""; -- one of the four corners

local function to_screen(text, color)
    color = color or 0xFFFFFFFF;
    gui.text(x, y, text, color, anchor);
    y = y + 16;
end

local function position_top_left()
    if     ram.in_battle() then             -- align with HP
        x =  0;
        y = 68;
    elseif ram.in_world() then
        if ram.in_digital_world() then      -- align with HP
            x = 3;
            y = 0;
        else -- if ram.in_real_world() then -- aligned with PET
            x = 10;
            y = 90;
        end
    else                                    -- align with corner
        x = 3; -- puts most text one pixel from edge
        y = 0; -- puts most text one pixel from edge
    end
    anchor = "topleft";
end

local function position_bottom_right()
    x = 3;
    y = 3;
    anchor = "bottomright";
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

local function display_RNG(and_value)
    if and_value then
        to_screen("RNG Value: "   .. string.format("%08X", ram.rng.get_RNG_value()));
    end
    to_screen(string.format("RNG Index: %4s", (ram.rng.get_RNG_index() or "?")));
    to_screen(string.format("RNG Delta: %4s", (ram.rng.get_RNG_delta() or "?")));
end

local function display_steps()
    if ram.in_digital_world() then
        to_screen(string.format("Steps : %7u", ram.get_steps()));
        to_screen(string.format("Check : %7u", ram.get_check()));
        to_screen(string.format("Checks: %7u", ram.get_encounter_checks()));
        to_screen(string.format("Chance: %6.3f%%", ram.get_encounter_chance()));
        to_screen(string.format("Next  : %7i", (64 - (ram.get_steps() - ram.get_check()))));
    end
    to_screen(string.format("X: %7i", ram.get_x()));
    to_screen(string.format("Y: %7i", ram.get_y()));
end

local function display_draws(how_many, start_at)
    start_at = start_at or 1;
    for i=1,how_many do
        to_screen(string.format("%2i: %2i", i+start_at-1, ram.get_draw_slot(i+start_at-1)));
    end
end

local function display_in_menu()
    to_screen("TODO: Menu HUD");
end

local function display_player_info()
    to_screen(string.format("Zenny   : %7u", ram.get_zenny()));
    -- TODO: MegaMan Stats
    -- TODO: Library Stats
end

local function display_game_info()
    to_screen(string.format("Progress: 0x%02X %s", ram.get_progress(), ram.get_progress_name()));
    to_screen("Game Version: " .. ram.get_version());
    to_screen("HUD  Version: " .. hud.version);
end

local function display_routing()
    position_top_left();
    x = 190;
    y =  16;
    display_ramdom_words(0x02000000, 6, 4);
    x = 390;
    y =  16;
    display_ramdom_words(0x02000018, 6, 4);
    x = 590;
    y =  16;
    display_ramdom_words(0x02000030, 6, 4);
    x = 190;
    y = 120;
    to_screen(string.format("%08X: %08X", 0x02000070, memory.read_u32_le(0x02000070)));
    x = 390;
    y = 120;
    to_screen(string.format("%08X: %02X", 0x02000216, memory.read_u8(0x02000216)));
    x = 530;
    y = 120;
    to_screen(ram.is_go_mode());
    x = 590;
    y = 120;
    to_screen(string.format("%08X: %02X", 0x0200001D, memory.read_u8(0x0200001D)));
    x = 720;
    y = 120;
    to_screen(string.format("IB:%2u", ram.get_IceBlock_available()));
end

local function display_commands()
    position_top_left();
    x = 290;
    y = 16+128;
    options = commands.display_options();
    for i=1,table.getn(options) do
        to_screen(options[i]);
    end
end

------------------------------------------------------------------------------------------------------------------------

local show_HUD = true;

local routing_mode = false;
local command_mode = false;

local function display_HUD()
    if routing_mode then
        display_routing();
    end
    
    if command_mode then
        display_commands();
    end
    
    position_top_left();
    if ram.in_title() or ram.in_splash() then
        display_game_info();
        to_screen("");
        display_RNG(true);
        position_bottom_right();
        to_screen(ram.get_area_name());
    elseif ram.in_world() then
        display_RNG();
        display_steps();
        if ram.near_number_doors() then
            to_screen("Door Code: " .. ram.get_door_code());
        end
        position_bottom_right();
        to_screen(ram.get_area_name());
    elseif ram.in_battle() or ram.in_game_over() then
        display_draws(10);
        position_top_left();
        x = x + 71;
        to_screen(string.format("Battle ID:   0x%4X", ram.get_battle_pointer()));
        display_RNG(true);
        to_screen("");
        to_screen(string.format("Checks: %2u", ram.get_encounter_checks()));
        position_bottom_right();
        to_screen(ram.get_enemy_name(1));
        to_screen(ram.get_enemy_name(2));
        to_screen(ram.get_enemy_name(3));
    elseif ram.in_transition() then
        to_screen("HUD Version: " .. hud.version);
    elseif ram.in_menu() or ram.in_shop() or ram.in_chip_trader() then
        display_in_menu();
    elseif ram.in_credits() then
        position_bottom_right();
        to_screen("t r o u t", 0x10000000);
    else
        to_screen("Unknown Game State!");
    end
end

function hud.initialize(options)
    print("Initializing HUD for MMBN 1...");
    hud.version = options.major_version .. "." .. hud.minor_version;
    options.max_RNG_index = 10 * 60 * 60; -- 10 minutes of frames
    ram.initialize(options);
    print("HUD for MMBN 1 " .. ram.get_version() .. " Initialized.");
end

local previous_keys = {};
local previous_buttons = {};

function hud.update()
    ram.update_pre();
    
    local keys = joypad.get();
    local buttons = input.get();
    
    if keys.L and keys.R then
        if keys.Start and not previous_keys.Start then
            show_HUD = not show_HUD;
        end
    end
    
    if show_HUD then
        if (keys.L and keys.R) or command_mode then
            if     keys.Select and not previous_keys.Select then
                command_mode = not command_mode;
            elseif keys.Right  and not previous_keys.Right  then
                commands.next();
            elseif keys.Left   and not previous_keys.Left   then
                commands.previous();
            elseif keys.Up     and not previous_keys.Up     then
                commands.option_up();
            elseif keys.Down   and not previous_keys.Down   then
                commands.option_down();
            elseif keys.B      and not previous_keys.B      then
                commands.doit();
            elseif keys.A      and not previous_keys.A      then
                --print(ram.get_draw_slots());
                --print(buttons);
                --print(keys);
            end
        end
        
        if buttons.Grave and not previous_buttons.Grave then -- Grave is `
            if buttons.Shift then
                routing_mode = not routing_mode;
            else
                command_mode = not command_mode;
            end
        end
        
        if command_mode then
            if     buttons.Right   and not previous_buttons.Right   then
                commands.next();
            elseif buttons.Left    and not previous_buttons.Left    then
                commands.previous();
            elseif buttons.Up      and not previous_buttons.Up      then
                commands.option_up();
            elseif buttons.Down    and not previous_buttons.Down    then
                commands.option_down();
            elseif buttons.Keypad0 and not previous_buttons.Keypad0 then
                commands.doit();
            end
        end
        
        display_HUD();
    end
    
    ram.update_post();
    
    previous_keys = keys;
    previous_buttons = buttons;
end

return hud;

