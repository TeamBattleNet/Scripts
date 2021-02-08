-- Common Functions for MMBN scripting, enjoy.

local game = {};

game.ram      = {}; -- overridden later
game.areas    = {}; -- overridden later
game.chips    = {}; -- overridden later
game.enemies  = {}; -- overridden later
game.progress = {}; -- overridden later

---------------------------------------- Game State ----------------------------------------

-- Game Info

function game.get_version_name()
    return game.ram.version_name;
end

function game.get_play_time()
    return game.ram.get.play_time();
end

function game.set_play_time(new_play_time)
    game.ram.set.play_time(new_play_time);
end

function game.get_power_on_frames()
    return game.ram.get.power_on_frames();
end

function game.set_power_on_frames(new_power_on_frames)
    return game.ram.set.power_on_frames(new_power_on_frames);
end

-- Progress

function game.get_progress()
    return game.ram.get.progress();
end

function game.get_progress_name(progress_value)
    return game.progress[progress_value] or "Unknown Progress Value";
end

function game.get_progress_name_current()
    return game.get_progress_name(game.get_progress());
end

function game.is_progress_valid(progress_value)
    return game.progress[progress_value];
end

function game.set_progress(new_progress)
    game.ram.set.progress(new_progress);
end

function game.set_progress_safe(new_progress)
    if game.is_progress_valid(new_progress) then
        game.set_progress(new_progress);
    end
end

-- Menu Mode

game.menu_mode_names = {};
game.menu_mode_names[0x00] = "Folder Select";
game.menu_mode_names[0x04] = "Sub Chips";
game.menu_mode_names[0x08] = "Library";
game.menu_mode_names[0x0C] = "MegaMan";
game.menu_mode_names[0x10] = "E-Mail";
game.menu_mode_names[0x14] = "Key Items";
game.menu_mode_names[0x18] = "Network";
game.menu_mode_names[0x1C] = "Save";
game.menu_mode_names[0x20] = "Folder Edit";

function game.get_menu_mode_name()
    return game.menu_mode_names[game.ram.get.menu_mode()] or "Unknown Menu Mode";
end

function game.in_menu_folder_select()
    return game.ram.get.menu_mode() == 0x00;
end

function game.in_menu_subchips()
    return game.ram.get.menu_mode() == 0x04;
end

function game.in_menu_library()
    return game.ram.get.menu_mode() == 0x08;
end

function game.in_menu_megaman()
    return game.ram.get.menu_mode() == 0x0C;
end

function game.in_menu_email()
    return game.ram.get.menu_mode() == 0x10;
end

function game.in_menu_keyitems()
    return game.ram.get.menu_mode() == 0x14;
end

function game.in_menu_network()
    return game.ram.get.menu_mode() == 0x18;
end

function game.in_menu_save()
    return game.ram.get.menu_mode() == 0x1C;
end

function game.in_menu_folder_edit()
    return game.ram.get.menu_mode() == 0x20;
end

----------------------------------------Battle Information ----------------------------------------

function game.get_battle_pointer()
    return game.ram.get.battle_pointer();
end

function game.get_enemy_ID(which_enemy)
    return game.ram.get.enemy[which_enemy].ID();
end

function game.get_enemy_name(which_enemy)
    return game.enemies.names[game.get_enemy_ID(which_enemy)] or "Unknown Enemy";
end

function game.get_enemy_HP(which_enemy)
    return game.ram.get.enemy[which_enemy].HP();
end

function game.set_enemy_HP(which_enemy, new_HP)
    game.ram.set.enemy[which_enemy].HP(new_HP);
end

function game.kill_enemy(which_enemy)
    if which_enemy == 0 then
        game.set_enemy_HP(1, 0);
        game.set_enemy_HP(2, 0);
        game.set_enemy_HP(3, 0);
    else
        game.set_enemy_HP(which_enemy, 0);
    end
end

