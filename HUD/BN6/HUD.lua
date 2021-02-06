-- HUD Script for Mega Man Battle Network 1, enjoy.

-- To use: Hold L and R, then press:
-- Start to turn HUD on/off
-- Select to Command Mode on/off
-- Left/Right/Up/Down to navigate Commands
-- B to activate the Command Option

-- https://docs.google.com/spreadsheets/d/e/2PACX-1vT5JrlG2InVHk4Rxpz_o3wQ5xbpNj2_n87wY0R99StH9F5P5Cp8AFyjsEQCG6MVEaEMn9dJND-k5M-P/pubhtml Did you check the notes?

local hud = {};
hud.minor_version = "0.1";

local game = require("BN6/Game");
local commands = require("BN6/Controls");

---------------------------------------- Support Functions ----------------------------------------

local options = {};

local show_HUD = true;
local command_mode = false;

local current_state = nil;
local previous_state = nil;
local state_changed = false;

local keys_held = {};
local keys_previous = {};
local keys_down = {};

local buttons_held = {};
local buttons_previous = {};
local buttons_down = {};

local buttons_ignore = {};
local buttons_string = "";

local function record_menu_buttons()
    if game.in_menu() then
        if game.game_state_changed() then
            buttons_string = "";
        end
        
        if buttons_down.Up then
            buttons_string = buttons_string .. " ^"; -- ↑ ▲
        end
        
        if buttons_down.Down then
            buttons_string = buttons_string .. " v"; -- ↓ ▼
        end
        
        if buttons_down.Left then
            buttons_string = buttons_string .. " >"; -- ← ◄
        end
        
        if buttons_down.Right then
            buttons_string = buttons_string .. " <"; -- → ►
        end
        
        if buttons_down.Start then
            buttons_string = buttons_string .. " S";
        end
        
        if buttons_down.Select then
            buttons_string = buttons_string .. " s";
        end
        
        if buttons_down.B then
            buttons_string = buttons_string .. " B";
        end
        
        if buttons_down.A then
            buttons_string = buttons_string .. " A";
        end
        
        if buttons_down.L then
            buttons_string = buttons_string .. " L";
        end
        
        if buttons_down.R then
            buttons_string = buttons_string .. " R";
        end
    end
end

local function disable_button(button, to_set)
    if buttons_ignore[button] then
        if buttons_held[button] then
            joypad.set(to_set);
            buttons_down[button] = false;
        elseif buttons_previous[button] then
            -- wait 1 more frame
        else
            buttons_ignore[button] = false;
        end
    elseif buttons_down[button] then
        joypad.set(to_set);
        buttons_ignore[button] = true;
    end
end

local function disable_buttons_in_command_mode()
    disable_button("Up"    , {Up=false}    );
    disable_button("Down"  , {Down=false}  );
    disable_button("Left"  , {Left=false}  );
    disable_button("Right" , {Right=false} );
    disable_button("Start" , {Start=false} );
    disable_button("Select", {Select=false});
    disable_button("B"     , {B=false}     );
    disable_button("A"     , {A=false}     );
    disable_button("L"     , {L=false}     );
    disable_button("R"     , {R=false}     );
end

local function process_inputs_BN_HUD()
    buttons_held = joypad.get(); -- controller only
    keys_held = input.get(); -- controller, keyboard, and mouse
    
    buttons_down.Up     = (buttons_held.Up     and not buttons_previous.Up    );
    buttons_down.Down   = (buttons_held.Down   and not buttons_previous.Down  );
    buttons_down.Left   = (buttons_held.Left   and not buttons_previous.Left  );
    buttons_down.Right  = (buttons_held.Right  and not buttons_previous.Right );
    buttons_down.Start  = (buttons_held.Start  and not buttons_previous.Start );
    buttons_down.Select = (buttons_held.Select and not buttons_previous.Select);
    buttons_down.B      = (buttons_held.B      and not buttons_previous.B     );
    buttons_down.A      = (buttons_held.A      and not buttons_previous.A     );
    buttons_down.L      = (buttons_held.L      and not buttons_previous.L     );
    buttons_down.R      = (buttons_held.R      and not buttons_previous.R     );
    
    keys_down.Up           = (keys_held.Up           and not keys_previous.Up          );
    keys_down.Down         = (keys_held.Down         and not keys_previous.Down        );
    keys_down.Left         = (keys_held.Left         and not keys_previous.Left        );
    keys_down.Right        = (keys_held.Right        and not keys_previous.Right       );
    keys_down.Keypad0      = (keys_held.Keypad0      and not keys_previous.Keypad0     );
    keys_down.KeypadPeriod = (keys_held.KeypadPeriod and not keys_previous.KeypadPeriod);
    
    record_menu_buttons(); -- for folder edits
    
    if command_mode then
        disable_buttons_in_command_mode();
    end
    
    buttons_previous = buttons_held;
    keys_previous = keys_held;
