-- HUD Script for Mega Man Battle Network 3, enjoy.

-- https://drive.google.com/drive/folders/1K2foCnQbJ_bM2ewBhvxVo7JAdSzV1Ecm Did you check The Notes?

local hud = require("All/HUD");

hud.version = hud.version .. ".0.1";

hud.game = require("BN3/Game");

---------------------------------------- Display Functions ----------------------------------------

local function display_RNG()
end

local function display_RNG(and_value)
    if and_value then
        hud.to_screen(string.format("M RNG: %08X", hud.game.get_main_RNG_value()));
    end
    hud.to_screen(string.format("M Index: %5s", (hud.game.get_main_RNG_index() or "?????")));
    hud.to_screen(string.format("M Delta: %5s", (hud.game.get_main_RNG_delta() or     "?")));
    hud.to_screen("");
    if and_value then
        hud.to_screen(string.format("L RNG: %08X", hud.game.get_lazy_RNG_value()));
    end
    hud.to_screen(string.format("L Index: %5s", (hud.game.get_lazy_RNG_index() or "?????")));
    hud.to_screen(string.format("L Delta: %5s", (hud.game.get_lazy_RNG_delta() or     "?")));
end

local function display_enemy(which_enemy)
    if hud.game.get_enemy_name(which_enemy) ~= "Unknown" and hud.game.get_enemy_name(which_enemy) ~= "Empty" then
        hud.to_bottom_right(hud.game.get_enemy_name(which_enemy));
    end
end

local function display_enemies()
    hud.y=0;
    display_enemy(1);
    display_enemy(2);
    display_enemy(3);
end

local function display_draws(how_many, start_at)
    start_at = start_at or 1;
    for i=0,how_many-1 do
        hud.to_screen(string.format("%2i: %2i", i+start_at, hud.game.get_draw_slot(i+start_at)));
    end
end

local function display_edit_slots()
    if hud.game.in_folder() then
        for i=1,8 do
            gui.pixelText( 91, 11+16*i, string.format("%2i", hud.game.get_cursor_offset_folder()+i));
        end
    elseif hud.game.in_pack() then
        for i=1,8 do
            gui.pixelText(129, 11+16*i, string.format("%3i", hud.game.get_cursor_offset_pack()+i));
        end
    end
end

local function display_selected_chip()
    -- TODO
end

local function display_player_info()
    hud.to_screen(string.format("Zenny  : %6u", hud.game.get_zenny()));
    hud.to_screen(string.format("B Frags: %6u", hud.game.get_bug_frags()));
    hud.to_screen(string.format("Max  HP: %6u", hud.game.calculate_max_HP()));
    hud.to_screen(string.format("Library: %6u", hud.game.count_library()));
    hud.to_screen(string.format("Level  : %6u", hud.game.calculate_mega_level()));
    hud.to_screen("Current Style: " .. hud.game.get_style_name());
    hud.to_screen("Next Element : " .. hud.game.get_next_element_name());
end

local function display_game_info()
    hud.to_screen(string.format("Progress: 0x%02X %s", hud.game.get_progress(), hud.game.get_progress_name_current()));
    hud.to_screen("Game Version: " .. hud.game.get_version_name());
    hud.to_screen("HUD  Version: " .. hud.version);
end

local function display_in_menu()
    hud.to_screen("TODO: Menu HUD");
end

---------------------------------------- HUD Modes ----------------------------------------

local function HUD_auto()
    if hud.game.in_title() or hud.game.in_splash() then
        display_game_info();
        hud.to_screen("");
        display_RNG();
        hud.y = 0;
        hud.to_bottom_right(hud.game.get_area_name_current());
    elseif hud.game.in_world() then
        hud.display_main_RNG();
        hud.to_screen("");
        hud.display_lazy_RNG();
        hud.to_screen("");
        if hud.game.is_gambling() then
            hud.to_screen("Gamble  Win: " .. hud.game.get_gamble_win( ));
            hud.to_screen("Gamble Pick: " .. hud.game.get_gamble_pick());
            hud.to_screen("");
        else
            hud.display_steps(true);
        end
        hud.y = 0;
        hud.to_bottom_right(hud.game.get_area_name_current());
    elseif hud.game.in_battle() then
        display_draws(9);
        hud.x = 9;
        hud.y = 0;
        display_RNG();
        hud.to_screen("");
        hud.to_screen(string.format("Checks: %2u", hud.game.get_encounter_checks()));
        hud.to_screen(string.format("%%: %7.3f%%", 100-hud.game.get_current_percent()));
        display_enemies();
    elseif hud.game.in_transition() then
        hud.to_screen("HUD Version: " .. hud.version);
        gui.text(0, 0, "For the best emotes on Twitch, subscribe to twitch.tv/subs/xKilios!", 0x77000000, "bottomright");
    elseif hud.game.in_menu() then
        display_in_menu();
    elseif hud.game.in_credits() then
        gui.text(0, 0, "t r o u t", 0x10000000, "bottomright");
    else
        hud.to_screen("Unknown Game State!");
    end
end

hud.HUDs = {}; -- in order
table.insert(hud.HUDs, HUD_auto);
--table.insert(hud.HUDs, HUD_battle);
--table.insert(hud.HUDs, HUD_routing);
--table.insert(hud.HUDs, HUD_speedrun);

---------------------------------------- Module Controls ----------------------------------------

function hud.B()
    print("\n" .. hud.game.get_draw_slots_text_multi_line());
    print("\n" .. hud.game.get_draw_slots_text_one_line());
end

function hud.update_local_state()
    -- for tracking game specific HUD values over time
end

return hud;

