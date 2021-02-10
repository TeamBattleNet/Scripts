-- HUD Script for the Mega Man Battle Network series, enjoy.

-- In HUD Mode  - Hold L and R then press:
-- Start        - to toggle HUD on/off
-- Select       - to turn Command Mode on
-- Left / Right - to change display mode
-- Up / Down    - to change mode specific values
-- A            - to print inputs from the last folder edit
-- B            - to print game specific information

-- Command Mode - On Controller Press:
-- Select       - to turn Command Mode off
-- Left / Right - to change Command
-- Up / Down    - to change Options
-- B            - to activate the Command Option
-- A            - to activate the Command Option

-- Command Mode - On Keyboard Press:
-- KeypadPeriod - to toggle Command Mode off
-- Left / Right - to change Command
-- Up / Down    - to change Options
-- Tab          - to activate the Command Option
-- Keypad0      - to activate the Command Option

-- Special thanks to Prof9, GreigaMaster, NMarkro, Risch, Mountebank, TL_Plexa, TREZ, and TeamBN

-- https://drive.google.com/drive/folders/1NjYy8mXjc-B06gpng1D2WzWJT4waQAFV "The Notes"

local hud = { game={}; version="0.5"; };

local controls = require("All/Controls");
local settings = require("All/Settings");

---------------------------------------- Input Functions ----------------------------------------

local keys_held = {};
local keys_previous = {};
local keys_down = {};

local buttons_held = {};
local buttons_previous = {};
local buttons_down = {};

local buttons_ignore = {};
local buttons_string = "";

settings.command_mode = false;

local function record_menu_buttons()
    if hud.game.in_menu() and hud.game.in_menu_folder_edit() then
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

local function disable_button(button, to_false)
    if buttons_ignore[button] then
        if buttons_held[button] then
            joypad.set(to_false);
            buttons_down[button] = false;
        elseif buttons_previous[button] then
            -- wait 1 more frame
        else
            buttons_ignore[button] = false;
        end
    elseif buttons_down[button] then
        joypad.set(to_false);
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
    keys_held = input.get(); -- controller, keyboard, and mouse
    buttons_held = joypad.get(); -- controller only
    
    keys_down.Up           = (keys_held.Up           and not keys_previous.Up          );
    keys_down.Down         = (keys_held.Down         and not keys_previous.Down        );
    keys_down.Left         = (keys_held.Left         and not keys_previous.Left        );
    keys_down.Right        = (keys_held.Right        and not keys_previous.Right       );
    keys_down.Tab          = (keys_held.Tab          and not keys_previous.Tab         );
    keys_down.Keypad0      = (keys_held.Keypad0      and not keys_previous.Keypad0     );
    keys_down.KeypadPeriod = (keys_held.KeypadPeriod and not keys_previous.KeypadPeriod);
    
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
    
    record_menu_buttons(); -- for folder edits
    
    if settings.command_mode then
        disable_buttons_in_command_mode();
    end
    
    keys_previous = keys_held;
    buttons_previous = buttons_held;
end

---------------------------------------- Display Functions ----------------------------------------

hud.x = 0;
hud.y = 0;
hud.x0 = 0;
hud.y0 = 0;

hud.ws = 1;
hud.xs = 0;
hud.ys = 0;

settings.use_gui_text = true;
settings.pixel_background_color = 0x80000000;

function settings.set_text_background(new_background_color)
    gui.defaultTextBackground(new_background_color);
    settings.pixel_background_color = new_background_color;
end

function settings.set_display_text(font)
    if     font == "gui" then
        hud.xs = 10;
        hud.ys = 13+3;
        hud.show_text = gui.text;
        settings.use_gui_text = true;
    elseif font == "gens" then
        hud.xs =  4;
        hud.ys =  7;
        hud.show_text = gui.pixelText;
        settings.use_gui_text = false;
        gui.defaultPixelFont("gens");
        gui.defaultTextBackground(settings.pixel_background_color);
    elseif font == "fceux" then
        hud.xs =  6;
        hud.ys =  9;
        hud.show_text = gui.pixelText;
        settings.use_gui_text = false;
        gui.defaultPixelFont("fceux");
        gui.defaultTextBackground(settings.pixel_background_color);
    end
end

function hud.set_ws()
    if settings.use_gui_text then
        hud.ws = client.getwindowsize(); -- Screen is GBA * ws
    else
        hud.ws = 1; -- gui.pixelText draws before window scaling
    end
end