function game.set_custom_gauge(new_custom_gauge)
    if new_custom_gauge < 0 then
        new_custom_gauge = 0;
    elseif new_custom_gauge > 0x4000 then
        new_custom_gauge = 0x4000;
    end
    game.ram.set.custom_gauge(new_custom_gauge);
end

function game.empty_custom_gauge()
    game.set_custom_gauge(0x0000);
end

function game.fill_custom_gauge()
    game.set_custom_gauge(0x4000);
end

---------------------------------------- Draw Slots ----------------------------------------

function game.get_draw_slot(which_slot)
    if 1 <= which_slot and which_slot <= 30 then
        return game.ram.get.draw_slot(which_slot-1) + 1; -- convert from 1 to 0 index, then back
    end
    return 0xFF;
end

function game.get_draw_slots()
    local slots = {};
    for i=1,30 do
        slots[i] = game.get_draw_slot(i);
    end
    return slots;
end

function game.get_draw_slots_text_one_line()
    local slots = game.get_draw_slots();
    local main_RNG_index = game.get_main_RNG_index() or "????";
    local slots_text = string.format("%s:", main_RNG_index);
    for i=1,30 do
        slots_text = string.format("%s %02u", slots_text, slots[i]);
    end
    return slots_text;
end

function game.get_draw_slots_text_multi_line()
    local slots = game.get_draw_slots();
    local main_RNG_index = game.get_main_RNG_index() or "????";
    local slots_text = string.format("%s:", main_RNG_index);
    for i=1,30 do
        slots_text = string.format("%s\n%02u: %02u", slots_text, i, slots[i]);
    end
    return slots_text;
end

function game.shuffle_folder_simulate_from_value(starting_main_RNG_value)
    return game.ram.shuffle_folder_simulate_from_value(starting_main_RNG_value);
end

function game.shuffle_folder_simulate_from_index(starting_main_RNG_index)
    return game.ram.shuffle_folder_simulate_from_index(starting_main_RNG_index);
end

function game.draw_in_order()
    for i=0,29 do
        game.ram.set.draw_slot(i, i);
    end
end

function game.draw_only_slot(which_slot)
    for i=0,29 do
        game.ram.set.draw_slot(i, which_slot%30);
    end
end

function game.find_first(chip_ID)
    for i=0,29 do
        if game.ram.get.folder_ID(game.ram.get.draw_slot(i)) == chip_ID then
            return i;
        end
    end
    return 0xFF;
end

function game.draw_slot_check(chip_ID, draw_depth)
    return game.find_first(chip_ID) <= draw_depth;
end

---------------------------------------- Location ----------------------------------------

-- Area

function game.get_main_area()
    return game.ram.get.main_area();
end

function game.get_sub_area()
    return game.ram.get.sub_area();
end

function game.set_main_area(new_main_area)
    game.ram.set.main_area(new_main_area);
end

function game.set_sub_area(new_sub_area)
    game.ram.set.sub_area(new_sub_area);
end

function game.teleport(new_main_area, new_sub_area)
    game.set_main_area(new_main_area);
    game.set_sub_area(new_sub_area);
end

function game.get_area_name(main_area, sub_area)
    if game.areas.names[main_area] then
        if game.areas.names[main_area][sub_area] then
            return game.areas.names[main_area][sub_area];
        end
        return "Unknown Sub Area";
    end
    return "Unknown Main Area";
end

function game.get_area_name_current()
    return game.get_area_name(game.get_main_area(), game.get_sub_area());
end

function game.does_area_exist(main_area, sub_area)
    return game.areas.names[main_area] and game.areas.names[main_area][sub_area];
end

function game.get_area_groups_real()
    return game.areas.real_groups;
end

function game.get_area_groups_digital()
    return game.areas.digital_groups;
end

function game.get_area_group_name(main_area)
    if game.areas.names[main_area] and game.areas.names[main_area].group then
        return game.areas.names[main_area].group;
    end
    return "Unknown Main Area";
end

function game.in_real_world()
    if game.get_main_area() < 0x80 then
        return true;
    end
    return false;
end

function game.in_digital_world()
    return not game.in_real_world();
end

-- Position

