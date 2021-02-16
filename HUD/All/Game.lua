-- Common Functions for MMBN scripting, enjoy.

local game = {};

game.ram      = {}; -- overridden later
game.areas    = {}; -- overridden later
game.chips    = {}; -- overridden later
game.enemies  = {}; -- overridden later
game.progress = {}; -- overridden later

---------------------------------------- RNG Wrapper ----------------------------------------

-- Main RNG

function game.get_main_RNG_value()
    return game.ram.get.main_RNG_value();
end

function game.set_main_RNG_value(new_value)
    game.ram.set.main_RNG_value(new_value);
end

function game.get_main_RNG_index()
    return game.ram.get.main_RNG_index();
end

function game.set_main_RNG_index(new_index)
    game.ram.set.main_RNG_index(new_index);
end

function game.reset_main_RNG()
    game.set_main_RNG_index(1);
end

function game.get_main_RNG_delta()
    return game.ram.get.main_RNG_delta();
end

function game.adjust_main_RNG(steps)
    game.ram.adjust_main_RNG(steps);
end

-- Lazy RNG

function game.get_lazy_RNG_value()
    return game.ram.get.lazy_RNG_value();
end

function game.set_lazy_RNG_value(new_value)
    game.ram.set.lazy_RNG_value(new_value);
end

function game.get_lazy_RNG_index()
    return game.ram.get.lazy_RNG_index();
end

function game.set_lazy_RNG_index(new_index)
    game.ram.set.lazy_RNG_index(new_index);
end

function game.reset_lazy_RNG()
    game.set_lazy_RNG_index(1);
end

function game.get_lazy_RNG_delta()
    return game.ram.get.lazy_RNG_delta();
end

function game.adjust_lazy_RNG(steps)
    game.ram.adjust_lazy_RNG(steps);
end

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

-- Game Mode

game.state = { title=0x00 }; -- defined per game

function game.in_title()
    return game.ram.get.game_state() == game.state.title;
end

function game.in_world()
    return game.ram.get.game_state() == game.state.world;
end

function game.in_battle()
    return game.ram.get.game_state() == game.state.battle;
end

function game.in_transition()
    return game.ram.get.game_state() == game.state.transition;
end

function game.in_splash()
    return (game.ram.get.game_state() == game.state.splash or game.ram.get.game_state() == game.state.splash_pal);
end

function game.in_menu()
    return game.ram.get.game_state() == game.state.menu;
end

function game.in_shop()
    return game.ram.get.game_state() == game.state.shop;
end

function game.in_game_over()
    return game.ram.get.game_state() == game.state.game_over;
end

function game.in_chip_trader()
    return game.ram.get.game_state() == game.state.chip_trader;
end

function game.in_request_board()
    return game.ram.get.game_state() == game.state.request_board;
end

function game.in_loading_navicust()
    return game.ram.get.game_state() == game.state.load_navicust;
end

function game.in_credits()
    return game.ram.get.game_state() == game.state.credits;
end

-- Menu Mode

game.menu = {}; -- defined per game

function game.in_menu_folder_select()
    return game.ram.get.menu_mode() == game.menu.folder_select;
end

function game.in_menu_subchips()
    return game.ram.get.menu_mode() == game.menu.subchips;
end

function game.in_menu_library()
    return game.ram.get.menu_mode() == game.menu.library;
end

function game.in_menu_megaman()
    return game.ram.get.menu_mode() == game.menu.megaman;
end

function game.in_menu_email()
    return game.ram.get.menu_mode() == game.menu.email;
end

function game.in_menu_keyitems()
    return game.ram.get.menu_mode() == game.menu.key_items;
end

function game.in_menu_network()
    return game.ram.get.menu_mode() == game.menu.network;
end

function game.in_menu_save()
    return game.ram.get.menu_mode() == game.menu.save;
end

function game.in_menu_navicust()
    return game.ram.get.menu_mode() == game.menu.navicust;
end

function game.in_menu_folder_edit()
    return game.ram.get.menu_mode() == game.menu.folder_edit;
end

function game.in_menu_folder()
    return (game.in_menu_folder_select() or game.in_menu_folder_edit());
end

-- State Names (skip 2 bits, add 1)

