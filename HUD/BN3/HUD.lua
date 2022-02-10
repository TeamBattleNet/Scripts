-- HUD Script for Mega Man Battle Network 3, enjoy.

-- https://drive.google.com/drive/folders/1K2foCnQbJ_bM2ewBhvxVo7JAdSzV1Ecm Did you check The Notes?

local hud = require("All/HUD");

hud.version = hud.version .. ".1.1";

hud.game = require("BN3/Game");

local total_fights = 0;

---------------------------------------- Display Functions ----------------------------------------

local function display_player_info()
    hud.to_screen(string.format("Zenny  : %6u", hud.game.get_zenny()));
    hud.to_screen(string.format("BugFrag: %6u", hud.game.get_bug_frags()));
    hud.to_screen(string.format("Max  HP: %6u", hud.game.calculate_max_HP()));
    hud.to_screen(string.format("Library: %6u", hud.game.count_library()));
end

local function display_edit_slots()
    if hud.game.in_folder() then
        for i=1,7 do
            hud.to_pixel( 99, 25+16*i, string.format("%2i", hud.game.get_cursor_offset_folder()+i));
        end
    elseif hud.game.in_pack() then
        for i=1,7 do
            hud.to_pixel(133, 25+16*i, string.format("%3i", hud.game.get_cursor_offset_pack()+i));
        end
    end
end

local function display_selected_chip()
    -- TODO: Selected Chip
end

---------------------------------------- HUD Modes ----------------------------------------

local function HUD_speedrun()
    hud.to_screen(string.format("Progress: 0x%02X %s", hud.game.get_progress(), hud.game.get_progress_name_current()));
    display_player_info();
    hud.to_screen(string.format("EnCounter: %4u", total_fights));
    hud.to_screen("");
    hud.display_both_RNG(true, false);
    hud.display_area();
end

local function HUD_routing()
    hud.set_position(0, 8);
    hud.set_center_x(54);
    --[[
    hud.to_screen("0030: " .. hud.game.get_string_hex   (0x02000030, 16, true));
    hud.to_screen("0040: " .. hud.game.get_string_hex   (0x02000040, 16, true));
    hud.to_screen("");
    hud.to_screen("0030: " .. hud.game.get_string_binary(0x02000030,  4, true));
    hud.to_screen("0034: " .. hud.game.get_string_binary(0x02000034,  4, true));
    hud.to_screen("0038: " .. hud.game.get_string_binary(0x02000038,  4, true));
    hud.to_screen("003C: " .. hud.game.get_string_binary(0x0200003C,  4, true));
    --hud.to_screen("0000: " .. hud.game.get_string_binary(0x02000000,  1, true));
    --hud.set_offset(16, hud.y-1);
    --hud.to_screen(tostring(hud.game.is_go_mode()));
    hud.to_screen("");
    hud.to_screen("GMD RNG: " .. hud.game.get_string_binary(0x02000E68,  4, true));
    hud.to_screen("GMD Val: " .. hud.game.get_string_binary(0x020094B8,  2, true));
    hud.set_offset( 0, hud.y+1);
    --]]
    hud.to_screen("GMD RNG: " .. hud.game.get_string_binary(0x02000E68,  4, true));
    hud.set_offset(34, hud.y+1);
    hud.display_both_RNG(false, true);
    hud.set_offset( 0, hud.y-6);
    hud.to_screen(string.format("GMD RNG  : 0x%08X", hud.game.get_GMD_RNG()));
    hud.to_screen(string.format("RNG Index: %10s",  (hud.game.get_GMD_RNG_index() or "????")));
    hud.to_screen(string.format("GMD Value: 0x%08X", hud.game.get_GMD_value()));
    hud.to_screen(string.format("GMD Virus: %s", tostring(hud.game.get_GMD_is_virus())));
    hud.to_screen(string.format("GMD Index: %2u",    hud.game.get_GMD_index()));
    hud.to_screen(string.format("GMD 1  XY: 0x%04X 0x%04X",
        hud.game.ram.get.GMD_1_xy(), hud.game.ram.get.GMD_1_yx()));
    hud.to_screen(string.format("GMD 2  XY: 0x%04X 0x%04X",
        hud.game.ram.get.GMD_2_xy(), hud.game.ram.get.GMD_2_yx()));
    hud.reset_xy();
    hud.set_position(2, 17);
    hud.display_steps(true);
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
    hud.to_screen(string.format("Fight:  0x%04X", hud.game.get_battle_pointer()));
    hud.display_both_RNG(false, true);
    hud.to_screen("");
    hud.to_screen(string.format("Checks: %4u", hud.game.get_encounter_checks()));
    hud.to_screen(string.format("%%: %8.3f%%", 100-hud.game.get_current_percent()));
    --hud.to_screen(string.format("Drawfset: %2u", draw_offset));
    hud.display_enemies();
