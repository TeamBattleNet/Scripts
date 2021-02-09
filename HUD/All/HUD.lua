-- HUD Script for the Mega Man Battle Network series, enjoy.

-- In HUD Mode  - Hold L and R then press:
-- Start        - to toggle HUD on/off
-- Select       - to turn Command Mode on
-- Left / Right - to change display mode
-- Up / Down    - to change display font
-- A            - to print inputs from the last folder edit
-- B            - to print game specific information

-- Command Mode - On Controller Press:
-- Select       - to turn Command Mode off
-- Left / Right - to change Command
-- Up / Down    - to change Options
-- B            - to change display font
-- A            - to activate the Command Option

-- Command Mode - On Keyboard Press:
-- KeypadPeriod - to toggle Command Mode off
-- Left / Right - to change Command
-- Up / Down    - to change Options
-- Tab          - to change display font
-- Keypad0      - to activate the Command Option

-- Special thanks to Prof9, NMarkro, Risch, Tterraj42, TL_Plexa, Mountebank, TREZ, and TeamBN

-- https://drive.google.com/drive/folders/1NjYy8mXjc-B06gpng1D2WzWJT4waQAFV "The Notes"

local hud = { game={}; version="0.4"; };

local controls = require("All/Controls");

---------------------------------------- Input Functions ----------------------------------------

local keys_held = {};
local keys_previous = {};
local keys_down = {};

local buttons_held = {};
local buttons_previous = {};
local buttons_down = {};

local buttons_ignore = {};
local buttons_string = "";

local command_mode = false;

function controls.set_command_mode(new_command_mode)
    command_mode = new_command_mode;
end

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
    
    if command_mode then
        disable_buttons_in_command_mode();
    end
    
    keys_previous = keys_held;
    buttons_previous = buttons_held;
end

process_inputs_BN_HUD_reference = event.onframestart(process_inputs_BN_HUD, "process_inputs_BN_HUD");

---------------------------------------- Display Functions ----------------------------------------

hud.use_gui_text = false;

hud.x = 0;
hud.y = 0;

local xs = 0;
local ys = 0;

local ws = 1; -- window size

local current_font = "fceux";
local current_color = 0x77000000;

function hud.set_default_text(font, color)
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

function hud.toggle_default_text()
    if current_font == "gens" then
        current_font = "fceux";
    else
        current_font = "gens";
    end
    hud.set_default_text(current_font, current_color);
end

function hud.position_top_left()
    hud.x = 0;
    hud.y = 0;
end

function hud.to_screen_gui(text)
    gui.text(hud.x, hud.y, text); -- Screen is 240x160 * ws
    hud.y = hud.y + 16; --- gui.text characters are 10 x 13
end

function hud.to_screen_pixel(text)
    gui.pixelText(hud.x*xs, hud.y*ys, text); hud.y = hud.y + 1; -- GBA is 240x160
end

function hud.to_screen(text)
    if hud.use_gui_text then
        hud.to_screen_gui(text);
    else
        hud.to_screen_pixel(text);
    end
end

function hud.to_bottom_right_gui(text)
    gui.text(hud.x*ws, hud.y*ws, text, 0xFFFFFFFF, "bottomright"); hud.y = hud.y + 1;
end

function hud.to_bottom_right_pixel(text)
    local x = 239 - ( xs * string.len(text) );
    local y = 160 - ( ys * (hud.y+1) );
    gui.pixelText(x, y, text);
    hud.y = hud.y + 1;
end

function hud.to_bottom_right(text)
    if hud.use_gui_text then
        hud.to_bottom_right_gui(text);
    else
        hud.to_bottom_right_pixel(text);
    end
end

function hud.display_commands()
    local options = controls.get_options();
    for i=1,table.getn(options) do
        hud.to_screen(options[i]);
    end
end

---------------------------------------- HUD Modes ----------------------------------------

hud.HUDs = {};
local HUD_mode =  1;

function hud.HUDs.HUD_auto()
    hud.to_screen(string.format("HUD Version: %s", hud.version));
end

---------------------------------------- HUD Controls ----------------------------------------

function hud.Up()
    hud.toggle_default_text();
end

function hud.Down()
    hud.toggle_default_text();
end

function hud.Left()
    HUD_mode = HUD_mode - 1;
    if HUD_mode == 0 then
        HUD_mode = table.getn(hud.HUDs);
    end
end

function hud.Right()
    HUD_mode = (HUD_mode % table.getn(hud.HUDs)) + 1;
end

function hud.B()
    print("TODO: Print Game Specific Information");
end

function hud.A()
    print(string.format("\n%u Buttons:%s", (string.len(buttons_string)/2), buttons_string));
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
        hud.position_top_left();
        ws = client.getwindowsize();
        if command_mode then
            if     buttons_down.Select or keys_down.KeypadPeriod then
                controls.set_command_mode(false);
            elseif buttons_down.Up     or keys_down.Up      then
                controls.previous_option();
            elseif buttons_down.Down   or keys_down.Down    then
                controls.next_option();
            elseif buttons_down.Left   or keys_down.Left    then
                controls.previous_command();
            elseif buttons_down.Right  or keys_down.Right   then
                controls.next_command();
            elseif buttons_down.B      or keys_down.Tab     then
                hud.toggle_default_text();
            elseif buttons_down.A      or keys_down.Keypad0 then
                controls.doit();
            end
            hud.display_commands();
        else
            if buttons_held.L and buttons_held.R then
                if     buttons_down.Select then
                    controls.set_command_mode(true);
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
                    controls.set_command_mode(true);
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
            hud.HUDs[HUD_mode]();
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
    controls.initialize(hud.game.number);
    hud.set_default_text(current_font, current_color);
    hud.game.initialize({maximum_RNG_index = 10 * 60 * 60;}); -- 10 minutes of frames
    print(string.format("\nInitialized HUD %s for MMBN %s - %s!", hud.version, hud.game.number, hud.game.get_version_name()));
    --require("Test/Tests").test_this(hud);
end

return hud;