game.game_state_names = {};
function game.get_game_state_name()
    return game.game_state_names[game.ram.get.game_state()] or "Unknown Game State";
end

game.battle_mode_names = {};
function game.get_battle_mode_name()
    return game.battle_mode_names[game.ram.get.battle_mode()] or "Unknown Battle Mode";
end

game.battle_state_names = {};
function game.get_battle_state_name()
    return game.battle_state_names[game.ram.get.battle_state()] or "Unknown Battle State";
end

game.menu_mode_names = {};
function game.get_menu_mode_name()
    return game.menu_mode_names[game.ram.get.menu_mode()] or "Unknown Menu Mode";
end

game.menu_state_names = {};
function game.get_menu_state_name()
    return game.game.menu_state_names[game.ram.get.menu_state()] or "Unknown Menu State";
end

-- Style Info

game.styles = {"Guts", "Cust", "Team", "Shld", "Grnd", "Shdw", "Bug"};
game.style_names = {};
game.style_names[0x00] = "Norm"; -- 000b
game.style_names[0x01] = "Guts"; -- 001b
game.style_names[0x02] = "Cust"; -- 010b
game.style_names[0x03] = "Team"; -- 011b
game.style_names[0x04] = "Shld"; -- 100b
game.style_names[0x05] = "Grnd"; -- 101b HubStyle in BN 2
game.style_names[0x06] = "Shdw"; -- 110b looks cursed in BN 2
game.style_names[0x07] = "Bug";  -- 111b looks cursed in BN 2

function game.get_style_name(style)
    return game.style_names[style] or "????";
end

game.elements = {"Elec", "Heat", "Aqua", "Wood"};
game.element_names = {}; -- FWEG but Elec is first
game.element_names[0x00] = "None"; -- 000b looks like wood
game.element_names[0x01] = "Elec"; -- 001b
game.element_names[0x02] = "Heat"; -- 010b
game.element_names[0x03] = "Aqua"; -- 011b
game.element_names[0x04] = "Wood"; -- 100b
game.element_names[0x05] = "Shok"; -- 101b looks like elec, weak to normal, no charge shot
game.element_names[0x06] = "Haet"; -- 110b looks like heat, weak to normal, charge shot crashes game
game.element_names[0x07] = "Agua"; -- 111b looks like aqua, takes 62x damage, no charge shot

function game.get_element_name(element)
    return game.element_names[element] or "????";
end

---------------------------------------- Battle Information ----------------------------------------

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

function game.shuffle_folder_simulate_from_value(starting_RNG_value, swaps)
    return game.ram.shuffle_folder_simulate_from_value(starting_RNG_value, swaps);
end

function game.shuffle_folder_simulate_from_main_index(index, swaps)
    return game.ram.shuffle_folder_simulate_from_main_index(index, swaps);
end

function game.shuffle_folder_simulate_from_lazy_index(index, swaps)
    return game.ram.shuffle_folder_simulate_from_lazy_index(index, swaps);
end

function game.draw_in_order()
    for i=0,29 do
        game.ram.set.draw_slot(i, i);
    end
end

function game.draw_in_reverse()
    for i=0,29 do
        game.ram.set.draw_slot(i, 29-i);
    end
end

function game.draw_only_slot(which_slot)
    for i=0,29 do
        game.ram.set.draw_slot(i, which_slot%30);
    end
end

function game.find_first(chip_ID)
    for i=0,29 do
        if game.ram.get.folder[1].ID(game.ram.get.draw_slot(i)) == chip_ID then
            return i+1;
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

function game.in_the_internet()
    return (bit.band(game.get_main_area(), 0x90) == 0x90);
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

----------------------------------------Mega Modifications ----------------------------------------

function game.set_buster_stats(power_level)
    game.ram.set.buster_attack(power_level);
    game.ram.set.buster_rapid (power_level);
    game.ram.set.buster_charge(power_level);
end

function game.reset_buster_stats()
    game.set_buster_stats(0);
end

function game.max_buster_stats()
    game.set_buster_stats(4);
end

function game.get_HPMemory_count()
    return game.ram.get.HPMemory();
end

function game.calculate_max_HP()
    return 100 + (20 * game.get_HPMemory_count());
end

function game.calculate_mega_level()
    return 1; -- defined per game
end

