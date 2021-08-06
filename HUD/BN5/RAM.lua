-- RAM Functions for MMBN 5 scripting, enjoy.

local ram = require("All/RAM");

ram.addr = require("BN5/Addresses");

ram.version_name = ram.addr.version_name;

------------------------------ Getters & Setters ------------------------------

ram.get.battle_pointer = function() return memory.read_u32_le(ram.addr.battle_pointer); end;
ram.set.battle_pointer = function(battle_pointer) memory.write_u32_le(ram.addr.battle_pointer, battle_pointer); end;

ram.set.bug_frags = function(bug_frags)
    memory.write_u32_le(ram.addr.bug_frags, bug_frags);
    memory.write_u32_le(ram.addr.bug_frags_mirror, bug_frags);
    memory.write_u32_le(ram.addr.bug_frags_anti_cheat, 0);
end;

ram.set.zenny = function(zenny)
    memory.write_u32_le(ram.addr.zenny, zenny);
    memory.write_u32_le(ram.addr.zenny_mirror, zenny);
    memory.write_u32_le(ram.addr.zenny_anti_cheat, 0);
end;

ram.get.enemy[1].ID = function() return memory.read_u16_le(ram.addr.enemy[1].ID); end;
ram.set.enemy[1].ID = function(enemy_ID) memory.write_u16_le(ram.addr.enemy[1].ID, enemy_ID); end;
ram.get.enemy[2].ID = function() return memory.read_u16_le(ram.addr.enemy[2].ID); end;
ram.set.enemy[2].ID = function(enemy_ID) memory.write_u16_le(ram.addr.enemy[2].ID, enemy_ID); end;
ram.get.enemy[3].ID = function() return memory.read_u16_le(ram.addr.enemy[3].ID); end;
ram.set.enemy[3].ID = function(enemy_ID) memory.write_u16_le(ram.addr.enemy[3].ID, enemy_ID); end;

function ram.get.curr_hp() return memory.read_u16_le(ram.addr.curr_HP) end
function ram.get.max_hp() return memory.read_u16_le(ram.addr.max_HP) end
function ram.get.karma() return memory.read_u16_le(ram.addr.karma) end

---------------------------------------- RAMsacking ----------------------------------------

function ram.use_fun_flags(fun_flags)
    if fun_flags.always_fullcust then
        ram.set.custom_gauge(0x4000);
    elseif fun_flags.always_emptycust then
        ram.set.custom_gauge(0x0000);
    end
    
    if fun_flags.delete_time_zero then
        ram.set.delete_timer(0);
    end
    
    if fun_flags.chip_selection_max then
        ram.set.chip_window_size(10);
    elseif fun_flags.chip_selection_one then
        ram.set.chip_window_size( 1);
    end
end

---------------------------------------- GMD Generation ----------------------------------------

local gmd = require("BN5/GMDTables");
local gmd_table = {};
local gmd_initial_seed = 0;

function ram.generate_gmds_simulate_from_value(RNG_value)
    gmd_initial_seed = RNG_value;

    -- Advance RNG 64 times (US) or 72 times (JP) to account for areas not currently listed in GMDTables.lua
    local advance_rng = 64;
    if ram.addr.version_name == "JP Colonel" or ram.addr.version_name == "JP Proto" then
        advance_rng = 72;
    end

    for i = 1, advance_rng do
        RNG_value = ram.simulate_RNG(RNG_value);
    end

    for i, rewards in ipairs(gmd.drop_table) do
        local probabilities = {32, 32, 32, 32, 32, 32, 32, 32};
        local contents = {};
        local location = {};

        for gmd = 1, 2 do
            local mod_value = 0;
            local total_prob = 0;

            -- Advance RNG for determining location
            RNG_value = ram.simulate_RNG(RNG_value);
            if bit.band(RNG_value, 0x3f) + 1 >= 32 then
                location[gmd] = 2;
            else
                location[gmd] = 1;
            end

            -- Advance RNG for determining contents
            RNG_value = ram.simulate_RNG(RNG_value);

            local modValue = 0;
            for j, prob in ipairs(probabilities) do
                mod_value = mod_value + prob;
            end

            local randomProb = (bit.band(RNG_value, 0xffff) % mod_value) + 1;

            for j, prob in ipairs(probabilities) do
                total_prob = total_prob + prob;
                if total_prob >= randomProb then
                    contents[gmd] = rewards[j];
                    probabilities[j] = 0;
                    break;
                end
            end
        end

        local area = gmd.areas[i];

        gmd_table[area] = {};
        gmd_table[area][1] = {
            location = location[1];
            contents = contents[1];
        };
        gmd_table[area][2] = {
            location = location[2];
            contents = contents[2];
        };
    end
