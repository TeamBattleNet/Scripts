-- HUD Script for Mega Man Battle Network 3, enjoy.

-- https://drive.google.com/drive/folders/1K2foCnQbJ_bM2ewBhvxVo7JAdSzV1Ecm Did you check The Notes?

local hud = require("All/HUD");

hud.version = hud.version .. ".0.3";

hud.game = require("BN6/Game");

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
    hud.to_screen("Routing HUD: WIP");
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

local function HUD_auto()
    if hud.game.in_title() or hud.game.in_splash() or hud.game.in_transition() then
        hud.display_game_info();
        hud.to_screen("");
        display_player_info();
        hud.display_area();
    elseif hud.game.in_world() then
        if hud.game.in_real_world() then
            hud.set_position(2, 23);
        else
            hud.set_position(2, 17);
        end
        hud.display_both_RNG();
        hud.display_steps(true);
        if hud.game.get_sneak() > 0 then
            hud.to_screen(string.format("Sneak: %5u", hud.game.get_sneak()));
        end
        hud.display_area();
    elseif hud.game.in_battle() or hud.game.in_game_over() then
        if hud.game.did_game_state_change() then
            hud.game.simulate_folder_shuffle()
        end
        if hud.game.in_combat() then
            hud.set_position(2, 17);
            hud.to_screen(string.format("Fight:  0x%04X", hud.game.get_battle_pointer()));
            hud.display_both_RNG();
        else
            hud.set_position(2, 25);
            hud.display_draws(9);
            hud.set_offset(8, 0);
            hud.display_both_RNG();
            hud.to_screen("");
            hud.to_screen(string.format("Run %%: %6.2f%%", hud.game.get_run_chance()));
            --hud.to_screen(string.format("M-Boomer: %4i", hud.game.find_first(138)));
            hud.to_screen(string.format("Checks: %6u", hud.game.get_encounter_checks()));
            hud.to_screen(string.format("%%: %10.3f%%", 100-hud.game.get_current_percent()));
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
    print("\n" .. hud.game.get_folder_text(1));
end

function hud.Down()
    print("\n" .. hud.game.get_draw_slots_text_multi_line());
    print("\n" .. hud.game.get_draw_slots_text_one_line());
end

function hud.B()
    hud.game.randomize_GMD_RNG();
end

function hud.update_local_state()
    if hud.game.did_game_state_change() and hud.game.in_battle() then
        total_fights = total_fights + 1;
    end
end

return hud;

