-- Functions for MMBN 1 scripting, enjoy.

local game = {};

game.areas    = require("BN1/Areas"   );
game.chips    = require("BN1/Chips"   );
game.enemies  = require("BN1/Enemies" );
game.progress = require("BN1/Progress");
game.ram      = require("BN1/RAM"     );

---------------------------------------- Fun Flags ----------------------------------------

local no_chip_cooldown = false;

function game.enable_chip_cooldown()
    no_chip_cooldown = false;
end

function game.disable_chip_cooldown()
    no_chip_cooldown = true;
end

---------------------------------------- Game State ----------------------------------------

function game.get_version_name()
    return game.ram.version_name;
end

function game.get_play_time()
    return game.ram.get.play_time();
end

function game.set_play_time(new_play_time)
    game.ram.set.play_time(new_play_time);
end

game.game_state_names       = {};
game.game_state_names[0x00] = "title";         -- or BIOS
game.game_state_names[0x04] = "world";         -- real and digital
game.game_state_names[0x08] = "battle";
game.game_state_names[0x0C] = "player_change"; -- jack-in / out
game.game_state_names[0x10] = "demo_end";      -- what is this?
game.game_state_names[0x14] = "capcom_logo";
game.game_state_names[0x18] = "menu";
game.game_state_names[0x1C] = "shop";
game.game_state_names[0x20] = "game_over";
game.game_state_names[0x24] = "trader";
game.game_state_names[0x28] = "credits";
game.game_state_names[0x2C] = "ubisoft_logo";  -- PAL only
game.game_state_previous = 0x00;

function game.get_game_state()
    return game.ram.get.game_state();
end

function game.get_game_state_name()
    return game.game_state_names[game.get_game_state()] or "unknown_game_state";
end

function game.game_state_changed()
    return game.get_game_state() ~= game.game_state_previous;
end

game.battle_state_names       = {};
game.battle_state_names[0x00] = "loading";
game.battle_state_names[0x04] = "busy";
game.battle_state_names[0x08] = "transition";
game.battle_state_names[0x0C] = "combat";
game.battle_state_names[0x10] = "PAUSE";
game.battle_state_names[0x14] = "time_stop";
game.battle_state_names[0x18] = "opening_custom";
game.battle_state_previous = 0x00;

function game.get_battle_state()
    return game.ram.get.battle_state();
end

function game.get_battle_state_name()
    return game.battle_state_names[game.get_battle_state()] or "unknown_battle_state";
end

function game.battle_state_changed()
    return game.get_battle_state() ~= game.battle_state_previous;
end

function game.battle_pause()
    if game.get_battle_state() == 0x0C then
        --game.ram.set.battle_state(0x10);
        game.ram.set.battle_paused(0x01);
        --game.ram.set.battle_paused_also(0x08);
    end
end

function game.battle_unpause()
    if game.get_battle_state() == 0x0C then
        --game.ram.set.battle_state(0x0C);
        game.ram.set.battle_paused(0x00);
        --game.ram.set.battle_paused_also(0x00);
    end
end

game.folder_state_names       = {};
game.folder_state_names[0x04] = "editing";
game.folder_state_names[0x14] = "sorting";
game.folder_state_names[0x10] = "to_pack";
game.folder_state_names[0x0C] = "to_folder";
game.folder_state_names[0x08] = "exited";
game.folder_state_previous = 0x00;

function game.get_folder_state()
    return game.ram.get.folder_menu_state();
end

function game.get_folder_state_name()
    return game.folder_state_names[game.get_folder_state()] or "unknown_folder_state";
end

function game.folder_state_changed()
    return game.get_folder_state() ~= game.folder_state_previous;
end

function game.folder_to_pack()
    return game.ram.get.folder_to_pack();
end

function game.in_folder()
    return game.folder_to_pack() == 0x20;
end

function game.in_pack()
    return game.folder_to_pack() == 0x02;
end

function game.in_title()
    return game.get_game_state() == 0x00;
end

function game.in_world()
    return game.get_game_state() == 0x04;
end

function game.in_battle()
    return game.get_game_state() == 0x08;
end

function game.in_transition()
    return game.get_game_state() == 0x0C;
end

function game.in_splash()
    return (game.get_game_state() == 0x14 or game.get_game_state() == 0x2C);
end

function game.in_menu()
    return game.get_game_state() == 0x18;
end

function game.in_shop()
    return game.get_game_state() == 0x1C;
end