end

function ram.get.gmd_table()
    return gmd_table;
end

function ram.get.gmd_initial_seed_index()
    return ram.get.main_RNG_index_of(gmd_initial_seed) or "?????";
end

function ram.get.gmd_initial_seed()
    return gmd_initial_seed;
end

---------------------------------------- Folder Shuffling ----------------------------------------

function ram.shuffle_folder_simulate_from_value(RNG_value, swaps)
    RNG_value = RNG_value or 0x873CA9E5;
    swaps = swaps or 30;
    for i=0,29 do
        ram.draw_slots[i] = i;
    end

    -- If reg chip, subtract 1 from number of swaps
    local reg_slot = ram.get.reg_slot();
    if reg_slot == 255 then
        for i=1,swaps do -- 60 in BN1, 30 in the rest
            RNG_value = ram.simulate_RNG(RNG_value);
            local slot_a = bit.band(RNG_value, 0x7FFFFFFF) % 30;
            RNG_value = ram.simulate_RNG(RNG_value);
            local slot_b = bit.band(RNG_value, 0x7FFFFFFF) % 30;
            ram.draw_slots[slot_a], ram.draw_slots[slot_b] = ram.draw_slots[slot_b], ram.draw_slots[slot_a];
        end
    else

        -- Swap slot 1 to the slot just before reg_slot, move others up 1;
        for i=0,reg_slot - 2 do
            ram.draw_slots[i] = ram.draw_slots[i + 1];
        end
        ram.draw_slots[reg_slot - 1] = 0;

        local slots_text = "";
        for i=0,29 do
            slots_text = string.format("%s %02u", slots_text, ram.draw_slots[i]);
        end

        print(slots_text);

        for i=1,(swaps - 1) do -- 60 in BN1, 30 in the rest
            RNG_value = ram.simulate_RNG(RNG_value);
            local slot_a = bit.band(RNG_value, 0x7FFFFFFF) % 29;
            if slot_a >= reg_slot then
                slot_a = slot_a + 1;
            end
            RNG_value = ram.simulate_RNG(RNG_value);
            local slot_b = bit.band(RNG_value, 0x7FFFFFFF) % 29;
            if slot_b >= reg_slot then
                slot_b = slot_b + 1;
            end
            ram.draw_slots[slot_a], ram.draw_slots[slot_b] = ram.draw_slots[slot_b], ram.draw_slots[slot_a];
        end

        -- Place reg chip at top, move other chips down.
        for i=reg_slot,0,-1 do
            ram.draw_slots[i] = ram.draw_slots[i - 1];
        end

        ram.draw_slots[0] = reg_slot;
    end

    return ram.draw_slots;
end

---------------------------------------- ACE Shenanigans ----------------------------------------

function ram.get.crossover_name() return memory.read_u32_le (ram.addr.crossover_name); end
function ram.get.crossover_desc_1() return memory.read_u32_le (ram.addr.crossover_desc); end
function ram.get.crossover_desc_2() return memory.read_u32_le (ram.addr.crossover_desc + 0x04); end
function ram.get.crossover_desc_3() return memory.read_u32_le (ram.addr.crossover_desc + 0x08); end

function ram.get.hand_buffer_chip_id_1() return memory.read_u16_le(ram.addr.hand_buffer); end
function ram.get.hand_buffer_chip_id_2() return memory.read_u16_le(ram.addr.hand_buffer + 0x02); end
function ram.get.hand_buffer_chip_id_3() return memory.read_u16_le(ram.addr.hand_buffer + 0x04); end
function ram.get.hand_buffer_chip_id_4() return memory.read_u16_le(ram.addr.hand_buffer + 0x06); end
function ram.get.hand_buffer_chip_id_5() return memory.read_u16_le(ram.addr.hand_buffer + 0x08); end

