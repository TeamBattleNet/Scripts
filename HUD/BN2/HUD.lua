-- HUD Script for Mega Man Battle Network 2, enjoy.

-- https://drive.google.com/drive/folders/1Vu4Ze91RP95ndYBsTznmGwKgxk_wKt81 Did you check The Notes?

local hud = require("All/HUD");

hud.version = hud.version .. ".0.0";

hud.game = require("BN2/Game");

local coin_wins = 0;
local coin_flips = 0;
local total_fights = 0;

---------------------------------------- Display Functions ----------------------------------------

local function display_player_info()
    hud.to_screen(string.format("Zenny  : %6u", hud.game.get_zenny()));
    hud.to_screen(string.format("Max  HP: %6u", hud.game.calculate_max_HP()));
    hud.to_screen(string.format("Library: %6u", hud.game.count_library()));
    hud.to_screen(string.format("Level  : %6u", hud.game.calculate_mega_level()));
end

local function display_edit_slots()
    if hud.game.in_folder() then
        for i=1,8 do
            hud.to_pixel( 97, 16+16*i, string.format("%2i", hud.game.get_cursor_offset_folder()+i));
        end
    elseif hud.game.in_pack() then
        for i=1,8 do
            hud.to_pixel(139, 16+16*i, string.format("%3i", hud.game.get_cursor_offset_pack()+i));
        end
    end
end

local function display_selected_chip()
    -- TODO: Selected Chip
end

--- Display calculated Style points gained during the battle
local function display_style_points()
    hud.set_offset();
    hud.to_top_right(string.format("Guts:   %4u", hud.game.calc_battle_guts_points()));
    hud.to_top_right(string.format("Custom: %4u", hud.game.calc_battle_custom_points()));
    hud.to_top_right(string.format("Team:   %4u", hud.game.calc_battle_team_points()));
    hud.to_top_right(string.format("Shield: %4u", hud.game.calc_battle_shield_points()));
end

---------------------------------------- HUD Modes ----------------------------------------

local function HUD_speedrun()
    hud.to_screen(string.format("Progress: 0x%02X %s", hud.game.get_progress(), hud.game.get_progress_name_current()));
    display_player_info();
    hud.to_screen(string.format("EnCounter: %4u", total_fights));
    hud.display_RNG();
    hud.display_area();
end

local function HUD_routing()
    hud.set_position(0, 8);
    hud.set_center_x(54);
    hud.to_screen("0040: " .. hud.game.get_string_hex   (0x02000040, 16, true));
    hud.to_screen("0100: " .. hud.game.get_string_hex   (0x02000100, 16, true));
    hud.to_screen("0040: " .. hud.game.get_string_binary(0x02000040,  4, true));
    hud.to_screen("0044: " .. hud.game.get_string_binary(0x02000044,  4, true));
    hud.to_screen("0048: " .. hud.game.get_string_binary(0x02000048,  4, true));
    hud.to_screen("004C: " .. hud.game.get_string_binary(0x0200004C,  4, true));
    hud.to_screen("0048: " .. hud.game.get_string_binary(0x02000048,  1, true));
    hud.set_offset(16, hud.y-1);
    hud.to_screen(tostring(hud.game.is_go_mode()));
    hud.to_screen("");
    hud.to_screen("Element: " .. hud.game.get_next_element_name());
end

local function HUD_battle()
    hud.set_position(1, 17);
    hud.set_offset( 0, 0);
    hud.display_draws(10,  1);
    hud.set_offset( 8, 0);
    hud.display_draws(10, 11);
    hud.set_offset(16, 0);
    hud.display_draws(10, 21);
    hud.set_offset(24, 0);
    hud.to_screen(string.format("Fight: 0x%04X", hud.game.get_battle_pointer()));
    hud.display_RNG(true);
    hud.to_screen(string.format("Checks: %4u", hud.game.get_encounter_checks()));
    hud.to_screen(string.format("%%: %8.3f%%", 100-hud.game.get_current_percent()));
    --hud.to_screen(string.format("Drawfset: %2u", draw_offset));
    hud.display_enemies();
    display_style_points();
end

local function HUD_auto()
    if hud.game.in_title() or hud.game.in_splash() or hud.game.in_transition() then
        hud.display_game_info();
        hud.to_screen(string.format("EnCounter: %3u", total_fights));
        hud.to_screen("");
        display_player_info();
        hud.to_screen("");
        hud.display_RNG(true);
        hud.to_screen("Element: " .. hud.game.get_next_element_name());
        hud.display_area();
    elseif hud.game.in_world() then
        if hud.game.in_real_world() then
            hud.set_position(2, 23);
        else
            hud.set_position(2, 17);
        end
        hud.display_RNG();
        hud.display_steps(true);
        if hud.game.get_sneak() > 0 then
            hud.to_screen(string.format("Sneak: %5u", hud.game.get_sneak()));
        end
        hud.display_area();
    elseif hud.game.in_battle() or hud.game.in_game_over() then
        if hud.game.in_combat() then
            hud.set_position(2, 17);
            hud.to_screen(string.format("Fight: 0x%04X", hud.game.get_battle_pointer()));
            hud.display_RNG(true);
        else
            hud.set_position(2, 25);
            hud.display_draws(9);
            hud.set_offset(8, 0);
            hud.to_screen(string.format("Fight: 0x%04X", hud.game.get_battle_pointer()));
            hud.display_RNG(true);
            hud.to_screen(string.format("Escape: %4i", hud.game.find_first(138)));
            hud.to_screen(string.format("Checks: %4u", hud.game.get_encounter_checks()));
            hud.to_screen(string.format("%%: %8.3f%%", 100-hud.game.get_current_percent()));
        end
        hud.display_enemies();
        display_style_points();
    elseif hud.game.in_menu() then
        hud.display_RNG();
        if hud.game.in_menu_folder_edit() then
            display_edit_slots();
            display_selected_chip();
        end
    elseif hud.game.in_shop() then
        hud.set_position(170, 34);
        display_player_info();
    elseif hud.game.in_chip_trader() then
        hud.set_position(105, 1);
        hud.display_RNG(true);
    elseif hud.game.in_credits() then
        hud.display_game_info();
    else
        hud.to_screen("Unknown Game State!");
    end
end

hud.HUDs = {}; -- in order
table.insert(hud.HUDs, HUD_auto);
table.insert(hud.HUDs, HUD_battle);
table.insert(hud.HUDs, HUD_routing);
table.insert(hud.HUDs, HUD_speedrun);

---------------------------------------- Module Controls ----------------------------------------

function hud.Up()
    print("\n" .. hud.game.get_folder_text(1));
end

function hud.Down()
    print("\n" .. hud.game.get_draw_slots_text_multi_line());
end

function hud.B()
    print("\n" .. hud.game.get_draw_slots_text_one_line());
end

function hud.update_local_state()
    if hud.game.did_game_state_change() and hud.game.in_battle() then
        total_fights = total_fights + 1;
    end
end

return hud;