function hud.set_position(x, y)
    if settings.use_gui_text then
        hud.x0 = (x or 2) * hud.ws;
        hud.y0 = (y or 1) * hud.ws;
    else -- pixelText looks best in the corner
        hud.x0 = 0;
        hud.y0 = 0;
    end
end

function hud.set_offset(x, y)
    hud.x = x or 0;
    hud.y = y or 0;
end

function hud.set_center(characters, y)
    hud.x = 0;
    hud.y = 0;
    hud.y0 = settings.use_gui_text and y or 0;
    hud.x0 = ((240 * hud.ws) - (characters*hud.xs)) / 2;
end

function hud.to_screen(text, x, y)
    x = (x and x*hud.ws) or (hud.x0 + hud.x*hud.xs);
    y = (y and y*hud.ws) or (hud.y0 + hud.y*hud.ys);
    if settings.use_gui_text then
        --x = x + 3*(hud.ws-2)*string.len(text);
        --y = y + 4*(hud.ws-2);
    end
    hud.show_text(x, y, text);
    hud.y = hud.y + 1;
end

function hud.to_bottom_right_gui(text)
    local x = 3;
    local y = 3 + hud.y*hud.ys;
    gui.text(x, y, text, 0xFFFFFFFF, "bottomright");
    hud.y = hud.y + 1;
end

function hud.to_bottom_right_pixel(text)
    local x = 239 - ( hud.xs * string.len(text) );
    local y = 160 - ( hud.ys * (hud.y+1) );
    gui.pixelText(x, y, text); -- GBA is 240x160
    hud.y = hud.y + 1;
end

function hud.to_bottom_right(text)
    if settings.use_gui_text then
        hud.to_bottom_right_gui(text);
    else
        hud.to_bottom_right_pixel(text);
    end
end

function hud.display_commands()
    if settings.use_gui_text and hud.ws >= 3 then
        hud.HUDs[hud.HUD_mode]();
    end
    hud.set_center(40, 32);
    local options = controls.get_options();
    for i=1,table.getn(options) do
        hud.to_screen(options[i]);
    end
end

---------------------------------------- Display Functions ----------------------------------------

function hud.display_game_info()
    hud.to_screen(string.format("Progress: 0x%02X %s", hud.game.get_progress(), hud.game.get_progress_name_current()));
    hud.to_screen("HUD   Version: " .. hud.version);
    hud.to_screen("Game  Version: " .. hud.game.get_version_name());
end

function hud.display_RNG(and_value) -- for BN1 & BN2
    if and_value then
        hud.to_screen(string.format("RNG: %08X", hud.game.get_main_RNG_value()));
    end
    hud.to_screen(string.format("Index: %5s", (hud.game.get_main_RNG_index() or "?????")));
    hud.to_screen(string.format("Delta: %5s", (hud.game.get_main_RNG_delta() or     "?")));
end

function hud.display_main_RNG(and_value)
    if and_value then
        hud.to_screen(string.format("M RNG: %08X", hud.game.get_main_RNG_value()));
    end
    hud.to_screen(string.format("M Index: %5s", (hud.game.get_main_RNG_index() or "?????")));
    hud.to_screen(string.format("M Delta: %5s", (hud.game.get_main_RNG_delta() or     "?")));
end

function hud.display_lazy_RNG(and_value)
    if and_value then
        hud.to_screen(string.format("L RNG: %08X", hud.game.get_lazy_RNG_value()));
    end
    hud.to_screen(string.format("L Index: %5s", (hud.game.get_lazy_RNG_index() or "?????")));
    hud.to_screen(string.format("L Delta: %5s", (hud.game.get_lazy_RNG_delta() or     "?")));
end

function hud.display_steps(detailed)
    hud.to_screen(string.format("Steps: %5u" , hud.game.get_steps()));
    if hud.game.in_digital_world() then
        hud.to_screen(string.format("Check: %5u" , hud.game.get_check()));
        hud.to_screen(string.format("Checks: %4u", hud.game.get_encounter_checks()));
        if detailed then
            hud.to_screen(string.format("A%%: %7.3f%%", hud.game.get_area_percent()));
            hud.to_screen(string.format("T%%: %7.3f%%", hud.game.get_current_percent()));
        end
        hud.to_screen(string.format("E%%: %7.3f%%", hud.game.get_encounter_percent()));
        hud.to_screen(string.format("Next: %2i"  , hud.game.get_next_check()));
    end
    hud.to_screen(string.format("X: %5i", hud.game.get_X()));
    hud.to_screen(string.format("Y: %5i", hud.game.get_Y()));
end