function game.get_X()
    return game.ram.get.your_X();
end

function game.get_Y()
    return game.ram.get.your_Y();
end

function game.get_sneak()
    return game.ram.get.sneak();
end

function game.reset_sneak()
    game.ram.set.sneak(6000);
end

function game.get_steps()
    return game.ram.get.steps();
end

function game.set_steps(new_steps)
    if new_steps < 0 then
        new_steps = 0
    elseif new_steps > 0xFFF then
        new_steps = 0xFFF;
    end
    game.ram.set.steps(new_steps);
end

function game.add_steps(some_steps)
    game.set_steps(game.get_steps() + some_steps);
end

function game.get_check()
    return game.ram.get.check();
end

function game.set_check(new_check)
    if new_check < 0 then
        new_check = 0
    elseif new_check > 0xFFF then
        new_check = 0xFFF;
    end
    game.ram.set.check(new_check);
end

function game.add_check(some_check)
    game.set_check(game.get_check() + some_check);
end

function game.get_next_check()
    return 64 - (game.get_steps() - game.get_check());
end

---------------------------------------- Inventory ----------------------------------------

function game.get_zenny()
    return game.ram.get.zenny();
end

function game.set_zenny(new_zenny)
    if new_zenny < 0 then
        new_zenny = 0
    elseif new_zenny > 999999 then
        new_zenny = 999999;
    end
    game.ram.set.zenny(new_zenny);
end

function game.add_zenny(some_zenny)
    game.set_zenny(game.get_zenny() + some_zenny);
end

function game.get_bug_frags()
    return game.ram.get.bug_frags();
end

function game.set_bug_frags(new_bug_frags)
    if new_bug_frags < 0 then
        new_bug_frags = 0
    elseif new_bug_frags > 9999 then
        new_bug_frags = 9999;
    end
    game.ram.set.bug_frags(new_bug_frags);
end

function game.add_bug_frags(some_bug_frags)
    game.set_bug_frags(game.get_bug_frags() + some_bug_frags);
end

---------------------------------------- Battlechips ----------------------------------------

function game.get_chip_name(ID)
    return game.chips.names[ID] or "Unknown Chip ID";
end

function game.get_chip_code(code)
    return game.chips.codes[code] or "?";
end

function game.set_all_folder_ID_to(which_folder, chip_ID)
    for which_chip=0,29 do
        game.ram.set.folder[which_folder].ID(which_chip, chip_ID);
    end
end

function game.randomize_folder_IDs_standard(which_folder)
    for which_chip=0,29 do
        game.ram.set.folder[which_folder].ID(which_chip, game.chips.get_random_ID_standard());
    end
end

function game.randomize_folder_IDs_mega(which_folder)
    for which_chip=0,29 do
        game.ram.set.folder[which_folder].ID(which_chip, game.chips.get_random_ID_mega());
    end
end

function game.randomize_folder_IDs_all_chips(which_folder)
    for which_chip=0,29 do
        game.ram.set.folder[which_folder].ID(which_chip, game.chips.get_random_ID_all_chips());
    end
end

function game.randomize_folder_IDs_anything(which_folder)
    for which_chip=0,29 do
        game.ram.set.folder[which_folder].ID(which_chip, game.chips.get_random_ID_all());
    end
end

function game.set_all_folder_code_to(which_folder, chip_code)
    for which_chip=0,29 do
        game.ram.set.folder[which_folder].code(which_chip, chip_code);
    end
end

function game.randomize_folder_codes(which_folder)
    for which_chip=0,29 do
        game.ram.set.folder[which_folder].code(which_chip, game.chips.get_random_code());
    end
end

function game.get_cursor_offset_folder()
    return game.ram.get.offset_folder();
end

function game.get_cursor_position_folder()
    return game.ram.get.cursor_folder();
end

function game.get_cursor_offset_pack()
    return game.ram.get.offset_pack();
end

function game.get_cursor_position_pack()
    return game.ram.get.cursor_pack();
end

function game.get_cursor_offset_selected()
    return game.ram.get.offset_selected();
