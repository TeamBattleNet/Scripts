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