---------------------------------------- Battlechips ----------------------------------------

function game.get_chip_name(ID)
    return game.chips.names[ID] or "Unknown Chip ID";
end

function game.get_chip_code(code)
    return game.chips.codes[code] or "?";
end

function game.get_folder_text(which_folder)
    local folder_text = "";
    for which_slot=0,29 do
        local ID   = game.ram.get.folder[which_folder].ID  (which_slot);
        local code = game.ram.get.folder[which_folder].code(which_slot);
        folder_text = string.format("%s{ ID=%3u; code=%2u }; -- %s %s\n", folder_text, ID, code, game.get_chip_name(ID), game.get_chip_code(code));
    end
    return folder_text;
end

function game.overwrite_folder_to(which_folder, chips)
    for which_slot,chip in pairs(chips) do
        game.ram.set.folder[which_folder].ID  (which_slot-1, chip.ID  );
        game.ram.set.folder[which_folder].code(which_slot-1, chip.code);
    end
end

function game.set_all_folder_ID_to(which_folder, chip_ID)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].ID(which_slot, chip_ID);
    end
end

function game.randomize_folder_IDs_standard(which_folder)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].ID(which_slot, game.chips.get_random_ID_standard());
    end
end

function game.randomize_folder_IDs_mega(which_folder)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].ID(which_slot, game.chips.get_random_ID_mega());
    end
end

function game.randomize_folder_IDs_all_chips(which_folder)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].ID(which_slot, game.chips.get_random_ID_all_chips());
    end
end

function game.randomize_folder_IDs_PAs(which_folder)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].ID(which_slot, game.chips.get_random_ID_PA());
    end
end

function game.randomize_folder_IDs_anything(which_folder)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].ID(which_slot, game.chips.get_random_ID_all());
    end
end

function game.set_all_folder_code_to(which_folder, chip_code)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].code(which_slot, chip_code);
    end
end

function game.randomize_folder_codes(which_folder)
    for which_slot=0,29 do
        game.ram.set.folder[which_folder].code(which_slot, game.chips.get_random_code());
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

function game.bit_counter(byte)
    local count = 0;
    for i=0,7 do
        if bit.check(byte, i) then
            count = count + 1;
        end
    end
    return count;
end

function game.byte_to_binary(byte, with_spaces)
    local bit_string = "";
    for i=0,7 do
        if bit.check(byte, 7-i) then
            bit_string = bit_string .. "1";
        else
            bit_string = bit_string .. "0";
        end
        if i==3 and with_spaces then
            bit_string = bit_string .. " ";
        end
    end
    if with_spaces then
        bit_string = bit_string .. " ";
    end
    return bit_string;
end

function game.get_string_binary(address, bytes, with_spaces)
    if address and bytes then
        local bit_string = "";
        for i=0,bytes-1 do
            bit_string = bit_string .. game.byte_to_binary(memory.read_u8(address+i), with_spaces);
        end
        return bit_string;
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

function game.is_sneakrun_bugged()
    return false; -- overridden per game
end

local function track_encounter_checks()
    if game.did_area_change() then
        area_odds = area_odds * current_odds;
        if area_odds < 1 then
            print(string.format("\nArea Odds Were: %7.3f%%", game.get_area_percent()));
            print(string.format("Inverted  Odds: %7.3f%%", 100-game.get_area_percent()));
        end
    end
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

function game.get_encounter_curve()
    local curve_addr = game.ram.addr.encounter_curve;
    local curve_offset = (game.get_main_area() - 0x80) * 0x10 + game.get_sub_area();
    return memory.read_u8(curve_addr + curve_offset); -- 7 for areas with no viruses
end

function game.get_encounter_threshold()
    local curve = game.get_encounter_curve();
    if curve ~= 7 and game.is_sneakrun_bugged() then curve = 0; end
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
    return game.get_encounter_threshold() > (game.get_main_RNG_value() % 0x20); -- (1C is 87.5%)
end