end

local previous_gamble_win = 0;
local function HUD_auto()
    if hud.game.in_title() or hud.game.in_splash() or hud.game.in_transition() then
        hud.display_game_info();
        hud.to_screen(string.format("EnCounter: %3u", total_fights));
        hud.to_screen("");
        display_player_info();
        hud.to_screen("");
        hud.display_both_RNG(true, false);
        hud.display_area();
    elseif hud.game.in_world() then
        if hud.game.in_real_world() then
            hud.set_position(2, 23);
        else
            hud.set_position(2, 17);
        end
        hud.display_both_RNG();
        if hud.game.in_the_internet() then
            hud.to_screen(string.format("GMD Index:  %2u",    hud.game.get_GMD_index()));
        end
        hud.display_steps(true);
        if hud.game.get_sneak() > 0 then
            hud.to_screen(string.format("Sneak: %5u", hud.game.get_sneak()));
        end
        if hud.game.is_gambling() then
            hud.to_screen("");
            hud.to_screen("Gamble  Win: " .. hud.game.get_gamble_panel_win( ));
            hud.to_screen("Gamble Pick: " .. hud.game.get_gamble_panel_pick());
        end
		if hud.game.get_progress() == 0x00 then
            hud.to_screen("");
            hud.to_screen("Style Element: " .. hud.game.get_next_element( ));
        end
        hud.display_area();
    elseif hud.game.in_battle() or hud.game.in_game_over() then
        if hud.game.in_combat() then
            hud.set_position(2, 17);
            hud.to_screen(string.format("Fight:  0x%04X", hud.game.get_battle_pointer()));
            hud.display_both_RNG();
        else
            hud.set_position(2, 25);
            hud.display_draws(9);
            hud.set_offset(8, 0);
            hud.to_screen(string.format("Fight:  0x%04X", hud.game.get_battle_pointer()));
            hud.display_both_RNG();
            hud.to_screen("");
            hud.to_screen(string.format("Escape: %4i", hud.game.find_first(138)));
            hud.to_screen(string.format("Checks: %4u", hud.game.get_encounter_checks()));
            hud.to_screen(string.format("%%: %8.3f%%", 100-hud.game.get_current_percent()));
        end
        hud.display_enemies();
    elseif hud.game.in_menu() then
        hud.display_both_RNG();
        if hud.game.in_menu_folder_edit() then
            display_edit_slots();
            display_selected_chip();
        end
    elseif hud.game.in_shop() then
        hud.set_position(168, 38);
        display_player_info();
    elseif hud.game.in_chip_trader() then
        hud.set_position(130, 1);
        hud.display_both_RNG(false, true);
    elseif hud.game.in_credits() then
        hud.display_game_info();
        gui.text(0, 0, "!blame SJH1UEKA", 0x80FFFFFF, "bottomleft");
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
    hud.game.increase_GMD_index();
end

function hud.Down()
    hud.game.decrease_GMD_index();
end

function hud.B()
    hud.game.randomize_GMD_RNG();
    print(string.format("GMD RNG: 0x%08X", hud.game.get_main_RNG_value()));
end

function hud.update_local_state()
    if hud.game.did_game_state_change() and hud.game.in_battle() then
        total_fights = total_fights + 1;
    end
end

return hud;

