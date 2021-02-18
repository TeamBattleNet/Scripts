-- Folder Shuffling Simulations for MMBN routing, enjoy.

local ram = {};

---------------------------------------- RNG Functions ----------------------------------------

function ram.to_int(seed)
    return bit.band(seed, 0x7FFFFFFF);
end

function ram.simulate_RNG(seed)
    -- seed = ((seed << 1) + (seed >> 31) + 1) ^ 0x873CA9E5;
    return bit.bxor((bit.lshift(seed,1) + bit.rshift(seed, 31) + 1), 0x873CA9E5);
end

function ram.reverse_RNG(seed)
    -- seed = (seed ^ 0x873CA9E5) - 1;
    seed = bit.bxor(seed, 0x873CA9E5) - 1;
    -- seed = (seed >> 1) + (seed << 31);
    seed = bit.rshift(seed,1) + bit.lshift(seed, 31);
    return seed;
end

function ram.iterate_RNG(seed, iterations)
    iterations = iterations or 1;
    for i=1,iterations do
        seed = ram.simulate_RNG(seed);
    end
    return seed;
end

---------------------------------------- RNG Index Tables----------------------------------------

ram.RNG_table = {}; -- not currently used

function ram.get_RNG_value_at(new_RNG_index)
    return ram.RNG_table.value[new_RNG_index];
end

function ram.get_RNG_index_of(new_RNG_value)
    return ram.RNG_table.index[new_RNG_value];
end

function ram.create_RNG_table(seed, max_index)
    print(string.format("Creating RNG Table with seed 0x%08X and max index of %u", seed, max_index));
    
    new_RNG_table = {};
    
    new_RNG_table.value = {};
    new_RNG_table.index = {};
    
    new_RNG_table.value[0] = 0;
    new_RNG_table.index[0] = 0;
    
    new_RNG_table.value[1] = seed;
    new_RNG_table.index[seed] = 1;
    
    new_RNG_table.current_index = 1;
    new_RNG_table.maximum_index = max_index;
    
    return new_RNG_table;
end

function ram.expand_RNG_table(RNG_table, by_this_many)
    if RNG_table.current_index < RNG_table.maximum_index then
        for i=1,math.min((RNG_table.maximum_index-RNG_table.current_index),by_this_many) do
            local RNG_next = ram.simulate_RNG(RNG_table.value[RNG_table.current_index]);
            
            RNG_table.current_index = RNG_table.current_index + 1;
            
            RNG_table.value[RNG_table.current_index] = RNG_next;
            RNG_table.index[RNG_next] = RNG_table.current_index;
        end
        if RNG_table.current_index >= RNG_table.maximum_index then
            print(string.format("\n%u: Created RNG Table for seed 0x%08X with final index of %i", emu.framecount(), RNG_table.value[1], RNG_table.current_index));
        end
    end
end

---------------------------------------- Folder Shuffling ----------------------------------------

ram.draw_slots = {};

for i=1,30 do
    ram.draw_slots[i] = i;
end

function ram.shuffle_folder_simulate_from_value(temp_RNG_value, swaps)
    for i=1,30 do
        ram.draw_slots[i] = i; -- starts sorted
    end
    for i=1,swaps do -- 60 in BN1, 30 in the rest
        local slot_a = ( ram.to_int( bit.rshift( temp_RNG_value,1 ) ) % 30 ) + 1;
        temp_RNG_value = ram.simulate_RNG(temp_RNG_value);
        local slot_b = ( ram.to_int( bit.rshift( temp_RNG_value,1 ) ) % 30 ) + 1;
        temp_RNG_value = ram.simulate_RNG(temp_RNG_value);
        ram.draw_slots[slot_a], ram.draw_slots[slot_b] = ram.draw_slots[slot_b], ram.draw_slots[slot_a];
    end
    return ram.draw_slots;
end

---------------------------------------- Draw Slots ----------------------------------------