--[[
    Example Encounter Curves (BN 3):
    #: 00 01 02 03 04 05 06 07 - step
    ---------------------------------
    0: 00 00 00 00 00 00 00 00 -    0
    1: 00 00 00 00 00 00 00 00 -   64
    2: 01 00 00 00 00 00 00 00 -  128
    3: 02 01 00 00 00 00 00 00 -  192
    4: 03 02 01 00 00 00 00 00 -  256
    5: 04 03 02 01 00 00 00 00 -  320
    6: 05 04 03 02 01 00 00 00 -  384
    7: 06 05 04 03 02 00 00 00 -  448
    8: 08 06 05 04 03 01 00 00 -  512
    9: 0A 08 06 05 04 02 00 00 -  576
    A: 0C 0A 08 06 05 03 00 00 -  640
    B: 0E 0C 0A 08 06 04 00 00 -  704
    C: 10 0E 0C 0A 08 05 00 00 -  768
    D: 12 10 0E 0C 0A 06 00 00 -  832
    E: 14 12 10 0E 0C 08 02 00 -  896
    F: 1A 14 12 10 0E 0A 06 00 -  960
    G: 1C 1A 14 12 10 0C 0C 00 - 1024
--]]

---------------------------------------- Flags ----------------------------------------

function game.get_magic_addr()
    return bit.band(game.ram.addr.magic_byte, 0xFFFFFF);
end

function game.get_magic_byte()
    return game.ram.get.magic_byte();
end

function game.set_magic_byte(new_magic)
    game.ram.set.magic_byte(new_magic);
end

---------------------------------------- State Tracking ----------------------------------------

local previous_progress = 0x00;
function game.did_progress_change()
    return game.get_progress() ~= previous_progress;
end

local previous_magic_byte = 0x00;
function game.did_magic_byte_change()
    return game.ram.get.magic_byte() ~= previous_magic_byte;
end

local previous_game_state = 0x00;
function game.did_game_state_change()
    return game.ram.get.game_state() ~= previous_game_state;
end

function game.did_leave_title_screen()
    return (game.did_game_state_change() and previous_game_state == 0x00);
end

local previous_battle_state = 0x00;
function game.did_battle_state_change()
    return game.ram.get.battle_state() ~= previous_battle_state;
end

local previous_battle_pointer = 0x00;
function game.did_load_new_battle()
    return (game.ram.get.battle_pointer() ~= previous_battle_pointer and game.ram.get.battle_pointer() ~= 0x00);
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
    return (game.did_main_area_change() or game.did_sub_area_change());
end

---------------------------------------- Miscellaneous ----------------------------------------

function game.broadcast(message)
    print(message);
    gui.addmessage(message);
end

function game.randomize_color_palette()
    for offset=0,0x3FF do -- 1024 bytes
        game.ram.set.color_palette(offset, math.random(0x00, 0xFF));
    end
end

function game.get_progress_change()
    return string.format("Progress changed from 0x%02X to 0x%02X - %s", previous_progress, game.get_progress(), game.get_progress_name_current());
end

function game.broadcast_magic_byte()
    print("");
    game.broadcast(string.format("MAGIC BYTE 0x%02X changed from  0x%02X     to  0x%02X    !", game.get_magic_addr(), previous_magic_byte, game.get_magic_byte()));
    game.broadcast(string.format("MAGIC BYTE 0x%02X changed from %sb to %sb!", game.get_magic_addr(), game.byte_to_binary(previous_magic_byte), game.byte_to_binary(game.get_magic_byte())));
    print("");
end

---------------------------------------- Module Controls ----------------------------------------

function game.pre_update(options)
    -- should be overridden per game
end

function game.post_update(options)
    -- should be overridden per game
end

game.doit_later = {};

function game.track_game_state()
    track_encounter_checks();
    previous_progress       = game.ram.get.progress();
    previous_magic_byte     = game.ram.get.magic_byte();
    previous_game_state     = game.ram.get.game_state();
    previous_battle_state   = game.ram.get.battle_state();
    previous_battle_pointer = game.ram.get.battle_pointer();
    previous_menu_mode      = game.ram.get.menu_mode();
    previous_menu_state     = game.ram.get.menu_state();
    previous_main_area      = game.ram.get.main_area();
    previous_sub_area       = game.ram.get.sub_area();
    if  game.doit_later[emu.framecount()] then
        game.doit_later[emu.framecount()]();
        game.doit_later[emu.framecount()] = nil;
    end
    if game.in_credits() then gui.text(0, 0, "t r o u t", 0x10000000, "bottomright"); end
end

return game;