function game.in_game_over()
  return game.get_game_state() == 0x20;
end

function game.in_chip_trader()
  return game.get_game_state() == 0x24;
end

function game.in_credits()
    return game.get_game_state() == 0x28;
end

---------------------------------------- RNG ----------------------------------------

function game.get_RNG_value()
    return game.ram.get.RNG_value();
end

function game.set_RNG_value(new_rng)
    game.ram.set.RNG_value(new_rng);
end

function game.get_RNG_index()
    return game.ram.get.RNG_index();
end

function game.set_RNG_index(new_index)
    game.ram.set.RNG_index(new_index)
end

function game.get_RNG_delta()
    return game.ram.get.RNG_delta();
end

function game.adjust_RNG(steps)
    game.ram.adjust_RNG(steps);
end

---------------------------------------- Progress ----------------------------------------

function game.get_progress()
    return game.ram.get.progress();
end

function game.get_progress_name(progress_value)
    return game.progress[progress_value] or "Unknown Progress Value";
end

function game.get_current_progress_name()
    return game.get_progress_name(game.get_progress());
end

function game.set_progress(new_progress)
    if new_progress < 0x00 then
        new_progress = 0x00;
    elseif new_progress > 0x5F then
        new_progress = 0x5F;
    end
    game.ram.set.progress(new_progress);
end

function game.set_progress_safe(new_progress)
    if game.get_progress_name(new_progress) then
        game.set_progress(new_progress);
    end
end

function game.add_progress(some_progress)
    return game.set_progress(game.get_progress() + some_progress);
end

---------------------------------------- Flags ----------------------------------------

function game.get_fire_flags()
    return game.ram.get.fire_flags();
end

function game.set_fire_flags(fire_flags)
    game.ram.set.fire_flags(fire_flags);
end

function game.ignite_oven_fires()
    game.ram.set.fire_flags     (0x00000000);
    game.ram.set.fire_flags_oven(0x00000000);
end

function game.extinguish_oven_fires()
    game.ram.set.fire_flags     (0xFFCFFFFF);
    game.ram.set.fire_flags_oven(0xFFCFFFFF);
end

function game.ignite_WWW_fires()
    game.ram.set.fire_flags    (0x00000000);
    game.ram.set.fire_flags_www(0x00000000);
end

function game.extinguish_WWW_fires()
    game.ram.set.fire_flags    (0x00FEFFFF);
    game.ram.set.fire_flags_www(0xFCFFFF01);
end

function game.get_star_byte()
    return game.ram.get.title_star_byte();
end

function game.set_star_byte(new_star_byte)
    game.ram.set.title_star_byte(new_star_byte);
end

function game.get_star_flag()
    return bit.rshift(bit.band(game.get_star_byte(), 0x04), 2);
end

function game.set_star_flag()
    game.set_star_byte(bit.set(game.get_star_byte(), 2));
end

function game.clear_star_flag()
    game.set_star_byte(bit.band(game.get_star_byte(), 0xFB));
end

function game.get_magic_byte()
    return game.ram.get.magic_byte();
end

function game.set_magic_byte(new_magic)
    game.ram.set.magic_byte(new_magic);
end

function game.is_magic_bit_set()
    return bit.band(game.get_magic_byte(), 0x18) == 0x10;
end

function game.is_go_mode()
    return game.is_magic_bit_set() and (game.get_progress() == 0x54);
end

function game.go_mode()
    game.set_progress(0x54);
    game.set_magic_byte(0x10);
end

---------------------------------------- Position ----------------------------------------

function game.get_main_area()
    return game.ram.get.main_area();
end

function game.set_main_area(new_main_area)
    game.ram.set.main_area(new_main_area);
end

function game.get_sub_area()
    return game.ram.get.sub_area();
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

function game.get_current_area_name()
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

function game.get_X()
    return game.ram.get.your_X();
end

function game.get_Y()
    return game.ram.get.your_Y();
end

function game.get_steps()
    return game.ram.get.steps();
end

function game.set_steps(new_steps)
    if new_steps < 0 then
        new_steps = 0
    elseif new_steps > 0xFFFFFF then
        new_steps = 0xFFFFFF;
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
    elseif new_check > 0xFFFFFF then
        new_check = 0xFFFFFF;
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

function game.get_PowerUPs()
    return game.ram.get.PowerUP();
end