function hud.display_area()
    hud.set_offset();
    hud.to_bottom_right(hud.game.get_area_name_current());
end

function hud.display_enemy(which_enemy)
    local enemy_name = hud.game.get_enemy_name(which_enemy);
    if enemy_name ~= "Unknown" and enemy_name ~= "Empty" and enemy_name ~= "MegaMan" then
        hud.to_bottom_right(enemy_name);
    end
end

function hud.display_enemies()
    hud.set_offset();
    hud.display_enemy(1);
    hud.display_enemy(2);
    hud.display_enemy(3);
end

function hud.display_draws(how_many, start_at)
    start_at = start_at or 1;
    for i=0,how_many-1 do
        hud.to_screen(string.format("%2i: %2i", i+start_at, hud.game.get_draw_slot(i+start_at)));
    end
end

---------------------------------------- HUD Modes ----------------------------------------

hud.HUDs = {};
hud.HUD_mode =  1;
table.insert(hud.HUDs, function() hud.to_screen("HUD Version: " .. hud.version); end);

---------------------------------------- HUD Controls ----------------------------------------

function hud.Up()
    -- should be overridden per game
end

function hud.Down()
    -- should be overridden per game
end

function hud.Left()
    hud.HUD_mode = hud.HUD_mode - 1;
    if hud.HUD_mode == 0 then
        hud.HUD_mode = table.getn(hud.HUDs);
    end
end

function hud.Right()
    hud.HUD_mode = (hud.HUD_mode % table.getn(hud.HUDs)) + 1;
end

function hud.B()
    print("TODO: Print Game Specific Information.");
end

function hud.A()
    print(string.format("\n%u Buttons:%s", (string.len(buttons_string)/2), buttons_string));
end

function hud.update_local_state()
    -- for tracking game specific HUD values over time
end

---------------------------------------- Module Controls ----------------------------------------

local show_HUD = true;

function hud.update()
    local options = {};
    hud.game.update_pre(options);
    
    if buttons_held.L and buttons_held.R then
        if buttons_down.Start then
            show_HUD = not show_HUD;
        end
    end
    
    if show_HUD then
        hud.set_ws();
        hud.set_offset();
        hud.set_position();
        if settings.command_mode then
            if     buttons_down.Select or keys_down.KeypadPeriod then
                settings.command_mode = false;
            elseif buttons_down.Up     or keys_down.Up      then
                controls.previous_option();
            elseif buttons_down.Down   or keys_down.Down    then
                controls.next_option();
            elseif buttons_down.Left   or keys_down.Left    then
                controls.previous_command();
            elseif buttons_down.Right  or keys_down.Right   then
                controls.next_command();
            elseif buttons_down.B      or keys_down.Tab     then
                controls.doit();
            elseif buttons_down.A      or keys_down.Keypad0 then
                controls.doit();
            end
            hud.display_commands();
        else
            if buttons_held.L and buttons_held.R then
                if     buttons_down.Select then
                    settings.command_mode = true;
                elseif buttons_down.Up     then
                    hud.Up();
                elseif buttons_down.Down   then
                    hud.Down();
                elseif buttons_down.Left   then
                    hud.Left();
                elseif buttons_down.Right  then
                    hud.Right();
                elseif buttons_down.B      then
                    hud.B();
                elseif buttons_down.A      then
                    hud.A();
                end
            else
                if     keys_down.KeypadPeriod then
                    settings.command_mode = true;
                elseif keys_down.Up      then
                    hud.Up();
                elseif keys_down.Down    then
                    hud.Down();
                elseif keys_down.Left    then
                    hud.Left();
                elseif keys_down.Right   then
                    hud.Right();
                end
            end
            hud.HUDs[hud.HUD_mode]();
        end
    end
    
    if hud.game.did_game_state_change() and hud.game.in_menu() and hud.game.in_menu_folder_edit() then
        buttons_string = "";
    end
    
    hud.game.update_post(options);
    
    hud.update_local_state();
end

function hud.initialize()
    print("\nInitializing MMBN HUD...");
    process_inputs_BN_HUD_reference = event.onframestart(process_inputs_BN_HUD, "process_inputs_BN_HUD");
    settings.set_display_text("fceux");
    controls.initialize(hud.game.number);
    hud.game.initialize({maximum_RNG_index = 10 * 60 * 60}); -- 10 minutes of frames
    print(string.format("\nInitialized HUD %s for MMBN %s - %s!", hud.version, hud.game.number, hud.game.get_version_name()));
    --require("Test/Tests").test_this(hud);
end

return hud;