end

process_inputs_BN_HUD_reference = event.onframestart(process_inputs_BN_HUD, "process_inputs_BN_HUD");

---------------------------------------- Display Functions ----------------------------------------

local x = 0;
local y = 0;

local xs = 0;
local ys = 0;

local current_font = "fceux";
local current_color = 0x77000000;

local function set_default_text(font, color)
    if font == "gens" then
        xs = 4;
        ys = 7;
    elseif font == "fceux" then
        xs = 6;
        ys = 9;
    end
    gui.defaultPixelFont(font);
    gui.defaultTextBackground(color);
end

local function toggle_default_text()
    if current_font == "gens" then
        current_font = "fceux";
    else
        current_font = "gens";
    end
    set_default_text(current_font, current_color);
end

local function to_screen(text)
    gui.pixelText(x*xs, y*ys, text); y = y + 1;
end

local function to_screen_corner(text)
    local x2 = 239 - ( xs * string.len(text) );
    local y2 = 160 - ( ys * (y+1) );
    gui.pixelText(x2, y2, text);
    y = y + 1;
end

local function display_commands()
    x = 0;
    y = 0;
    options = commands.display_options();
    for i=1,table.getn(options) do
        to_screen(options[i]);
    end
end

local function display_RNG(and_value)
    if and_value then
        to_screen(string.format("Main RNG: %08X", game.get_main_RNG_value()));
    end
    to_screen(string.format("Main Index: %5s", (game.get_main_RNG_index() or "?????")));
    to_screen(string.format("Main Delta: %5s", (game.get_main_RNG_delta() or    "?")));
	if and_value then
        to_screen(string.format("Lazy RNG: %08X", game.get_lazy_RNG_value()));
    end
	to_screen(string.format("Lazy Index: %5s", (game.get_lazy_RNG_index() or "?????")));
    to_screen(string.format("Lazy Delta: %5s", (game.get_lazy_RNG_delta() or    "?")));
end

local function display_steps()
    if game.in_digital_world() then
        to_screen(string.format("Steps: %4u" , game.get_steps()));
        to_screen(string.format("Check: %4u" , game.get_check()));
        to_screen(string.format("Checks: %3u", game.get_encounter_checks()));
        to_screen(string.format("%%: %7.3f%%", game.get_encounter_chance()));
        to_screen(string.format("Next: %2i"  , game.get_next_check()));
    end
    to_screen(string.format("X: %5i", game.get_X()));
    to_screen(string.format("Y: %5i", game.get_Y()));
end

local function display_draws(how_many, start_at)
    start_at = start_at or 1;
    for i=0,how_many-1 do
        to_screen(string.format("%2i: %2i", i+start_at, game.get_draw_slot(i+start_at)));
    end
end

local function display_in_menu()
    to_screen("TODO: Menu HUD");
end

local function display_in_shop()
    to_screen("TODO: Shop HUD");
end

local function display_in_chip_trader()
    to_screen("TODO: Chip Trader HUD");
end

local function display_player_info()
    to_screen(string.format("Zenny  : %6u", game.get_zenny()));
    to_screen(string.format("Max  HP: %6u", game.calculate_max_HP()));
    to_screen(string.format("Library: %6u", game.count_library()));
end

local function display_game_info()
    --to_screen(string.format("Progress: 0x%02X %s", game.get_progress(), game.get_current_progress_name()));
    to_screen("Game Version: " .. game.get_version_name());
    to_screen("HUD  Version: " .. hud.version);
end

---------------------------------------- HUD Functions ----------------------------------------

local function HUD_routing()
    to_screen("TODO: Routing HUD");
end

