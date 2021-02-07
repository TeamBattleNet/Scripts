-- HUD Script for Mega Man Battle Network 2, enjoy.

-- https://drive.google.com/drive/folders/1Vu4Ze91RP95ndYBsTznmGwKgxk_wKt81 Did you check The Notes?

local hud = require("All/HUD");

hud.version = hud.version .. ".0.0";

hud.game = require("BN2/Game");

---------------------------------------- Display Functions ----------------------------------------

local function display_RNG(and_value)
    if and_value then
        hud.to_screen(string.format("RNG: %08X", hud.game.get_main_RNG_value()));
    end
    hud.to_screen(string.format("Index: %5s", (hud.game.get_main_RNG_index() or "?????")));
    hud.to_screen(string.format("Delta: %5s", (hud.game.get_main_RNG_delta() or     "?")));
end

local function display_steps()
    if hud.game.in_digital_world() then
        hud.to_screen(string.format("Steps: %4u" , hud.game.get_steps()));
        hud.to_screen(string.format("Check: %4u" , hud.game.get_check()));
        hud.to_screen(string.format("Checks: %3u", hud.game.get_encounter_checks()));
        --hud.to_screen(string.format("%%: %7.3f%%", hud.game.get_encounter_chance()));
        hud.to_screen(string.format("Next: %2i"  , hud.game.get_next_check()));
    end
    hud.to_screen(string.format("X: %5i", hud.game.get_X()));
    hud.to_screen(string.format("Y: %5i", hud.game.get_Y()));
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
    hud.to_screen(string.format("Max  HP: %6u", hud.game.calculate_max_HP()));
    hud.to_screen(string.format("Library: %6u", hud.game.count_library()));
    hud.to_screen(string.format("Level  : %6u", hud.game.calculate_mega_level()));
end

local function display_game_info()
    hud.to_screen(string.format("Progress: 0x%02X %s", hud.game.get_progress(), hud.game.get_progress_name_current()));
    hud.to_screen("Game Version: " .. hud.game.get_version_name());
    hud.to_screen("HUD  Version: " .. hud.version);
end

---------------------------------------- HUD Modes ----------------------------------------

local function HUD_speedrun()
    hud.to_screen(string.format("Progress: 0x%02X %s", hud.game.get_progress(), hud.game.get_progress_name_current()));
    if hud.game.in_battle() or hud.game.in_game_over() then
        display_draws(10);
        hud.x=6;
        hud.y=1;
        hud.to_screen(string.format(" Escape:   %2i", hud.game.find_first(82)));
        hud.to_screen(string.format(" Quake3:   %2i", hud.game.find_first(24)));
        hud.to_screen(string.format(" Index: %5s", (hud.game.get_main_RNG_index() or "?????")));
        hud.to_screen(string.format(" Delta: %2s", (hud.game.get_main_RNG_delta() or     "?")));
        hud.to_screen(string.format(" Check: %2u", hud.game.get_encounter_checks()));
        display_enemies();
    elseif hud.game.in_credits() then
        gui.text(0, 0, "t r o u t", 0x10000000, "bottomright");
    else
        if hud.game.in_title() or hud.game.in_splash() or hud.game.in_transition() then
            hud.to_screen("Game : " .. hud.game.get_version_name());
            hud.to_screen("HUD  : " .. hud.version);
            hud.to_screen(string.format("Chips: %2u", hud.game.count_library()));
            hud.to_screen(string.format("Level: %2u", hud.game.calculate_mega_level()));
        elseif hud.game.in_menu() then
            hud.to_screen(string.format("Chips: %2u", hud.game.count_library()));
            hud.to_screen(string.format("Level: %2u", hud.game.calculate_mega_level()));
            hud.to_screen(string.format("X: %4i", hud.game.get_X()));
            hud.to_screen(string.format("Y: %4i", hud.game.get_Y()));
            display_edit_slots();
        else
            if hud.game.in_digital_world() then
                hud.to_screen(string.format("Steps: %4u" , hud.game.get_steps()));
                hud.to_screen(string.format("Check: %4u" , hud.game.get_check()));
                hud.to_screen(string.format("Checks: %3u", hud.game.get_encounter_checks()));
                --hud.to_screen(string.format("%%: %7.3f%%", hud.game.get_encounter_chance()));
                hud.to_screen(string.format("Next:  %2i"  , hud.game.get_next_check()));
                hud.to_screen(string.format("X: %4i", hud.game.get_X()));
                hud.to_screen(string.format("Y: %4i", hud.game.get_Y()));
                hud.x=11;
                hud.y=1;
                hud.to_screen(string.format(" Index: %5s", (hud.game.get_main_RNG_index() or "?????")));
                hud.to_screen(string.format(" Delta: %2s", (hud.game.get_main_RNG_delta() or     "?")));
                hud.to_screen(string.format(" Chips: %2u", hud.game.count_library()));
                hud.to_screen(string.format(" Level: %2u", hud.game.calculate_mega_level()));
            else
                hud.to_screen(string.format("Index: %5s", (hud.game.get_main_RNG_index() or "?????")));
                hud.to_screen(string.format("Delta: %2s", (hud.game.get_main_RNG_delta() or     "?")));
                hud.to_screen(string.format("Chips: %2u", hud.game.count_library()));
                hud.to_screen(string.format("Level: %2u", hud.game.calculate_mega_level()));
                hud.to_screen(string.format("X: %4i", hud.game.get_X()));
                hud.to_screen(string.format("Y: %4i", hud.game.get_Y()));
                if hud.game.near_number_doors() then
                    hud.to_screen(string.format("Door: %2u", hud.game.get_door_code()));
                end
            end
        end
        hud.y=0;
        hud.to_bottom_right(hud.game.get_area_name_current());
    end
