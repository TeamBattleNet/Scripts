-- HUD Script for the Mega Man Battle Network series, enjoy.

-- In HUD Mode   -  Hold L and R then press:
-- Start         -  to toggle HUD on/off
-- Select        -  to turn Command Mode on
-- Left / Right  -  to change display mode
-- Up / Down     -  to change mode specific values
-- A             -  to print inputs from the last folder edit
-- B             -  to print game specific information

-- Command Mode  -  On Controller Press:
-- Select        -  to turn Command Mode off
-- Left / Right  -  to change Command
-- Up / Down     -  to change Options
-- A / B         -  to activate the Command Option

-- Command Mode  -  On Keyboard Press:
-- KeypadPeriod  -  to toggle Command Mode off
-- Left / Right  -  to change Command
-- Up / Down     -  to change Options
-- Tab / Keypad0 -  to activate the Command Option

-- https://drive.google.com/drive/folders/1NjYy8mXjc-B06gpng1D2WzWJT4waQAFV "The Notes"

-- Special thanks to Prof9, GreigaMaster, NMarkro, Risch, Mountebank, TL_Plexa, TREZ, and TeamBN

local hud = require("All/Display");

local buttons  = require("All/Buttons");
local controls = require("All/Controls");
local settings = require("All/Settings");

---------------------------------------- Input Functions ----------------------------------------

local buttons_string = "";

local function record_menu_buttons()
    if hud.game.in_menu() and hud.game.in_menu_folder_edit() then
        if buttons.down.Up then
            buttons_string = buttons_string .. " ^"; -- ↑ ▲
        end
        
        if buttons.down.Down then
            buttons_string = buttons_string .. " v"; -- ↓ ▼
        end
        
        if buttons.down.Left then
            buttons_string = buttons_string .. " >"; -- ← ◄
        end
        
        if buttons.down.Right then
            buttons_string = buttons_string .. " <"; -- → ►
        end
        
        if buttons.down.Start then
            buttons_string = buttons_string .. " S";
        end
        
        if buttons.down.Select then
            buttons_string = buttons_string .. " s";
        end
        
        if buttons.down.B then
            buttons_string = buttons_string .. " B";
        end
        
        if buttons.down.A then
            buttons_string = buttons_string .. " A";
        end
        
        if buttons.down.L then
            buttons_string = buttons_string .. " L";
        end
        
        if buttons.down.R then
            buttons_string = buttons_string .. " R";
        end
    end
end

---------------------------------------- HUD Modes ----------------------------------------

hud.HUDs = {};
hud.HUD_mode =  1;
table.insert(hud.HUDs, function() hud.to_screen("HUD Version: " .. hud.version); end);

---------------------------------------- HUD Controls ----------------------------------------

function hud.Up()
    print("TODO: Print HUD Specific Information.");
end

function hud.Down()
    print("TODO: Print HUD Specific Information.");
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
settings.command_mode = false;

function hud.update()
    record_menu_buttons();
    hud.game.pre_update({});
    
    if buttons.held.L and buttons.held.R then
        if buttons.down.Start then
            show_HUD = not show_HUD;
        end
    end
    
    if show_HUD then
        hud.reset_values();
        if settings.command_mode then
            if     buttons.down.Select or buttons.keys.down.KeypadPeriod then
                settings.command_mode = false;
            elseif buttons.down.Up     or buttons.keys.down.Up      then
                controls.previous_option();
            elseif buttons.down.Down   or buttons.keys.down.Down    then
                controls.next_option();
            elseif buttons.down.Left   or buttons.keys.down.Left    then
                controls.previous_command();
            elseif buttons.down.Right  or buttons.keys.down.Right   then
                controls.next_command();
            elseif buttons.down.B      or buttons.keys.down.Tab     then
                controls.doit();
            elseif buttons.down.A      or buttons.keys.down.Keypad0 then
                controls.doit();
            end
            hud.set_center_x(40);
            hud.set_center_y(18);
            hud.display_strings(controls.get_options());
        else
            if buttons.held.L and buttons.held.R then
                if     buttons.down.Select then
                    settings.command_mode = true;
                elseif buttons.down.Up     then
                    hud.Up();
                elseif buttons.down.Down   then
                    hud.Down();
                elseif buttons.down.Left   then
                    hud.Left();
                elseif buttons.down.Right  then
                    hud.Right();
                elseif buttons.down.B      then
                    hud.B();
                elseif buttons.down.A      then
                    hud.A();
                end
            else
                if     buttons.keys.down.KeypadPeriod then
                    settings.command_mode = true;
                elseif buttons.keys.down.Up      then
                    hud.Up();
                elseif buttons.keys.down.Down    then
                    hud.Down();
                elseif buttons.keys.down.Left    then
                    hud.Left();
                elseif buttons.keys.down.Right   then
                    hud.Right();
                end
            end
            hud.set_ws();
            hud.set_offset();
            hud.set_position();
            hud.HUDs[hud.HUD_mode]();
        end
    end
    
    if hud.game.did_game_state_change() and hud.game.in_menu() and hud.game.in_menu_folder_edit() then
        buttons_string = "";
    end
    
    hud.game.post_update({});
    
    hud.update_local_state();
end

function hud.initialize()
    print("\nInitializing MMBN HUD...");
    settings.set_display_text("fceux");
    controls.initialize(hud.game.number);
    hud.game.initialize({maximum_RNG_index = 10 * 60 * 60}); -- 10 minutes of frames
    print(string.format("\nInitialized HUD %s for MMBN %s - %s!", hud.version, hud.game.number, hud.game.get_version_name()));
    --require("Test/Tests").test_this(hud);
end

return hud;

