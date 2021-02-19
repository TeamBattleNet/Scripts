-- RNG Functions for MMBN scripting, enjoy.

local ram  = {};

ram.get = {};
ram.set = {};

ram.addr = {}; -- overridden later

-- careful tweaking these
ram.index_calculations_per_frame = 100;
ram.delta_calculations_per_frame = 300;
ram.loop_calculations_per_frame = 1000;

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

function ram.iterate_RNG(seed, iterations, backwards)
    iterations = iterations or 1;
    for i=1,math.min(iterations,ram.loop_calculations_per_frame) do
        if backwards then
            seed = ram.reverse_RNG(seed);
        else
            seed = ram.simulate_RNG(seed);
        end
    end
    return seed;
end

function ram.calculate_RNG_delta(temp, goal)
    for delta=0,ram.delta_calculations_per_frame do
        if temp == goal then
            return delta;
        end
        temp = ram.simulate_RNG(temp);
    end
    return nil;
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

function ram.expand_RNG_table(RNG_table)
    if RNG_table.current_index < RNG_table.maximum_index then
        for i=1,math.min((RNG_table.maximum_index-RNG_table.current_index),ram.index_calculations_per_frame) do
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

---------------------------------------- RNG Index Tables----------------------------------------

-- Main RNG

ram.main_RNG_table = {};

function ram.get.main_RNG_value()
    return memory.read_u32_le(ram.addr.main_RNG);
end

function ram.get.main_RNG_value_at(new_main_RNG_index)
    return ram.main_RNG_table.value[new_main_RNG_index];
end

function ram.set.main_RNG_value(new_main_RNG_value)
    memory.write_u32_le(ram.addr.main_RNG, new_main_RNG_value);
end

function ram.get.main_RNG_index_of(new_main_RNG_value)
    return ram.main_RNG_table.index[new_main_RNG_value]; -- could be nil
end

function ram.get.main_RNG_index()
    return ram.get.main_RNG_index_of(ram.get.main_RNG_value());
end

function ram.set.main_RNG_index(new_main_RNG_index)
    new_main_RNG_value = ram.get.main_RNG_value_at(new_main_RNG_index);
    if new_main_RNG_value then
        ram.set.main_RNG_value(new_main_RNG_value);
    end
end

function ram.adjust_main_RNG(steps)
    local main_RNG_index = ram.get.main_RNG_index();
    
    if not main_RNG_index then
        return;
    end
    
    local new_index = main_RNG_index + steps;
    
    if new_index < 1 then -- steps could be negative
        new_index = 1;
    end
    
    if new_index > ram.main_RNG_table.current_index then
        new_index = ram.main_RNG_table.current_index;
    end
    
    ram.set.main_RNG_index(new_index);
end

ram.previous_main_RNG_value = 0;

function ram.get.main_RNG_delta()
    return ram.calculate_RNG_delta(ram.previous_main_RNG_value, ram.get.main_RNG_value());
end

-- Lazy RNG

ram.lazy_RNG_table = {};

function ram.get.lazy_RNG_value()
    return memory.read_u32_le(ram.addr.lazy_RNG);
end

function ram.get.lazy_RNG_value_at(new_lazy_RNG_index)
    return ram.lazy_RNG_table.value[new_lazy_RNG_index];
end

function ram.set.lazy_RNG_value(new_lazy_RNG_value)
    memory.write_u32_le(ram.addr.lazy_RNG, new_lazy_RNG_value);
end

function ram.get.lazy_RNG_index_of(new_lazy_RNG_value)
    return ram.lazy_RNG_table.index[new_lazy_RNG_value]; -- could be nil
end

function ram.get.lazy_RNG_index()
    return ram.get.lazy_RNG_index_of(ram.get.lazy_RNG_value());
end

function ram.set.lazy_RNG_index(new_lazy_RNG_index)
    new_lazy_RNG_value = ram.get.lazy_RNG_value_at(new_lazy_RNG_index);
    if new_lazy_RNG_value then
        ram.set.lazy_RNG_value(new_lazy_RNG_value);
    end
end

function ram.adjust_lazy_RNG(steps)
    local lazy_RNG_index = ram.get.lazy_RNG_index();
    
    if not lazy_RNG_index then
        return;
    end
    
    local new_index = lazy_RNG_index + steps;
    
    if new_index < 1 then -- steps could be negative
        new_index = 1;
    end
    
    if new_index > ram.lazy_RNG_table.current_index then
        new_index = ram.lazy_RNG_table.current_index;
    end
    
    ram.set.lazy_RNG_index(new_index);
end

ram.previous_lazy_RNG_value = 0;

function ram.get.lazy_RNG_delta()
    return ram.calculate_RNG_delta(ram.previous_lazy_RNG_value, ram.get.lazy_RNG_value());
end

---------------------------------------- Folder Shuffling ----------------------------------------

ram.draw_slots = {};

for i=0,29 do
    ram.draw_slots[i] = i; -- initialize
end

ram.get.draw_slot = function(which_slot) return ram.draw_slots[which_slot]; end;
ram.set.draw_slot = function(which_slot, folder_slot) ram.draw_slots[which_slot] = folder_slot; end;

function ram.get_simulated_draw_slots()
    return ram.draw_slots;
end

function ram.update_draw_slots()
    for i=0,29 do
        ram.draw_slots[i] = memory.read_u8(ram.addr.battle_draw_slots+i);
    end
end
-- must register after ram.addr.battle_draw_slots is defined
-- ram.update_draw_slots_ref = event.onmemorywrite(ram.update_draw_slots, ram.addr.battle_draw_slots, "MMBN_draw_slots");

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

function ram.shuffle_folder_simulate_from_main_index(index, swaps)
    return ram.shuffle_folder_simulate_from_value(ram.get.main_RNG_value_at(index), swaps);
end

function ram.shuffle_folder_simulate_from_lazy_index(index, swaps)
    return ram.shuffle_folder_simulate_from_value(ram.get.lazy_RNG_value_at(index), swaps);
end

---------------------------------------- Module Controls ----------------------------------------

function ram.print_details()
    print("\nInitializing RNG...");
    print("Max index calculations per frame of: " .. ram.index_calculations_per_frame);
    print("Max delta calculations per frame of: " .. ram.delta_calculations_per_frame);
    print("Max loop calculations per frame of: " .. ram.loop_calculations_per_frame);
end

return ram;

