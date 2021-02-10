-- HUD Script for Mega Man Battle Network 1, enjoy.

-- https://drive.google.com/drive/folders/12gEE4GsmFHosuPn5NkOEHnK0TR3EfO9y Did you check The Notes?

local hud = require("All/HUD");

hud.version = hud.version .. ".0.1";

hud.game = require("BN1/Game");

---------------------------------------- Display Functions ----------------------------------------

local function display_player_info()
    hud.to_screen(string.format("Zenny  : %6u", hud.game.get_zenny()));
    hud.to_screen(string.format("Max  HP: %6u", hud.game.calculate_max_HP()));
    hud.to_screen(string.format("Library: %6u", hud.game.count_library()));
    hud.to_screen(string.format("Level  : %6u", hud.game.calculate_mega_level()));
end

function hud.display_draw_codes()
    for i=1,math.min(hud.game.ram.get.chip_window_size(), 15) do
        hud.to_pixel(16+16*((i-1)%5), 105+(16*math.floor((i-1)/5)), hud.game.get_draw_slot_code_name(i));
    end
end

local function display_shop_menu_slots()
    if true or settings.use_gui_text then
        for i=1,4 do
            hud.to_pixel(9, 9+16*i, string.format("%2i", hud.game.get_shop_cursor_offset()+i));
        end
    end
end

local function display_edit_slots()
    if hud.game.in_folder() then
        for i=1,7 do
            hud.to_pixel(110, 24+16*i, string.format("%2i", hud.game.get_cursor_offset_folder()+i));
        end
    elseif hud.game.in_pack() then
        for i=1,7 do
            hud.to_pixel(13, 24+16*i, string.format("%3i", hud.game.get_cursor_offset_pack()+i));
        end
    end
end

local function display_selected_chip()
    if hud.game.is_chip_selected() then
        local location = hud.game.get_selected_chip_location_name();
        local slot = hud.game.get_cursor_offset_selected() + hud.game.get_cursor_position_selected() + 1;
        local selected_ID = hud.game.get_selected_ID();
        local selected_name = hud.game.get_chip_name(selected_ID);
        local selected_code = hud.game.get_chip_code(hud.game.get_selected_code());
        if hud.game.in_folder() then
            hud.to_pixel(161, 18, string.format("In %6s %3i:", location, slot));
            hud.to_pixel(161, 27, string.format("%3i %8s %s", selected_ID, selected_name, selected_code));
        elseif hud.game.in_pack() then
            hud.to_pixel(65, 18, string.format("In %6s %3i:", location, slot));
            hud.to_pixel(65, 27, string.format("%3i %8s %s", selected_ID, selected_name, selected_code));
        end
    end
end

---------------------------------------- HUD Modes ----------------------------------------

local function HUD_speedrun()
    hud.to_screen(string.format("Progress: 0x%02X %s", hud.game.get_progress(), hud.game.get_progress_name_current()));
    if hud.game.in_battle() or hud.game.in_game_over() then
        hud.display_draws(10);
        hud.x=6;
        hud.y=1;
        hud.to_screen(string.format(" Escape:  %3i", hud.game.find_first(82)));
        hud.to_screen(string.format(" Quake3:  %3i", hud.game.find_first(24)));
        hud.to_screen(string.format(" Index: %5s", (hud.game.get_main_RNG_index() or "?????")));
        hud.to_screen(string.format(" Delta: %2s", (hud.game.get_main_RNG_delta() or     "?")));
        hud.to_screen(string.format(" Check: %2u", hud.game.get_encounter_checks()));
        hud.display_enemies();
    else
        if hud.game.in_title() or hud.game.in_splash() or hud.game.in_transition() then
            hud.to_screen("Game : " .. hud.game.get_version_name());
            hud.to_screen("HUD  : " .. hud.version);
            hud.to_screen(string.format("Chips: %2u", hud.game.count_library()));
            hud.to_screen(string.format("Level: %2u", hud.game.calculate_mega_level()));
        elseif hud.game.in_menu() then
            if hud.game.in_menu_folder_edit() then
                display_edit_slots();
                display_selected_chip();
            else
                hud.to_screen(string.format("Chips: %2u", hud.game.count_library()));
                hud.to_screen(string.format("Level: %2u", hud.game.calculate_mega_level()));
                hud.to_screen(string.format("X: %4i", hud.game.get_X()));
                hud.to_screen(string.format("Y: %4i", hud.game.get_Y()));
            end
        else
            if hud.game.in_digital_world() then
                hud.to_screen(string.format("Steps: %4u" , hud.game.get_steps()));
                hud.to_screen(string.format("Check: %4u" , hud.game.get_check()));
                hud.to_screen(string.format("Checks: %3u", hud.game.get_encounter_checks()));
                hud.to_screen(string.format("A%%:%7.3f%%", hud.game.get_area_percent()));
                hud.to_screen(string.format("C%%:%7.3f%%", hud.game.get_current_percent()));
                hud.to_screen(string.format("N%%:%7.3f%%", hud.game.get_encounter_percent()));
                hud.to_screen(string.format("Next:  %2i"  , hud.game.get_next_check()));
                if hud.game.near_number_doors() then
                    hud.to_screen(string.format("Door: %3u", hud.game.get_door_code()));
                end
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
        hud.display_area();
    end
