-- Common Functions for MMBN scripting, enjoy.

local game = require("All/GamePlayer");

game.ram      = {}; -- overridden later
game.areas    = {}; -- overridden later
game.chips    = {}; -- overridden later
game.enemies  = {}; -- overridden later
game.progress = {}; -- overridden later

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

function game.get_battle_level()
    return memory.read_u8(game.ram.get.battle_pointer() + 0x01);
end

function game.get_run_chance()
    local navi_level = math.ceil(game.ram.get.base_HP() / 5);
    local battle_level = game.get_battle_level();
    local run_count = game.ram.get.run_count();

    local odds = 0;
    if (navi_level > battle_level) then
        odds = 16;
    elseif (math.floor(navi_level * 1.5) > battle_level) then
        odds = memory.read_u8(game.ram.addr.run_chance_odds + 6 + run_count);
    elseif (navi_level * 2 > battle_level) then
        odds = memory.read_u8(game.ram.addr.run_chance_odds + 3 + run_count);
    else
        odds = memory.read_u8(game.ram.addr.run_chance_odds + run_count);
    end

    -- This block was in the mmbn6_walkframes lua script, unsure what its purpose is?
    if (bit.band(memory.read_u32_le(0x02009F38), 7) == 1) then
        odds = 0;
    end

    return (math.min(odds, 16) / 16) * 100;
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
    --slots = game.ram.get_simulated_draw_slots();
    local main_RNG_index = game.get_main_RNG_index() or "????";
    local slots_text = string.format("%s:", main_RNG_index);
    for i=1,30 do
        slots_text = string.format("%s %02u", slots_text, slots[i]);
    end
    return slots_text;
end

function game.get_draw_slots_text_multi_line()
    local slots = game.get_draw_slots();
    --slots = game.ram.get_simulated_draw_slots();
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

function game.track_encounter_checks()
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

---------------------------------------- Module Controls ----------------------------------------

function game.pre_update(options)
    -- should be overridden per game
end

function game.post_update(options)
    -- should be overridden per game
end

game.doit_later = {};

function game.update()
    game.track_game_state();
    game.track_encounter_checks();
    if  game.doit_later[emu.framecount()] then
        game.doit_later[emu.framecount()]();
        game.doit_later[emu.framecount()] = nil;
    end
    if game.in_credits() then gui.text(0, 0, "t r o u t", 0x10000000, "bottomright"); end
end

return game;