function game.set_PowerUPs(new_PowerUPs)
    if new_PowerUPs < 0 then
        new_PowerUPs = 0
    elseif new_PowerUPs > 50 then
        new_PowerUPs = 50;
    end
    game.ram.set.PowerUP(new_PowerUPs);
end

function game.add_PowerUPs(some_PowerUPs)
    game.set_PowerUPs(game.get_PowerUPs() + some_PowerUPs);
end

function game.get_IceBlocks()
    return game.ram.get.IceBlock();
end

function game.set_IceBlocks(new_IceBlocks)
    if new_IceBlocks < 0 then
        new_IceBlocks = 0
    elseif new_IceBlocks > 53 then
        new_IceBlocks = 53;
    end
    game.ram.set.IceBlock(new_IceBlocks);
end

function game.add_IceBlocks(some_IceBlocks)
    game.set_IceBlocks(game.get_IceBlocks() + some_IceBlocks);
end

---------------------------------------- Battlechips ----------------------------------------

function game.get_chip_name(ID)
    return game.chips.names[ID] or "Unknown Chip ID";
end

function game.get_chip_code(code)
    return game.chips.codes[code] or "Unknown Chip Code";
end

function game.count_library()
    local count = 0;
    for i=0,0x1F do
        local byte = game.ram.get.library(i);
        for i=0,7 do
            if bit.check(byte, i) then
                count = count + 1;
            end
        end
    end
    return count;
end

function game.get_battlechip_count()
    -- TODO
end

function game.set_all_folder_to_ID(chip_ID)
    for i=0,29 do
        game.ram.set.folder_ID(i, chip_ID);
    end
end

function game.randomize_folder_IDs()
    for i=0,29 do
        game.ram.set.folder_ID(i, game.chips.get_random_ID_standard());
    end
end

function game.set_all_folder_to_code(chip_code)
    for i=0,29 do
        game.ram.set.folder_code(i, chip_code);
    end
end

function game.randomize_folder_codes()
    for i=0,29 do
        game.ram.set.folder_code(i, game.chips.get_random_code());
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

function game.is_chip_selected()
    return game.ram.get.chip_selected_flag() ~= 0x00;
end

function game.get_selected_chip_location_name()
    local selected_flag = game.ram.get.chip_selected_flag();
    if selected_flag == 0x01 then
        return "Folder";
    elseif selected_flag == 0x02 then
        return "Pack";
    end
    return "None";
end

function game.get_selected_ID()
    local selected_chip_location = game.get_selected_chip_location_name();
    if selected_chip_location == "Folder" then
        return game.ram.get.folder_ID(game.get_cursor_offset_selected()+game.get_cursor_position_selected());
    elseif selected_chip_location == "Pack" then
        return game.ram.get.pack_ID(game.get_cursor_offset_selected()+game.get_cursor_position_selected());
    end
    return -1;
end

function game.get_selected_code()
    local selected_chip_location = game.get_selected_chip_location_name();
    if selected_chip_location == "Folder" then
        return game.ram.get.folder_code(game.get_cursor_offset_selected()+game.get_cursor_position_selected());
    elseif selected_chip_location == "Pack" then
        return game.ram.get.pack_code(game.get_cursor_offset_selected()+game.get_cursor_position_selected());
    end
    return -1;
end

----------------------------------------Mega Modifications ----------------------------------------

function game.set_buster_stats(power_level)
    game.ram.set.buster_attack(power_level);
    game.ram.set.buster_rapid (power_level);
    game.ram.set.buster_charge(power_level);
end

function game.reset_buster_stats()
    game.set_buster_stats(0); -- 0 indexed
end

function game.max_buster_stats()
    game.set_buster_stats(4);
end

function game.hub_buster_stats()
    game.set_buster_stats(5); -- super armor
end

function game.op_buster_stats()
    game.set_buster_stats(7); -- 327 buster shots
end

function game.give_armor()
    game.ram.set.armor_heat(1);
    game.ram.set.armor_aqua(1);
    game.ram.set.armor_wood(1);
end

function game.get_HPMemory_count()
    return game.ram.get.HPMemory();
end

function game.calculate_max_HP()
    return 100 + (20 * game.get_HPMemory_count());
end

function game.calculate_mega_level()
    level = 1; -- starting level
    level = level + 1 * game.get_HPMemory_count();
    level = level + 3 * game.ram.get.buster_attack();
    level = level + 3 * game.ram.get.buster_rapid();
    level = level + 3 * game.ram.get.buster_charge();
    level = level + 6 * game.ram.get.armor_heat();
    level = level + 6 * game.ram.get.armor_aqua();
    level = level + 6 * game.ram.get.armor_wood();
    return level;