function ram.get_draw_slots_text_one_line()
    local slots_text = "";
    for i=1,30 do
        slots_text = string.format("%s %02u", slots_text, ram.draw_slots[i]);
    end
    return slots_text;
end

function ram.get_draw_slots_text_multi_line()
    local slots_text = "";
    for i=1,30 do
        slots_text = string.format("%02u: %02u\n", slots_text, i, ram.draw_slots[i]);
    end
    return slots_text;
end

function ram.find_slot(folder_slot)
    for i=1,30 do
        if ram.draw_slots[i] == folder_slot then
            return i;
        end
    end
    return -1;
end

function ram.depth_check(folder_slot, draw_depth)
    return (ram.find_first(folder_slot) <= draw_depth);
end

function ram.is_sneakrun_bugged()
    return true;
end

---------------------------------------- Encounter Check ----------------------------------------

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
    BugRun uses Curve 00
--]]

function ram.get_encounter_curve()
    return 0;
end

function ram.get_encounter_threshold()
    return 0x1C;
end

function ram.get_encounter_chance()
    return ram.get_encounter_threshold() / 32;
end

function ram.get_encounter_percent()
    return ram.get_encounter_chance() * 100;
end

function ram.would_get_encounter(check_RNG_value)
    return ram.get_encounter_threshold() > (check_RNG_value % 0x20); -- (1C is 87.5%)
end

-- ram.would_get_encounter(0x439E54F2); -- true
-- 0x439E54F2 01000011100111100101010011110010 input
-- 0x873CA9E4 10000111001111001010100111100100 lshift
-- 0x873CA9E5 10000111001111001010100111100101 add+1
-- 0x873CA9E5 10000111001111001010100111100101 xor
-- 0x00000000 00000000000000000000000000000000 yes encounter

-- ram.would_get_encounter(0xBC61AB0C); -- false
-- 0xBC61AB0C 10111100011000011010101100001100 input
-- 0x78C35619 01111000110000110101011000011001 lshift
-- 0x78C3561A 01111000110000110101011000011010 add+1
-- 0x873CA9E5 10000111001111001010100111100101 xor
-- 0xFFFFFFFF 11111111111111111111111111111111 no encounter

-- TODO: simulate threshold needed for each RNG value
-- TODO: steps needed to hit that threshold per curve

---------------------------------------- Module Controls ----------------------------------------

-- [[ BN 1 Folder Shuffling

local swaps = 60;
local RNG_index = 1;
local RNG_value = 0xA338244F;
--local RNG_value = 0x873CA9E4;
local target_RNG_index = 9999;
local calculations_per_frame = 200;

local log_file = io.open("logs/draws.txt", "w");

-- 376 4615
--  34  153 (120 + 33)
-- 410 4768

-- overworld fights perform 1 more RNG call than cutscene fights
-- this index is tuned to overworld fights, so cutscene draws will appear to be +1 (1564 maps to 1565)

function ram.simulate_draws()
    for i=1,calculations_per_frame do
        ram.shuffle_folder_simulate_from_value(RNG_value, swaps);
        local draw_slots = ram.get_draw_slots_text_one_line();
        log_file:write(string.format("%04i:%s\n", RNG_index+120, draw_slots));
        RNG_value = ram.simulate_RNG(RNG_value);
        RNG_index = RNG_index + 1;
    end
end

while RNG_index < target_RNG_index do
    ram.simulate_draws();
    emu.frameadvance();
end

log_file:close();

print("Simulations finished");

--local battle_index = 1564;
--local battle_value = ram.iterate_RNG(0xA338244F, battle_index-121);
--ram.shuffle_folder_simulate_from_value(battle_value, 60);
--print(string.format("%04i:%s\n", battle_index, ram.get_draw_slots_text_one_line()));
-- 1564: 01 09 18 12 13 30 24 21 06 26 07 03 14 25 28 29 15 19 11 16 04 08 02 20 22 17 10 27 05 23

--]]