function ram.get.hand_buffer_chip_damage_1() return memory.read_u16_le(ram.addr.hand_buffer + 0x0C); end
function ram.get.hand_buffer_chip_damage_2() return memory.read_u16_le(ram.addr.hand_buffer + 0x0E); end
function ram.get.hand_buffer_chip_damage_3() return memory.read_u16_le(ram.addr.hand_buffer + 0x10); end
function ram.get.hand_buffer_chip_damage_4() return memory.read_u16_le(ram.addr.hand_buffer + 0x12); end
function ram.get.hand_buffer_chip_damage_5() return memory.read_u16_le(ram.addr.hand_buffer + 0x14); end

function ram.get.dark_mega_ai_combo_1() return memory.read_u32_le(ram.addr.dark_mega_ai_combos) end
function ram.get.dark_mega_ai_combo_1_x() return memory.read_s8(ram.addr.dark_mega_ai_combos) end
function ram.get.dark_mega_ai_combo_1_y() return memory.read_s8(ram.addr.dark_mega_ai_combos + 0x01) end
function ram.get.dark_mega_ai_combo_1_chip_id_1() return memory.read_u16_le(ram.addr.dark_mega_ai_combos + 0x02) end

function ram.get.dark_mega_ai_combo_2_x() return memory.read_s8(ram.addr.dark_mega_ai_combos + 0x10) end
function ram.get.dark_mega_ai_combo_2_y() return memory.read_s8(ram.addr.dark_mega_ai_combos + 0x11) end
function ram.get.dark_mega_ai_combo_2_chip_id_1() return memory.read_u16_le(ram.addr.dark_mega_ai_combos + 0x12) end

function ram.get.dark_mega_ai_combo_3_x() return memory.read_s8(ram.addr.dark_mega_ai_combos + 0x20) end
function ram.get.dark_mega_ai_combo_3_y() return memory.read_s8(ram.addr.dark_mega_ai_combos + 0x21) end
function ram.get.dark_mega_ai_combo_3_chip_id_1() return memory.read_u16_le(ram.addr.dark_mega_ai_combos + 0x22) end

function ram.get.dark_mega_ai_combo_4_x() return memory.read_s8(ram.addr.dark_mega_ai_combos + 0x30) end
function ram.get.dark_mega_ai_combo_4_y() return memory.read_s8(ram.addr.dark_mega_ai_combos + 0x31) end
function ram.get.dark_mega_ai_combo_4_chip_id_1() return memory.read_u16_le(ram.addr.dark_mega_ai_combos + 0x32) end

function ram.get.dark_mega_ai_combo_5_x() return memory.read_s8(ram.addr.dark_mega_ai_combos + 0x40) end
function ram.get.dark_mega_ai_combo_5_y() return memory.read_s8(ram.addr.dark_mega_ai_combos + 0x41) end
function ram.get.dark_mega_ai_combo_5_chip_id_1() return memory.read_u16_le(ram.addr.dark_mega_ai_combos + 0x42) end

function ram.get.navi_stats_buffer_base_hp() return memory.read_u16_le(ram.addr.navi_stats); end
function ram.get.navi_stats_buffer_curr_hp() return memory.read_u16_le(ram.addr.navi_stats + 0x02); end
function ram.get.navi_stats_buffer_max_hp() return memory.read_u16_le(ram.addr.navi_stats + 0x04); end
function ram.get.navi_stats_buffer_karma() return memory.read_u16_le(ram.addr.navi_stats + 0x06); end

---------------------------------------- Module Controls ----------------------------------------

function ram.initialize(options)
    ram.print_details();
    ram.main_RNG_table = ram.create_RNG_table(0xA338244F, options.maximum_RNG_index);
    ram.lazy_RNG_table = ram.create_RNG_table(0x873CA9E4, options.maximum_RNG_index);
end

function ram.pre_update(options)
    ram.use_fun_flags(options.fun_flags);
    ram.use_fun_flags_common(options.fun_flags);
    ram.expand_RNG_table(ram.main_RNG_table);
    ram.expand_RNG_table(ram.lazy_RNG_table);
end

function ram.post_update(options)
    ram.previous_main_RNG_value = ram.get.main_RNG_value();
    ram.previous_lazy_RNG_value = ram.get.lazy_RNG_value();
end

return ram;