end

----------------------------------------Battle Information ----------------------------------------

function game.get_battle_pointer()
    return game.ram.get.battle_pointer();
end

function game.get_enemy_ID(which_enemy)
    return game.ram.get.enemy_ID(which_enemy-1);
end

function game.get_enemy_name(which_enemy)
    return game.enemies.names[game.get_enemy_ID(which_enemy)] or "Unknown Enemy";
end

function game.get_enemy_HP(which_enemy)
    return game.ram.get.enemy_HP(which_enemy-1);
end

function game.set_enemy_HP(which_enemy, new_HP)
    game.ram.set.enemy_HP(which_enemy-1, new_HP);
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

function game.max_chip_window_count()
    game.ram.set.chip_window_count(15);
end

function game.get_delete_timer()
    return game.ram.get.delete_timer();
end

function game.set_delete_timer(new_delete_timer)
    if new_delete_timer < 0 then
        new_delete_timer = 0;
    end
    game.ram.set.delete_timer(new_delete_timer);
end

function game.reset_delete_timer()
    game.set_delete_timer(0);
end

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
    local RNG_index = game.get_RNG_index() or "????";
    local slots_text = string.format("%s:", RNG_index);
    for i=1,30 do
        slots_text = string.format("%s %02u", slots_text, slots[i]);
    end
    return slots_text;
end

function game.get_draw_slots_text_multi_line()
    local slots = game.get_draw_slots();
    local RNG_index = game.get_RNG_index() or "????";
    local slots_text = string.format("%s:", RNG_index);
    for i=1,30 do
        slots_text = string.format("%s\n%02u: %02u", slots_text, i, slots[i]);
    end
    return slots_text;
end

function game.shuffle_folder()
    -- TODO: Literally shuffle your folder
end

function game.shuffle_folder_simulate(battle_RNG_index)
    return game.ram.shuffle_folder_simulate(battle_RNG_index);
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

function game.draw_slot_check(chip_ID, draw_depth)
    for i=0,draw_depth-1 do
        if game.ram.get.folder_ID(game.ram.get.draw_slot(i)) == chip_ID then
            return true;
        end
    end
    return false;
end

function game.find_first(chip_ID)
    for i=0,29 do
        if game.ram.get.folder_ID(game.ram.get.draw_slot(i)) == chip_ID then
            return i;
        end
    end
    return -1;
end

---------------------------------------- Miscellaneous ----------------------------------------

function game.get_door_code()
    return game.ram.get.door_code();
end

function game.set_door_code(new_door_code)
    game.ram.set.door_code(new_door_code);
end

function game.near_number_doors() -- NumberMan Scenario or WWW Comp 2
    return (0x12 <= game.get_progress() and game.get_progress() <= 0x15) or (game.get_main_area() == 0x85 and game.get_sub_area() == 0x01);
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

---------------------------------------- Encounter Tracking and Avoidance ----------------------------------------

local last_encounter_check = 0; -- the previous value of check

function game.get_encounter_checks()
    return math.floor(last_encounter_check / 64); -- approximate
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
    return (game.get_encounter_threshold() / 32) * 100;
end

function game.would_get_encounter()
    -- 0xBC61AB0C no encounters
    -- 0x439E54F2 yes encounters
    return game.get_encounter_threshold() > (game.get_RNG_value() % 0x20);
end

game.skip_encounters = false;

local function encounter_check()
    if game.in_world() then
        if game.get_check() < last_encounter_check then
            last_encounter_check = 0; -- dodged encounter or area (re)load or state load
        elseif game.get_check() > last_encounter_check then
            last_encounter_check = game.get_check();
        end
        
        if game.skip_encounters then
            if game.get_steps() > 64 then
                game.set_steps(game.get_steps() % 64);
                game.set_check(game.get_check() % 64);
            end
        end
    end
end

---------------------------------------- Module Controls ----------------------------------------

function game.initialize(options)
    game.ram.initialize(options);
end

function game.update_pre(options)
    encounter_check();
    options.no_chip_cooldown = no_chip_cooldown;
    game.ram.update_pre(options);
end

function game.update_post(options)
    game.ram.update_post(options);
    game.game_state_previous = game.get_game_state();
    game.battle_state_previous = game.get_battle_state();
    game.folder_state_previous = game.get_folder_state();
end

return game;