end

function game.get_cursor_position_selected()
    return game.ram.get.cursor_selected();
end

---------------------------------------- Routing ----------------------------------------

function game.get_string_binary(address, bytes, with_spaces)
    if address and bytes then
        local binary = "";
        for i=0,bytes-1 do
            local byte = memory.read_u8(address+i);
            for i=0,7 do
                if bit.check(byte, 7-i) then
                    binary = binary .. "1";
                else
                    binary = binary .. "0";
                end
                if i==3 and with_spaces then
                    binary = binary .. " ";
                end
            end
            if with_spaces then
                binary = binary .. " ";
            end
        end
        return binary;
    end
end

function game.get_string_hex(address, bytes, with_spaces)
    if address and bytes then
        local hex = "";
        local format = "%02X";
        if with_spaces then
            format = format .. " ";
        end
        for i=0,bytes-1 do
            hex = hex .. string.format(format, memory.read_u8(address+i));
        end
        return hex;
    end
end

---------------------------------------- Encounter Tracker ----------------------------------------

local area_odds = 1;
local current_odds = 1;
local last_encounter_check = 0;

function game.get_area_percent()
    return area_odds * 100;
end

function game.get_current_percent()
    return current_odds * 100;
end

function game.get_encounter_checks()
    return math.floor(last_encounter_check / 64); -- approximate
end

local function track_encounter_checks()
    if game.in_world() then
        if game.get_check() < last_encounter_check then
            last_encounter_check = 0;
            area_odds = area_odds * (1-current_odds);
            current_odds = 1;
        elseif game.get_check() > last_encounter_check then
            last_encounter_check = game.get_check();
            current_odds = current_odds * (1-game.get_encounter_chance());
        end
    end
    if game.did_area_change() then
        area_odds = 1;
    end
end

function game.get_encounter_threshold()
    local curve_addr = game.ram.addr.encounter_curve;
    local curve_offset = (game.get_main_area() - 0x80) * 0x10 + game.get_sub_area();
    curve = memory.read_u8(curve_addr + curve_offset);
    local odds_addr = game.ram.addr.encounter_odds;
    local test_level = math.min(math.floor(game.get_steps() / 64), 16);
    return memory.read_u8(odds_addr + test_level * 8 + curve);
end

function game.get_encounter_chance()
    return game.get_encounter_threshold() / 32;
end

function game.get_encounter_percent()
    return game.get_encounter_chance() * 100;
end

function game.would_get_encounter()
    return game.get_encounter_threshold() > (game.get_main_RNG_value() % 0x20);
end

---------------------------------------- State Tracking ----------------------------------------

local previous_game_state = 0x00;
function game.did_game_state_change()
    return game.ram.get.game_state() ~= previous_game_state;
end

local previous_battle_state = 0x00;
function game.did_battle_state_change()
    return game.ram.get.battle_state() ~= previous_battle_state;
end

local previous_menu_mode = 0x00;
function game.did_menu_mode_change()
    return game.ram.get.menu_mode() ~= previous_menu_mode;
end

local previous_menu_state = 0x00;
function game.did_menu_state_change()
    return game.ram.get.menu_state() ~= previous_menu_state;
end

local previous_main_area = 0x00;
function game.did_main_area_change()
    return game.ram.get.main_area() ~= previous_main_area;
end

local previous_sub_area = 0x00;
function game.did_sub_area_change()
    return game.ram.get.sub_area() ~= previous_sub_area;
end

function game.did_area_change()
    return game.did_main_area_change() or game.did_sub_area_change();
end

---------------------------------------- Module Controls ----------------------------------------

function game.track_game_state()
    track_encounter_checks();
    previous_game_state   = game.ram.get.game_state();
    previous_battle_state = game.ram.get.battle_state();
    previous_menu_mode    = game.ram.get.menu_mode();
    previous_menu_state   = game.ram.get.menu_state();
    previous_main_area    = game.ram.get.main_area();
    previous_sub_area     = game.ram.get.sub_area();
end

return game;

