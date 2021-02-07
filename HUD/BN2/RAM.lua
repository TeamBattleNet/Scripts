-- RAM Functions for MMBN 2 scripting, enjoy.

local ram = require("All/RAM");

ram.addr = require("BN2/Addresses");
ram.version_name = ram.addr.version_name;

------------------------------ Getters & Setters ------------------------------

-- ram.get = {}; -- defined in All/RAM
-- ram.set = {}; -- defined in All/RAM

ram.get.battle_paused = function() return memory.read_u8(ram.addr.battle_paused); end;
ram.set.battle_paused = function(battle_paused) memory.write_u8(ram.addr.battle_paused, battle_paused); end;

ram.get.bug_frags = function() return memory.read_u8(ram.addr.bug_frags); end;
ram.set.bug_frags = function(bug_frags) memory.write_u8(ram.addr.bug_frags, bug_frags); end;

ram.get.draw_slot = function(which_slot) return memory.read_u8(ram.addr.battle_draw_slots+which_slot); end;
ram.set.draw_slot = function(which_slot, battle_draw_slot) memory.write_u8(ram.addr.battle_draw_slots+which_slot, battle_draw_slot); end;

ram.get.folder_count = function() return memory.read_u8(ram.addr.folder_count); end;
ram.set.folder_count = function(folder_count) memory.write_u8(ram.addr.folder_count, folder_count); end;

ram.get.ice_flags = function() return memory.read_u32_le(ram.addr.ice_flags); end;
ram.set.ice_flags = function(ice_flags) memory.write_u32_le(ram.addr.ice_flags, ice_flags); end;

ram.get.HPMemory = function() return memory.read_u8(ram.addr.HPMemory); end;
ram.set.HPMemory = function(HPMemory) memory.write_u8(ram.addr.HPMemory, HPMemory); end;

ram.get.library = function(offset) return memory.read_u8(ram.addr.library+offset); end;
ram.set.library = function(offset, bit_flags) memory.write_u8(ram.addr.library+offset, bit_flags); end;

ram.get.pack_ID = function(which_slot) return memory.read_u8(ram.addr.pack_ID+(0x20*which_slot)); end;
ram.set.pack_ID = function(which_slot, chip_ID) memory.write_u8(ram.addr.pack_ID+(0x20*which_slot), chip_ID); end;
ram.get.pack_code = function(which_slot) return memory.read_u8(ram.addr.pack_code+(0x20*which_slot)); end;
ram.set.pack_code = function(which_slot, chip_code) memory.write_u8(ram.addr.pack_code+(0x20*which_slot), chip_code); end;
ram.get.pack_quantity = function(which_slot) return memory.read_u8(ram.addr.pack_quantity+(0x20*which_slot)); end;
ram.set.pack_quantity = function(which_slot, chip_quantity) memory.write_u8(ram.addr.pack_quantity+(0x20*which_slot), chip_quantity); end;

ram.get.PowerUP = function() return memory.read_u8(ram.addr.PowerUP); end;
ram.set.PowerUP = function(PowerUP) memory.write_u8(ram.addr.PowerUP, PowerUP); end;

ram.get.title_star_byte = function() return memory.read_u8(ram.addr.title_star_byte); end;
ram.set.title_star_byte = function(title_star_byte) memory.write_u8(ram.addr.title_star_byte, title_star_byte); end;

---------------------------------------- RNG Functions ----------------------------------------

local rng_table = nil;

function ram.get.RNG_value()
    return memory.read_u32_le(ram.addr.RNG);
end

function ram.get.RNG_value_at(new_RNG_index)
    return rng_table.value[new_RNG_index];
end

function ram.set.RNG_value(new_RNG_value)
    memory.write_u32_le(ram.addr.RNG, new_RNG_value);
end

function ram.get.RNG_index_of(new_RNG_value)
    return rng_table.index[new_RNG_value];
end

function ram.get.RNG_index()
    return ram.get.RNG_index_of(ram.get.RNG_value());
end

function ram.set.RNG_index(new_RNG_index)
    new_RNG_value = ram.get.RNG_value_at(new_RNG_index);
    if new_RNG_value then
        ram.set.RNG_value(new_RNG_value);
    end
end

local previous_RNG_value = 0;

function ram.get.RNG_delta()
    return ram.calculate_RNG_delta(previous_RNG_value, ram.get.RNG_value());
end

function ram.adjust_RNG(steps)
    local RNG_index = ram.get.RNG_index();
    
    if not RNG_index then
        return;
    end
    
    local new_index = RNG_index + steps;
    
    if new_index < 1 then -- steps could be negative
        new_index = 1;
    end
    
    if new_index > rng_table.current_RNG_index then
        new_index = rng_table.current_RNG_index;
    end
    
    ram.set.RNG_index(new_index);
end

---------------------------------------- RAMsacking ----------------------------------------

local function use_fun_flags(fun_flags)
    if fun_flags.always_fullcust then
        ram.set.custom_gauge(0x4000);
    end
    
    if fun_flags.no_chip_cooldown then
        ram.set.chip_cooldown(0);
    end
    
    if fun_flags.delete_time_zero then
        ram.set.delete_timer(0);
    end
    
    if fun_flags.chip_selection_max then
        ram.set.chip_window_size(10);
    elseif fun_flags.chip_selection_one then
        ram.set.chip_window_size( 1);
    end
    
    if fun_flags.no_encounters then
        ram.set.RNG_value(0xBC61AB0C);
    elseif fun_flags.yes_encounters then
        ram.set.RNG_value(0x439E54F2);
    end
    
    if fun_flags.modulate_steps then
        if ram.get.steps() > 64 then
            ram.set.steps(ram.get.steps() % 64);
            ram.set.check(ram.get.check() % 64);
        end
    end
end

---------------------------------------- Module Controls ----------------------------------------

function ram.initialize(options)
    rng_table = ram.create_RNG_table(0xC14CE145, options.maximum_RNG_index);
    print("\nCalculating RNG with max calculations per frame of: " .. ram.calculations_per_frame);
end

function ram.update_pre(options)
    use_fun_flags(options.fun_flags);
    ram.expand_RNG_table(rng_table);
end

function ram.update_post(options)
    previous_RNG_value = ram.get.RNG_value();
end

return ram;

