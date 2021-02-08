-- RAM Functions for MMBN 3 scripting, enjoy.

local ram = require("All/RAM");

ram.addr = require("BN3/Addresses");

ram.version_name = ram.addr.version_name;

------------------------------ Getters & Setters ------------------------------

-- ram.get = {}; -- defined in All/RAM
-- ram.set = {}; -- defined in All/RAM

ram.get.draw_slot = function(which_slot) return memory.read_u8(ram.addr.battle_draw_slots+which_slot); end;
ram.set.draw_slot = function(which_slot, folder_slot) memory.write_u8(ram.addr.battle_draw_slots+which_slot, folder_slot); end;

ram.get.fire_flags = function() return memory.read_u32_le(ram.addr.fire_flags); end;
ram.set.fire_flags = function(fire_flags) memory.write_u32_le(ram.addr.fire_flags, fire_flags); end;

ram.get.pack_ID = function(which_slot) return memory.read_u8(ram.addr.pack_ID+(0x20*which_slot)); end;
ram.set.pack_ID = function(which_slot, chip_ID) memory.write_u8(ram.addr.pack_ID+(0x20*which_slot), chip_ID); end;
ram.get.pack_code = function(which_slot) return memory.read_u8(ram.addr.pack_code+(0x20*which_slot)); end;
ram.set.pack_code = function(which_slot, chip_code) memory.write_u8(ram.addr.pack_code+(0x20*which_slot), chip_code); end;
ram.get.pack_quantity = function(which_slot) return memory.read_u8(ram.addr.pack_quantity+(0x20*which_slot)); end;
ram.set.pack_quantity = function(which_slot, chip_quantity) memory.write_u8(ram.addr.pack_quantity+(0x20*which_slot), chip_quantity); end;

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
        ram.set.main_RNG_value(0xBC61AB0C);
    elseif fun_flags.yes_encounters then
        ram.set.main_RNG_value(0x439E54F2);
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
    ram.main_RNG_table = ram.create_RNG_table(0xA338244F, options.maximum_RNG_index);
    ram.lazy_RNG_table = ram.create_RNG_table(0x873CA9E4, options.maximum_RNG_index);
    print("\nCalculating RNG with max calculations per frame of: " .. ram.calculations_per_frame);
end

function ram.update_pre(options)
    use_fun_flags(options.fun_flags);
    ram.expand_RNG_table(ram.main_RNG_table);
    ram.expand_RNG_table(ram.lazy_RNG_table);
end

function ram.update_post(options)
    ram.previous_main_RNG_value = ram.get.main_RNG_value();
    ram.previous_lazy_RNG_value = ram.get.lazy_RNG_value();
end

return ram;