end

local function HUD_routing()
    hud.set_center(54, 2);
    hud.to_screen("0000: " .. hud.game.get_string_hex(   0x02000000, 16, true));
    hud.to_screen("0010: " .. hud.game.get_string_hex(   0x02000010, 16, true));
    hud.to_screen("0000: " .. hud.game.get_string_binary(0x02000000,  4, true));
    hud.to_screen("0004: " .. hud.game.get_string_binary(0x02000004,  4, true));
    hud.to_screen("0008: " .. hud.game.get_string_binary(0x02000008,  4, true));
    hud.to_screen("000C: " .. hud.game.get_string_binary(0x0200000C,  4, true));
    hud.to_screen("01FC: " .. hud.game.get_string_hex(   0x020001FC,  8, true));
    hud.set_offset(31, hud.y-1);
    hud.to_screen(tostring(hud.game.is_go_mode()));
end

local draw_offset = 0;
local function HUD_battle()
    hud.set_position(1, 17);
    hud.set_offset(  0,  0);
    hud.display_draws ( 10,  1);
    hud.set_offset(  8,  0);
    hud.display_draws ( 10, 11);
    hud.set_offset( 16,  0);
    hud.display_draws ( 10, 21);
    hud.set_offset( 24,  0);
    hud.to_screen(string.format("Fight: 0x%4X", hud.game.get_battle_pointer()));
    hud.display_RNG(true);
    hud.to_screen(string.format("Checks: %4u", hud.game.get_encounter_checks()));
    hud.to_screen(string.format("%%: %8.3f%%", 100-hud.game.get_current_percent()));
    --hud.to_screen(string.format("Drawfset: %2u", draw_offset));
    if hud.game.in_chip_select() then
        hud.display_draw_codes();
    end
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
        end
        hud.display_RNG();
        hud.display_steps(true);
        if hud.game.near_number_doors() then
            hud.to_screen(string.format("Door: %2u", hud.game.get_door_code()));
        end
        hud.display_area();
    elseif hud.game.in_battle() or hud.game.in_game_over() then
        hud.set_position(1, 17);
        if not hud.game.in_combat() then
            hud.display_draws(10);
            if hud.game.in_chip_select() then
                hud.display_draw_codes();
            end
            hud.set_offset(8, 0);
        end
        hud.to_screen(string.format("Fight: 0x%4X", hud.game.get_battle_pointer()));
        hud.display_RNG(true);
        hud.to_screen(string.format("Escape: %4i", hud.game.find_first(82)));
        hud.to_screen(string.format("Checks: %4u", hud.game.get_encounter_checks()));
        hud.to_screen(string.format("%%: %8.3f%%", 100-hud.game.get_current_percent()));
        hud.display_enemies();
    elseif hud.game.in_menu() then
        if hud.game.in_menu_folder_edit() then
            display_edit_slots();
            display_selected_chip();
        else
            hud.display_RNG();
        end
    elseif hud.game.in_shop() then
        hud.set_position(170, 34);
        display_player_info();
        display_shop_menu_slots();
    elseif hud.game.in_chip_trader() then
        hud.set_position(105, 1);
        hud.display_RNG(true);
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
    -- should be overridden per game
end

function hud.Down()
    -- should be overridden per game
end

function hud.B()
    print("\n" .. hud.game.get_draw_slots_text_multi_line());
    print("\n" .. hud.game.get_draw_slots_text_one_line());
end

function hud.update_local_state()
    -- for tracking game specific HUD values over time
end

return hud;