end

local function HUD_routing()
    hud.to_screen("0000: " .. hud.game.get_string_hex(0x02000000, 16, true));
    hud.to_screen("0010: " .. hud.game.get_string_hex(0x02000010, 16, true));
    hud.to_screen("0000: " .. hud.game.get_string_binary(0x02000000, 4, true));
    hud.to_screen("0004: " .. hud.game.get_string_binary(0x02000004, 4, true));
    hud.to_screen("0008: " .. hud.game.get_string_binary(0x02000008, 4, true));
    hud.to_screen("000C: " .. hud.game.get_string_binary(0x0200000C, 4, true));
    hud.to_screen("01FC: " .. hud.game.get_string_hex(0x020001FC, 8, true));
end

local function HUD_battle()
    display_draws(10);
    hud.x=7;
    hud.y=0;
    display_draws(10, 11);
    hud.x=14;
    hud.y=0;
    display_draws(10, 21);
    hud.x=21;
    hud.y=0;
    hud.to_screen(string.format("Fight: 0x%4X", hud.game.get_battle_pointer()));
    display_RNG(true);
    hud.to_screen(string.format("Checks: %2u", hud.game.get_encounter_checks()));
    hud.y=0;
    hud.to_bottom_right(hud.game.get_enemy_name(1));
    hud.to_bottom_right(hud.game.get_enemy_name(2));
    hud.to_bottom_right(hud.game.get_enemy_name(3));
end

local function HUD_auto()
    if hud.game.in_title() or hud.game.in_splash() then
        display_game_info();
        hud.to_screen("");
        display_player_info();
        hud.y=0;
        hud.to_bottom_right(hud.game.get_area_name_current());
    elseif hud.game.in_world() then
        display_RNG();
        display_steps();
        hud.y=0;
        hud.to_bottom_right(hud.game.get_area_name_current());
    elseif hud.game.in_battle() or hud.game.in_game_over() then
        display_draws(10);
        hud.x=7;
        hud.y=0;
        hud.to_screen(string.format("State: %6s", hud.game.get_battle_state_name()));
        hud.to_screen(string.format("Fight: 0x%4X", hud.game.get_battle_pointer()));
        display_RNG(true);
        hud.to_screen(string.format("Checks: %2u", hud.game.get_encounter_checks()));
        display_enemies();
    elseif hud.game.in_transition() then
        hud.to_screen("HUD Version: " .. hud.version);
    elseif hud.game.in_menu() then
        if hud.game.in_menu_folder_edit() then
            display_edit_slots();
        else
            display_RNG();
        end
    elseif hud.game.in_shop() then
        display_player_info();
    elseif hud.game.in_chip_trader() then
        display_RNG(true);
    elseif hud.game.in_credits() then
        gui.text(0, 0, "t r o u t", 0x10000000, "bottomright");
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

function hud.B()
    print("\n" .. hud.game.get_draw_slots_text_multi_line());
    print("\n" .. hud.game.get_draw_slots_text_one_line());
end

return hud;