local function HUD_battle()
    x=0;
    y=0;
    display_draws(10);
    x=7;
    y=0;
    display_draws(10, 11);
    x=14;
    y=0;
    display_draws(10, 21);
    x=21;
    y=0;
    to_screen(string.format("Fight: 0x%4X", game.get_battle_pointer()));
    display_RNG(true);
    to_screen(string.format("Checks: %2u", game.get_encounter_checks()));
    y=0;
    to_screen_corner(game.get_enemy_name(1));
    to_screen_corner(game.get_enemy_name(2));
    to_screen_corner(game.get_enemy_name(3));
end

local function HUD_auto()
    x=0;
    y=0;
    if game.in_title() or game.in_splash() then
        display_game_info();
        to_screen("");
        display_player_info()
        y=0;
        to_screen_corner(game.get_current_area_name());
    elseif game.in_world() then
        display_RNG();
        display_steps();
        y=0;
        to_screen_corner(game.get_current_area_name());
    elseif game.in_battle() or game.in_game_over() then
		if game.game_state_changed() then
			game.simulate_shuffle_folder();
		end
        display_draws(10);
        x=7;
        y=0;
        to_screen(string.format("State: %6s", game.get_battle_state_name()));
        to_screen(string.format("Fight: 0x%4X", game.get_battle_pointer()));
        display_RNG(true);
        to_screen(string.format("Checks: %2u", game.get_encounter_checks()));
        y=0;
        to_screen_corner(game.get_enemy_name(1));
        to_screen_corner(game.get_enemy_name(2));
        to_screen_corner(game.get_enemy_name(3));
    elseif game.in_transition() then
        to_screen("HUD Version: " .. hud.version);
    elseif game.in_menu() then
        display_in_menu();
    elseif game.in_shop() then
        display_in_shop();
    elseif game.in_chip_trader() then
        display_in_chip_trader();
    elseif game.in_credits() then
        gui.text(0, 0, "t r o u t", 0x10000000, "bottomright");
    else
        to_screen("Unknown Game State!");
    end
end

local HUDs = {};
local HUD_mode = 1;

table.insert(HUDs, HUD_auto);
table.insert(HUDs, HUD_battle);
table.insert(HUDs, HUD_routing);

---------------------------------------- Module Controls ----------------------------------------

function hud.initialize(options)
    print("Initializing HUD for MMBN 6...");
    set_default_text(current_font, current_color);
    hud.version = options.major_version .. "." .. hud.minor_version;
    options.maximum_RNG_index = 10 * 60 * 60; -- 10 minutes of frames
    game.initialize(options);
    print("HUD for MMBN 6 " .. game.get_version_name() .. " Initialized.");
end

function hud.update()
    options = {};
    game.update_pre(options);
    
    if buttons_held.L and buttons_held.R then
        if buttons_down.Start then
            show_HUD = not show_HUD;
        end
    end
    
    if show_HUD then
        if command_mode then
            if     buttons_down.Select or keys_down.KeypadPeriod then
                command_mode = false;
                game.battle_unpause();
            elseif buttons_down.Right  or keys_down.Right   then
                commands.next();
            elseif buttons_down.Left   or keys_down.Left    then
                commands.previous();
            elseif buttons_down.Up     or keys_down.Up      then
                commands.option_up();
            elseif buttons_down.Down   or keys_down.Down    then
                commands.option_down();
            elseif buttons_down.B      or keys_down.Keypad0 then
                commands.doit();
            end
            display_commands();
        else
            if (buttons_held.L and buttons_held.R) or keys_down.KeypadPeriod then
                if     buttons_down.Select or keys_down.KeypadPeriod then
                    command_mode = true;
                    game.battle_pause();
                elseif buttons_down.Right  then
                        HUD_mode = (HUD_mode % table.getn(HUDs)) + 1;
                elseif buttons_down.Left   then
                    HUD_mode = HUD_mode - 1;
                    if HUD_mode == 0 then
                        HUD_mode = table.getn(HUDs);
                    end
                elseif buttons_down.Up     then
                    toggle_default_text();
                elseif buttons_down.Down   then
                    toggle_default_text();
                elseif buttons_down.B      then
                    print("");
                    game.print_draw_slots();
                    print(game.get_draw_slots_text());
                elseif buttons_down.A      then
                    print((string.len(buttons_string)/2) .. " Buttons:" .. buttons_string);
                end
            end
            HUDs[HUD_mode]();
        end
    end
    
    game.update_post(options);
end

return hud;

